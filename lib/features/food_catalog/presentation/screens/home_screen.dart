import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../cart/presentation/bloc/cart_bloc.dart';
import '../../../cart/presentation/bloc/cart_event.dart';
import '../../../cart/presentation/bloc/cart_state.dart';
import '../bloc/food_bloc.dart';
import '../bloc/food_event.dart';
import '../bloc/food_state.dart';
import '../widgets/category_selector.dart';
import '../widgets/food_card.dart';
import 'food_detail_screen.dart';
import '../../../cart/presentation/screens/cart_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Dispatch initial load event
    context.read<FoodBloc>().add(const LoadFoodCatalog());
    context.read<CartBloc>().add(const LoadCart());
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'KASIRENG',
              style: Theme.of(context).appBarTheme.titleTextStyle,
            ),
            const Text(
              'Juaranya Katsu dan Cireng',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
        actions: [
          // Beautiful cart icon with animated badge count
          BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              int count = 0;
              if (state is CartLoaded) {
                count = state.totalItemCount;
              }
              return Stack(
                alignment: Alignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.shopping_bag_outlined, size: 28),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CartScreen(),
                        ),
                      );
                    },
                  ),
                  if (count > 0)
                    Positioned(
                      right: 6,
                      top: 6,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            width: 1.5,
                          ),
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 18,
                          minHeight: 18,
                        ),
                        child: Text(
                          '$count',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            context.read<FoodBloc>().add(const LoadFoodCatalog());
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),

                // Premium Styled Search Bar
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextField(
                    controller: _searchController,
                    onChanged: (query) {
                      context.read<FoodBloc>().add(SearchFood(query));
                    },
                    decoration: InputDecoration(
                      hintText: 'Search for cravings (e.g. Ramen, Burger)...',
                      prefixIcon: const Icon(Icons.search_rounded),
                      suffixIcon: _searchController.text.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear_rounded),
                              onPressed: () {
                                _searchController.clear();
                                context.read<FoodBloc>().add(
                                  const SearchFood(''),
                                );
                              },
                            )
                          : null,
                    ),
                  ),
                ),
                const SizedBox(height: 18),

                // Interactive Promo Banner Card
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Theme.of(context).primaryColor,
                          const Color(0xFFFF9800),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(
                            context,
                          ).primaryColor.withOpacity(0.3),
                          blurRadius: 15,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Text(
                                  'PROMO MANTAP',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                'Get 20% discount!',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  height: 1.1,
                                ),
                              ),
                              const SizedBox(height: 4),
                              const Text(
                                'Use promo code MANTAP20 at checkout',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Text('🍔🔥', style: TextStyle(fontSize: 48)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Horizontal Category Selection Header
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'Explore Categories',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 12),

                // Categories
                BlocBuilder<FoodBloc, FoodState>(
                  builder: (context, state) {
                    String selectedCategory = 'All';
                    if (state is FoodLoaded) {
                      selectedCategory = state.selectedCategory;
                    }
                    return CategorySelector(
                      selectedCategory: selectedCategory,
                      onCategorySelected: (category) {
                        context.read<FoodBloc>().add(
                          FilterByCategory(category),
                        );
                      },
                    );
                  },
                ),
                const SizedBox(height: 24),

                // Food Grid Section
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'Popular Dishes',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 12),

                // Grid of items loaded from bloc
                BlocBuilder<FoodBloc, FoodState>(
                  builder: (context, state) {
                    if (state is FoodLoading) {
                      return const Padding(
                        padding: EdgeInsets.symmetric(vertical: 40),
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }

                    if (state is FoodLoaded) {
                      final foods = state.foods;

                      if (foods.isEmpty) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 40),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  '🔍',
                                  style: TextStyle(fontSize: 40),
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  'Cravings not found!',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Try searching for something else.',
                                  style: TextStyle(
                                    color: Theme.of(
                                      context,
                                    ).textTheme.bodyMedium?.color,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }

                      return GridView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: foods.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 14,
                              mainAxisSpacing: 14,
                              childAspectRatio: 0.75,
                            ),
                        itemBuilder: (context, index) {
                          final food = foods[index];
                          return FoodCard(
                            food: food,
                            onTap: () async {
                              final result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      FoodDetailScreen(food: food),
                                ),
                              );

                          if (result != null) {
                            ScaffoldMessenger.of(context).clearSnackBars();

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Row(
                                  children: [
                                    const Icon(
                                      Icons.check_circle,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Text(
                                        result,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                backgroundColor: Theme.of(context).primaryColor,
                                behavior: SnackBarBehavior.floating,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                duration: const Duration(seconds: 2),
                                action: SnackBarAction(
                                  label: 'VIEW',
                                  textColor: Colors.white,
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => const CartScreen(),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            );
                          }
                            },
                            onAddTap: () {
                              context.read<CartBloc>().add(
                                AddToCart(food: food, quantity: 1),
                              );
                              // Premium Toast alert
                              ScaffoldMessenger.of(context).clearSnackBars();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Row(
                                    children: [
                                      const Icon(
                                        Icons.check_circle,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: Text(
                                          'Added ${food.name} to cart!',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  backgroundColor: Theme.of(
                                    context,
                                  ).primaryColor,
                                  behavior: SnackBarBehavior.floating,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  duration: const Duration(seconds: 2),
                                  action: SnackBarAction(
                                    label: 'VIEW',
                                    textColor: Colors.white,
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const CartScreen(),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      );
                    }

                    if (state is FoodError) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 40),
                        child: Center(
                          child: Text(
                            'Error: ${state.message}',
                            style: const TextStyle(color: Colors.red),
                          ),
                        ),
                      );
                    }

                    return const SizedBox.shrink();
                  },
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
