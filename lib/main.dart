import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/theme/app_theme.dart';
import 'features/food_catalog/data/repositories/food_repository.dart';
import 'features/cart/data/repositories/cart_repository.dart';
import 'features/order/data/repositories/order_repository.dart';
import 'features/food_catalog/presentation/bloc/food_bloc.dart';
import 'features/cart/presentation/bloc/cart_bloc.dart';
import 'features/order/presentation/bloc/order_bloc.dart';
import 'features/food_catalog/presentation/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<FoodRepository>(
          create: (context) => FoodRepository(),
        ),
        RepositoryProvider<CartRepository>(
          create: (context) => CartRepository(),
        ),
        RepositoryProvider<OrderRepository>(
          create: (context) => OrderRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<FoodBloc>(
            create: (context) => FoodBloc(
              foodRepository: context.read<FoodRepository>(),
            ),
          ),
          BlocProvider<CartBloc>(
            create: (context) => CartBloc(
              cartRepository: context.read<CartRepository>(),
            ),
          ),
          BlocProvider<OrderBloc>(
            create: (context) => OrderBloc(
              orderRepository: context.read<OrderRepository>(),
            ),
          ),
        ],
        child: MaterialApp(
          title: 'KASIRENG',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.darkTheme,
          home: const HomeScreen(),
        ),
      ),
    );
  }
}
