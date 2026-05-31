import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/order_repository.dart';
import 'order_event.dart';
import 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final OrderRepository orderRepository;

  OrderBloc({required this.orderRepository}) : super(const OrderInitial()) {
    on<PlaceOrder>(_onPlaceOrder);
  }

  Future<void> _onPlaceOrder(PlaceOrder event, Emitter<OrderState> emit) async {
    emit(const OrderProcessing());
    try {
      final order = await orderRepository.placeOrder(event.items, event.totalAmount);
      emit(OrderSuccess(order: order));
    } catch (e) {
      emit(OrderFailure(message: e.toString()));
    }
  }
}
