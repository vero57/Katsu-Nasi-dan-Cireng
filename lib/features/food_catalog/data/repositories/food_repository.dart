import 'dart:async';
import '../models/food_model.dart';

class FoodRepository {
  // Static mock list of food items
  final List<FoodModel> _mockFoods = [
    const FoodModel(
      id: 'f1',
      name: 'Spicy Shoyu Ramen',
      description: 'Slow-cooked creamy chicken broth served with tender chashu, soft-boiled egg, nori, bamboo shoots, and our signature spicy chili oil.',
      price: 48000,
      imageUrl: 'https://images.unsplash.com/photo-1569718212165-3a8278d5f624?q=80&w=600',
      rating: 4.8,
      category: 'Ramen',
      isPopular: true,
      ingredients: ['Noodles', 'Chicken Broth', 'Chashu', 'Ajitama', 'Nori', 'Spicy Oil'],
    ),
    const FoodModel(
      id: 'f2',
      name: 'Hokkaido Tonkotsu Ramen',
      description: 'Rich, thick pork bone broth simmered for 16 hours, loaded with pork belly, scallions, wood-ear mushrooms, and black garlic oil.',
      price: 52000,
      imageUrl: 'https://images.unsplash.com/photo-1557872943-16a5ac26437e?q=80&w=600',
      rating: 4.9,
      category: 'Ramen',
      isPopular: true,
      ingredients: ['Noodles', 'Tonkotsu Broth', 'Pork Belly', 'Ajitama', 'Black Garlic Oil'],
    ),
    const FoodModel(
      id: 'f3',
      name: 'Premium Salmon Nigiri',
      description: 'Freshest cuts of Atlantic Salmon resting on perfectly seasoned Japanese sushi rice, glazed with a light sweet soy brush.',
      price: 36000,
      imageUrl: 'https://images.unsplash.com/photo-1579871494447-9811cf80d66c?q=80&w=600',
      rating: 4.7,
      category: 'Sushi',
      isPopular: true,
      ingredients: ['Salmon', 'Sushi Rice', 'Wasabi', 'Sweet Soy Glaze'],
    ),
    const FoodModel(
      id: 'f4',
      name: 'Dragon Roll (8 pcs)',
      description: 'Toasted eel and cucumber rolled inside-out, topped with avocado layers, premium tobiko, and drizzled with savory unagi sauce.',
      price: 64000,
      imageUrl: 'https://images.unsplash.com/photo-1611143669185-af224c5e3252?q=80&w=600',
      rating: 4.9,
      category: 'Sushi',
      isPopular: false,
      ingredients: ['Eel', 'Avocado', 'Cucumber', 'Tobiko', 'Unagi Sauce'],
    ),
    const FoodModel(
      id: 'f5',
      name: 'Ultimate Truffle Burger',
      description: '150g juicy wagyu beef patty, melted swiss cheese, caramelized wild mushrooms, and luxurious white truffle aioli on toasted brioche bun.',
      price: 72000,
      imageUrl: 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?q=80&w=600',
      rating: 4.8,
      category: 'Burger',
      isPopular: true,
      ingredients: ['Wagyu Patty', 'Swiss Cheese', 'Wild Mushrooms', 'Truffle Aioli', 'Brioche'],
    ),
    const FoodModel(
      id: 'f6',
      name: 'Smoked BBQ Bacon Burger',
      description: 'Grilled double beef patty, crispy beef bacon, sharp cheddar cheese, crispy onion rings, and smoky hickory barbecue sauce.',
      price: 58000,
      imageUrl: 'https://images.unsplash.com/photo-1550547660-d9450f859349?q=80&w=600',
      rating: 4.6,
      category: 'Burger',
      isPopular: false,
      ingredients: ['Beef Patty', 'Bacon', 'Cheddar', 'Onion Rings', 'BBQ Sauce'],
    ),
    const FoodModel(
      id: 'f7',
      name: 'Iced Matcha Latté',
      description: 'Ceremonial grade Uji Matcha whisked to perfection, poured over chilled fresh milk and sweetened with pure cane syrup.',
      price: 28000,
      imageUrl: 'https://images.unsplash.com/photo-1536256263959-770b48d82b0a?q=80&w=600',
      rating: 4.7,
      category: 'Drinks',
      isPopular: false,
      ingredients: ['Uji Matcha', 'Fresh Milk', 'Ice', 'Cane Syrup'],
    ),
    const FoodModel(
      id: 'f8',
      name: 'Espresso Avocado Float',
      description: 'Creamy avocado puree topped with a double shot of organic espresso and a scoop of velvety vanilla ice cream.',
      price: 34000,
      imageUrl: 'https://images.unsplash.com/photo-1595981267035-7b04ca84a82d?q=80&w=600',
      rating: 4.8,
      category: 'Drinks',
      isPopular: true,
      ingredients: ['Avocado Puree', 'Espresso Shot', 'Vanilla Ice Cream'],
    ),
    const FoodModel(
      id: 'f9',
      name: 'Classic Italian Tiramisu',
      description: 'Layers of espresso-soaked ladyfingers and rich whipped mascarpone cream, dusted with organic dark cocoa powder.',
      price: 38000,
      imageUrl: 'https://images.unsplash.com/photo-1571877227200-a0d98ea607e9?q=80&w=600',
      rating: 4.9,
      category: 'Desserts',
      isPopular: true,
      ingredients: ['Ladyfingers', 'Mascarpone', 'Espresso', 'Dark Cocoa'],
    ),
  ];

  // Simulates fetching all food items with a natural network delay
  Future<List<FoodModel>> getFoodCatalog() async {
    await Future.delayed(const Duration(milliseconds: 700));
    return List.from(_mockFoods);
  }

  // Simulates search and filter operations
  Future<List<FoodModel>> getFoods({String? category, String? query}) async {
    await Future.delayed(const Duration(milliseconds: 500));
    List<FoodModel> results = List.from(_mockFoods);

    if (category != null && category.isNotEmpty && category != 'All') {
      results = results.where((food) => food.category.toLowerCase() == category.toLowerCase()).toList();
    }

    if (query != null && query.isNotEmpty) {
      results = results
          .where((food) =>
              food.name.toLowerCase().contains(query.toLowerCase()) ||
              food.description.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }

    return results;
  }
}
