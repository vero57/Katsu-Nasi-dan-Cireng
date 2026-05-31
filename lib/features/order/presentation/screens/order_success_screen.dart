import 'package:flutter/material.dart';
import '../../data/models/order_model.dart';

class OrderSuccessScreen extends StatelessWidget {
  final OrderModel order;

  const OrderSuccessScreen({super.key, required this.order});

  String _formatPrice(double price) {
    return 'Rp ${price.toInt().toString().replaceAllMapped(RegExp(r"(\d{1,3})(?=(\d{3})+(?!\d))"), (Match m) => "${m[1]}.")}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 30),
                
                // Celebration Icon Header
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Text(
                    '🚴‍♂️💨',
                    style: TextStyle(fontSize: 60),
                  ),
                ),
                const SizedBox(height: 24),
                
                const Text(
                  'Order Confirmed!',
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 8),
                Text(
                  'Your order has been accepted and is currently being processed.',
                  style: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                
                // Order Details summary card
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardTheme.color,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white.withOpacity(0.04), width: 1),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Order ID', style: TextStyle(color: Colors.grey, fontSize: 13)),
                          Text(order.id, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Estimated Delivery', style: TextStyle(color: Colors.grey, fontSize: 13)),
                          Text(
                            '25 - 35 mins',
                            style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Total Payment', style: TextStyle(color: Colors.grey, fontSize: 13)),
                          Text(
                            _formatPrice(order.totalAmount),
                            style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 15),
                          ),
                        ],
                      ),
                      const Divider(color: Colors.white10, height: 24),
                      
                      // Order items list
                      const Text(
                        'Items Summary',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                      ),
                      const SizedBox(height: 8),
                      ...order.items.map((item) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 6.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  '${item.quantity}x  ${item.food.name}',
                                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Text(
                                _formatPrice(item.totalPrice),
                                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        );
                      }),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                
                // Shipment progress timeline
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Track Order Status',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
                const SizedBox(height: 16),
                _buildTimelineStep(
                  context,
                  title: 'Order Confirmed',
                  subtitle: 'We have received your order request.',
                  isCompleted: true,
                  isCurrent: false,
                ),
                _buildTimelineStep(
                  context,
                  title: 'Preparing Gourmet Delicacies',
                  subtitle: 'Our chef is preparing your meal with care.',
                  isCompleted: true,
                  isCurrent: true,
                ),
                _buildTimelineStep(
                  context,
                  title: 'Out for Delivery',
                  subtitle: 'Courier will pickup and head to your location.',
                  isCompleted: false,
                  isCurrent: false,
                  isLast: true,
                ),
                const SizedBox(height: 40),
                
                // Back to home button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigate back to home screen and clear stack
                      Navigator.of(context).popUntil((route) => route.isFirst);
                    },
                    child: const Text('Back to Gourmet Home'),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTimelineStep(
    BuildContext context, {
    required String title,
    required String subtitle,
    required bool isCompleted,
    required bool isCurrent,
    bool isLast = false,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                color: isCompleted
                    ? (isCurrent ? Theme.of(context).primaryColor : Colors.green)
                    : Colors.transparent,
                shape: BoxShape.circle,
                border: Border.all(
                  color: isCompleted
                      ? Colors.transparent
                      : Colors.white.withOpacity(0.12),
                  width: 2,
                ),
              ),
              child: isCompleted
                  ? Icon(
                      isCurrent ? Icons.restaurant_menu_rounded : Icons.check_rounded,
                      color: Colors.white,
                      size: 12,
                    )
                  : null,
            ),
            if (!isLast)
              Container(
                width: 2,
                height: 38,
                color: isCompleted ? Colors.green : Colors.white10,
              ),
          ],
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: isCurrent
                      ? Theme.of(context).primaryColor
                      : (isCompleted ? Colors.white : Colors.grey),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: const TextStyle(fontSize: 11, color: Colors.grey),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
