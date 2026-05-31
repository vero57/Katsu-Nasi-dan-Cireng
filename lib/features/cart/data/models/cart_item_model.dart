import 'package:equatable/equatable.dart';
import '../../../food_catalog/data/models/food_model.dart';

class CartItemModel extends Equatable {
  final FoodModel food;
  final int quantity;

  const CartItemModel({
    required this.food,
    required this.quantity,
  });

  double get totalPrice => food.price * quantity;

  CartItemModel copyWith({
    FoodModel? food,
    int? quantity,
  }) {
    return CartItemModel(
      food: food ?? this.food,
      quantity: quantity ?? this.quantity,
    );
  }

  @override
  List<Object?> get props => [food, quantity];
}
