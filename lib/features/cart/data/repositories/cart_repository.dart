import '../../../food_catalog/data/models/food_model.dart';
import '../models/cart_item_model.dart';

class CartRepository {
  final List<CartItemModel> _cartItems = [];

  List<CartItemModel> getCartItems() {
    return List.unmodifiable(_cartItems);
  }

  void addToCart(FoodModel food, int quantity) {
    final index = _cartItems.indexWhere((item) => item.food.id == food.id);
    if (index >= 0) {
      final currentQuantity = _cartItems[index].quantity;
      _cartItems[index] = _cartItems[index].copyWith(quantity: currentQuantity + quantity);
    } else {
      _cartItems.add(CartItemModel(food: food, quantity: quantity));
    }
  }

  void removeFromCart(String foodId) {
    _cartItems.removeWhere((item) => item.food.id == foodId);
  }

  void updateQuantity(String foodId, int quantity) {
    final index = _cartItems.indexWhere((item) => item.food.id == foodId);
    if (index >= 0) {
      if (quantity <= 0) {
        _cartItems.removeAt(index);
      } else {
        _cartItems[index] = _cartItems[index].copyWith(quantity: quantity);
      }
    }
  }

  void clearCart() {
    _cartItems.clear();
  }

  double getSubtotal() {
    return _cartItems.fold(0, (sum, item) => sum + item.totalPrice);
  }
}
