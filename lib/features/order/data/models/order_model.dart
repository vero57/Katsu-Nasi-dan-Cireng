import 'package:equatable/equatable.dart';
import '../../../cart/data/models/cart_item_model.dart';

class OrderModel extends Equatable {
  final String id;
  final List<CartItemModel> items;
  final double totalAmount;
  final String status;
  final DateTime createdAt;

  const OrderModel({
    required this.id,
    required this.items,
    required this.totalAmount,
    required this.status,
    required this.createdAt,
  });

  OrderModel copyWith({
    String? id,
    List<CartItemModel>? items,
    double? totalAmount,
    String? status,
    DateTime? createdAt,
  }) {
    return OrderModel(
      id: id ?? this.id,
      items: items ?? this.items,
      totalAmount: totalAmount ?? this.totalAmount,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object?> get props => [id, items, totalAmount, status, createdAt];
}
