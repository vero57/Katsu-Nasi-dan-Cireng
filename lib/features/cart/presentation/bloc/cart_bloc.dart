import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/cart_repository.dart';
import 'cart_event.dart';
import 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartRepository cartRepository;

  CartBloc({required this.cartRepository}) : super(const CartLoading()) {
    on<LoadCart>(_onLoadCart);
    on<AddToCart>(_onAddToCart);
    on<RemoveFromCart>(_onRemoveFromCart);
    on<UpdateCartQuantity>(_onUpdateCartQuantity);
    on<ClearCart>(_onClearCart);
  }

  void _onLoadCart(LoadCart event, Emitter<CartState> emit) {
    emit(const CartLoading());
    final items = cartRepository.getCartItems();
    emit(CartLoaded(items: items));
  }

  void _onAddToCart(AddToCart event, Emitter<CartState> emit) {
    cartRepository.addToCart(event.food, event.quantity);
    final items = cartRepository.getCartItems();
    
    double currentDiscount = 0.0;
    if (state is CartLoaded) {
      currentDiscount = (state as CartLoaded).discountPercent;
    }
    
    emit(CartLoaded(items: items, discountPercent: currentDiscount));
  }

  void _onRemoveFromCart(RemoveFromCart event, Emitter<CartState> emit) {
    cartRepository.removeFromCart(event.foodId);
    final items = cartRepository.getCartItems();
    
    double currentDiscount = 0.0;
    if (state is CartLoaded) {
      currentDiscount = (state as CartLoaded).discountPercent;
    }
    
    emit(CartLoaded(items: items, discountPercent: currentDiscount));
  }

  void _onUpdateCartQuantity(UpdateCartQuantity event, Emitter<CartState> emit) {
    cartRepository.updateQuantity(event.foodId, event.quantity);
    final items = cartRepository.getCartItems();
    
    double currentDiscount = 0.0;
    if (state is CartLoaded) {
      currentDiscount = (state as CartLoaded).discountPercent;
    }
    
    emit(CartLoaded(items: items, discountPercent: currentDiscount));
  }

  void _onClearCart(ClearCart event, Emitter<CartState> emit) {
    cartRepository.clearCart();
    emit(const CartLoaded(items: []));
  }
}
