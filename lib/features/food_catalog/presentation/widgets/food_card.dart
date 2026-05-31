import 'package:flutter/material.dart';
import '../../data/models/food_model.dart';

class FoodCard extends StatelessWidget {
  final FoodModel food;
  final VoidCallback onTap;
  final VoidCallback onAddTap;

  const FoodCard({
    super.key,
    required this.food,
    required this.onTap,
    required this.onAddTap,
  });

  String _formatPrice(double price) {
    return 'Rp ${price.toInt().toString().replaceAllMapped(RegExp(r"(\d{1,3})(?=(\d{3})+(?!\d))"), (Match m) => "${m[1]}.")}';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardTheme.color,
          borderRadius: Theme.of(context).cardTheme.shape is RoundedRectangleBorder
              ? (Theme.of(context).cardTheme.shape as RoundedRectangleBorder).borderRadius
              : BorderRadius.circular(20),
          border: Border.all(
            color: Colors.white.withOpacity(0.04),
            width: 1,
          ),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Section with floating rating (Height optimized to 105)
            Stack(
              children: [
                Image.network(
                  food.imageUrl,
                  height: 105,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: 105,
                    color: Colors.grey[900],
                    child: const Icon(Icons.fastfood, size: 32, color: Colors.grey),
                  ),
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                      height: 105,
                      color: Colors.grey[900],
                      child: const Center(
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    );
                  },
                ),
                // Rating tag
                Positioned(
                  top: 6,
                  right: 6,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.star, color: Color(0xFFFFB03A), size: 12),
                        const SizedBox(width: 3),
                        Text(
                          food.rating.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            
            // Details Section
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0), // Compact padding
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Text blocks
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            food.category,
                            style: TextStyle(
                              color: Theme.of(context).primaryColor.withOpacity(0.8),
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            food.name,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              height: 1.2,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            food.description,
                            style: TextStyle(
                              fontSize: 11,
                              color: Theme.of(context).textTheme.bodyMedium?.color,
                            ),
                            maxLines: 2, // Wraps to next line when hitting edge
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    
                    // Elegant divider boundary
                    Divider(
                      color: Colors.white.withOpacity(0.06),
                      height: 10,
                      thickness: 1,
                    ),
                    
                    // Price and Add button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _formatPrice(food.price),
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        GestureDetector(
                          onTap: onAddTap,
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
