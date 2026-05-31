import 'package:equatable/equatable.dart';
import '../../../food_catalog/data/models/food_model.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object?> get props => [];
}

class LoadCart extends CartEvent {
  const LoadCart();
}

class AddToCart extends CartEvent {
  final FoodModel food;
  final int quantity;

  const AddToCart({required this.food, required this.quantity});

  @override
  List<Object?> get props => [food, quantity];
}

class RemoveFromCart extends CartEvent {
  final String foodId;

  const RemoveFromCart({required this.foodId});

  @override
  List<Object?> get props => [foodId];
}

class UpdateCartQuantity extends CartEvent {
  final String foodId;
  final int quantity;

  const UpdateCartQuantity({required this.foodId, required this.quantity});

  @override
  List<Object?> get props => [foodId, quantity];
}

class ClearCart extends CartEvent {
  const ClearCart();
}
