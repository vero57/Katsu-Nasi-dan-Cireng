import 'package:flutter/material.dart';
import '../../data/models/cart_item_model.dart';

class CartItemCard extends StatelessWidget {
  final CartItemModel item;
  final Function(int) onQuantityChanged;
  final VoidCallback onRemove;

  const CartItemCard({
    super.key,
    required this.item,
    required this.onQuantityChanged,
    required this.onRemove,
  });

  String _formatPrice(double price) {
    return 'Rp ${price.toInt().toString().replaceAllMapped(RegExp(r"(\d{1,3})(?=(\d{3})+(?!\d))"), (Match m) => "${m[1]}.")}';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white.withOpacity(0.04),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          // Food Thumbnail Image
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              item.food.imageUrl,
              height: 70,
              width: 70,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                height: 70,
                width: 70,
                color: Colors.grey[900],
                child: const Icon(Icons.fastfood, size: 24, color: Colors.grey),
              ),
            ),
          ),
          const SizedBox(width: 16),
          
          // Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.food.name,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  _formatPrice(item.food.price),
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                
                // Inline Quantity Modifier
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () => onQuantityChanged(item.quantity - 1),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              child: Icon(Icons.remove_rounded, size: 16),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              '${item.quantity}',
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => onQuantityChanged(item.quantity + 1),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              child: Icon(Icons.add_rounded, size: 16),
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    // Display item total price
                    Text(
                      _formatPrice(item.totalPrice),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          
          // Delete/Remove Action Button
          GestureDetector(
            onTap: onRemove,
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.04),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.close_rounded,
                size: 16,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
