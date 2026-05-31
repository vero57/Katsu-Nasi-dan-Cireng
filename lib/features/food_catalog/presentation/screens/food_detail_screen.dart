import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/food_model.dart';
import '../../../cart/presentation/bloc/cart_bloc.dart';
import '../../../cart/presentation/bloc/cart_event.dart';
import '../../../cart/presentation/screens/cart_screen.dart';

class FoodDetailScreen extends StatefulWidget {
  final FoodModel food;

  const FoodDetailScreen({super.key, required this.food});

  @override
  State<FoodDetailScreen> createState() => _FoodDetailScreenState();
}

class _FoodDetailScreenState extends State<FoodDetailScreen> {
  int _quantity = 1;
  bool _isFavorite = false;

  void _incrementQuantity() {
    setState(() {
      _quantity++;
    });
  }

  void _decrementQuantity() {
    if (_quantity > 1) {
      setState(() {
        _quantity--;
      });
    }
  }

  String _formatPrice(double price) {
    return 'Rp ${price.toInt().toString().replaceAllMapped(RegExp(r"(\d{1,3})(?=(\d{3})+(?!\d))"), (Match m) => "${m[1]}.")}';
  }

  @override
  Widget build(BuildContext context) {
    final food = widget.food;
    final totalPrice = food.price * _quantity;

    return Scaffold(
      body: Stack(
        children: [
          // 1. Food Image Header
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: MediaQuery.of(context).size.height * 0.42,
            child: Hero(
              tag: 'food-img-${food.id}',
              child: Image.network(
                food.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: Colors.grey[900],
                  child: const Icon(Icons.fastfood, size: 80, color: Colors.grey),
                ),
              ),
            ),
          ),
          
          // 2. Custom Gradient Overlay for image readability
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 120,
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.black54, Colors.transparent],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),

          // 3. Navigation Header Buttons
          Positioned(
            top: MediaQuery.of(context).padding.top + 8,
            left: 16,
            right: 16,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 20),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _isFavorite = !_isFavorite;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      _isFavorite ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                      color: _isFavorite ? const Color(0xFFFF4D4D) : Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // 4. Content Sheet
          Positioned(
            top: MediaQuery.of(context).size.height * 0.38,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.only(top: 30, left: 24, right: 24),
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 15,
                    offset: const Offset(0, -5),
                  )
                ],
              ),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Category & Rating
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            food.category.toUpperCase(),
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            const Icon(Icons.star_rounded, color: Color(0xFFFFB03A), size: 22),
                            const SizedBox(width: 4),
                            Text(
                              food.rating.toString(),
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            const SizedBox(width: 4),
                            const Text(
                              '(150+ reviews)',
                              style: TextStyle(color: Colors.grey, fontSize: 12),
                            )
                          ],
                        )
                      ],
                    ),
                    const SizedBox(height: 16),
                    
                    // Food Name
                    Text(
                      food.name,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 8),
                    
                    // Price tag
                    Text(
                      _formatPrice(food.price),
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 20),
                    
                    // Description header
                    const Text(
                      'About this dish',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      food.description,
                      style: TextStyle(
                        color: Theme.of(context).textTheme.bodyMedium?.color,
                        fontSize: 14,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 24),
                    
                    // Ingredients
                    if (food.ingredients.isNotEmpty) ...[
                      const Text(
                        'Ingredients',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: food.ingredients.map((ing) {
                          return Container(
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                            decoration: BoxDecoration(
                              color: Theme.of(context).cardTheme.color,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.04),
                                width: 1,
                              ),
                            ),
                            child: Text(
                              ing,
                              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                    
                    // Extra spacing for bottom bar
                    const SizedBox(height: 120),
                  ],
                ),
              ),
            ),
          ),
          
          // 5. Sticky Bottom Action Bar with custom quantity modifier
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: EdgeInsets.only(
                left: 24,
                right: 24,
                top: 16,
                bottom: MediaQuery.of(context).padding.bottom + 12,
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 15,
                    offset: const Offset(0, -4),
                  )
                ],
                border: Border(
                  top: BorderSide(color: Colors.white.withOpacity(0.04), width: 1),
                ),
              ),
              child: Row(
                children: [
                  // Quantity Modifier
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardTheme.color,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.white.withOpacity(0.04), width: 1),
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove_rounded, size: 20),
                          onPressed: _decrementQuantity,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Text(
                            '$_quantity',
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.add_rounded, size: 20),
                          onPressed: _incrementQuantity,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  
                  // Add to Cart Button
                  Expanded(
                    child: ElevatedButton(
                    onPressed: () {
                      context.read<CartBloc>().add(
                        AddToCart(food: food, quantity: _quantity),
                      );

                      Navigator.pop(context,
                      'Added $_quantity ${food.name} to cart!',
                      );
                    },
                      child: Text('Add - ${_formatPrice(totalPrice)}'),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
