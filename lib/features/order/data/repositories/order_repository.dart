import 'dart:math';
import '../../../cart/data/models/cart_item_model.dart';
import '../models/order_model.dart';

class OrderRepository {
  final List<OrderModel> _orders = [];

  List<OrderModel> getOrders() => List.unmodifiable(_orders);

  Future<OrderModel> placeOrder(List<CartItemModel> items, double totalAmount) async {
    // Simulate API connection delay
    await Future.delayed(const Duration(milliseconds: 1500));
    
    final randomId = 'ORD-${Random().nextInt(90000) + 10000}';
    final newOrder = OrderModel(
      id: randomId,
      items: List.from(items),
      totalAmount: totalAmount,
      status: 'Driver Preparing Food',
      createdAt: DateTime.now(),
    );
    
    _orders.add(newOrder);
    return newOrder;
  }
}
