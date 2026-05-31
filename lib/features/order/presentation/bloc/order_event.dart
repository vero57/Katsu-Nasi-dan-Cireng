import 'package:equatable/equatable.dart';
import '../../../cart/data/models/cart_item_model.dart';

abstract class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object?> get props => [];
}

class PlaceOrder extends OrderEvent {
  final List<CartItemModel> items;
  final double totalAmount;

  const PlaceOrder({required this.items, required this.totalAmount});

  @override
  List<Object?> get props => [items, totalAmount];
}
