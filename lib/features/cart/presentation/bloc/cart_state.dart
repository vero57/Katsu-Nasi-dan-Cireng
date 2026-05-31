import 'package:equatable/equatable.dart';
import '../../data/models/cart_item_model.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object?> get props => [];
}

class CartLoading extends CartState {
  const CartLoading();
}

class CartLoaded extends CartState {
  final List<CartItemModel> items;
  final double deliveryFee;
  final double discountPercent;

  const CartLoaded({
    required this.items,
    this.deliveryFee = 12000.0, // Mock delivery fee in IDR
    this.discountPercent = 0.0,
  });

  double get subtotal => items.fold(0.0, (sum, item) => sum + item.totalPrice);
  double get discountAmount => subtotal * (discountPercent / 100);
  double get total => items.isEmpty ? 0.0 : (subtotal + deliveryFee - discountAmount);
  int get totalItemCount => items.fold(0, (sum, item) => sum + item.quantity);

  CartLoaded copyWith({
    List<CartItemModel>? items,
    double? deliveryFee,
    double? discountPercent,
  }) {
    return CartLoaded(
      items: items ?? this.items,
      deliveryFee: deliveryFee ?? this.deliveryFee,
      discountPercent: discountPercent ?? this.discountPercent,
    );
  }

  @override
  List<Object?> get props => [items, deliveryFee, discountPercent];
}
