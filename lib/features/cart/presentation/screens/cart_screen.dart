import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/cart_bloc.dart';
import '../bloc/cart_event.dart';
import '../bloc/cart_state.dart';
import '../widgets/cart_item_card.dart';
import '../../../order/presentation/bloc/order_bloc.dart';
import '../../../order/presentation/bloc/order_event.dart';
import '../../../order/presentation/bloc/order_state.dart';
import '../../../order/presentation/screens/order_success_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final TextEditingController _promoController = TextEditingController();
  double _discountPercent = 0.0;
  bool _isPromoApplied = false;

  void _applyPromo() {
    if (_promoController.text.trim().toUpperCase() == 'MANTAP20') {
      setState(() {
        _discountPercent = 20.0;
        _isPromoApplied = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Promo code applied successfully! 🎉 20% off'),
          backgroundColor: Theme.of(context).primaryColor,
          behavior: SnackBarBehavior.floating,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invalid promo code! Try MANTAP20'),
          backgroundColor: Colors.redAccent,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  void _showCheckoutDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Theme.of(context).cardTheme.color,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: const Padding(
            padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 20),
                Text(
                  'Processing Order...',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                SizedBox(height: 8),
                Text(
                  'Please wait while we prepare your gourmet basket',
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  String _formatPrice(double price) {
    return 'Rp ${price.toInt().toString().replaceAllMapped(RegExp(r"(\d{1,3})(?=(\d{3})+(?!\d))"), (Match m) => "${m[1]}.")}';
  }

  @override
  void dispose() {
    _promoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<OrderBloc, OrderState>(
      listener: (context, orderState) {
        if (orderState is OrderProcessing) {
          _showCheckoutDialog();
        } else if (orderState is OrderSuccess) {
          // Close the loading dialog
          Navigator.of(context, rootNavigator: true).pop();
          
          // Clear current cart items
          context.read<CartBloc>().add(const ClearCart());
          
          // Route to success screen
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => OrderSuccessScreen(order: orderState.order),
            ),
          );
        } else if (orderState is OrderFailure) {
          // Close loading dialog
          Navigator.of(context, rootNavigator: true).pop();
          
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Order failed: ${orderState.message}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('My Gourmet Basket'),
          centerTitle: true,
        ),
        body: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            if (state is CartLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is CartLoaded) {
              final items = state.items;

              if (items.isEmpty) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardTheme.color,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.shopping_bag_outlined, size: 72, color: Colors.grey),
                        ),
                        const SizedBox(height: 24),
                        const Text(
                          'Your basket is empty!',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Looks like you haven\'t added any gourmet dishes yet.',
                          style: TextStyle(color: Colors.grey, fontSize: 14),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 32),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Start Shopping'),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }

              // Compute prices locally with discount multiplier
              final subtotal = state.subtotal;
              final deliveryFee = state.deliveryFee;
              final discountAmount = subtotal * (_discountPercent / 100);
              final totalAmount = subtotal + deliveryFee - discountAmount;

              return Column(
                children: [
                  // List of Items
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      itemCount: items.length,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        final item = items[index];
                        return CartItemCard(
                          item: item,
                          onQuantityChanged: (qty) {
                            context.read<CartBloc>().add(
                                  UpdateCartQuantity(foodId: item.food.id, quantity: qty),
                                );
                          },
                          onRemove: () {
                            context.read<CartBloc>().add(
                                  RemoveFromCart(foodId: item.food.id),
                                );
                          },
                        );
                      },
                    ),
                  ),

                  // Promo & Summary Bar
                  Container(
                    padding: const EdgeInsets.only(left: 20, right: 20, top: 16, bottom: 20),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardTheme.color,
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
                      border: Border(
                        top: BorderSide(color: Colors.white.withOpacity(0.04), width: 1),
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Promo Input Bar
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: _promoController,
                                enabled: !_isPromoApplied,
                                decoration: InputDecoration(
                                  hintText: _isPromoApplied ? 'Promo Applied! 20%' : 'Enter promo code (MANTAP20)',
                                  prefixIcon: const Icon(Icons.local_offer_outlined),
                                  contentPadding: const EdgeInsets.symmetric(vertical: 12),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                backgroundColor: _isPromoApplied ? Colors.green[800] : Theme.of(context).primaryColor,
                              ),
                              onPressed: _isPromoApplied ? null : _applyPromo,
                              child: Text(_isPromoApplied ? 'APPLIED' : 'APPLY'),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),

                        // Payment Summary breakdown
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Subtotal', style: TextStyle(color: Colors.grey)),
                            Text(_formatPrice(subtotal), style: const TextStyle(fontWeight: FontWeight.w600)),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Delivery Fee', style: TextStyle(color: Colors.grey)),
                            Text(_formatPrice(deliveryFee), style: const TextStyle(fontWeight: FontWeight.w600)),
                          ],
                        ),
                        if (_discountPercent > 0) ...[
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Promo Discount (20%)', style: TextStyle(color: Colors.green)),
                              Text('- ${_formatPrice(discountAmount)}', style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ],
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          child: Divider(color: Colors.white10),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Total Payment',
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            Text(
                              _formatPrice(totalAmount),
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.w800,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),

                        // Checkout Button
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              context.read<OrderBloc>().add(
                                    PlaceOrder(items: items, totalAmount: totalAmount),
                                  );
                            },
                            child: const Text('Checkout Now'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
