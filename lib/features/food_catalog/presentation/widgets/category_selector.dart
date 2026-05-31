import 'package:flutter/material.dart';

class CategorySelector extends StatelessWidget {
  final String selectedCategory;
  final Function(String) onCategorySelected;

  const CategorySelector({
    super.key,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  static const List<Map<String, String>> categories = [
    {'name': 'All', 'icon': '🍽️'},
    {'name': 'Ramen', 'icon': '🍜'},
    {'name': 'Sushi', 'icon': '🍣'},
    {'name': 'Burger', 'icon': '🍔'},
    {'name': 'Drinks', 'icon': '🍹'},
    {'name': 'Desserts', 'icon': '🍰'},
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: categories.length,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          final category = categories[index];
          final name = category['name']!;
          final icon = category['icon']!;
          final isSelected = selectedCategory.toLowerCase() == name.toLowerCase();

          return Padding(
            padding: const EdgeInsets.only(right: 10),
            child: GestureDetector(
              onTap: () => onCategorySelected(name),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                decoration: BoxDecoration(
                  color: isSelected
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).cardTheme.color,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: Theme.of(context).primaryColor.withOpacity(0.3),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          )
                        ]
                      : [],
                  border: Border.all(
                    color: isSelected
                        ? Colors.transparent
                        : Colors.white.withOpacity(0.04),
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    Text(
                      icon,
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      name,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                        color: isSelected
                            ? Colors.white
                            : Theme.of(context).textTheme.bodyMedium?.color,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
