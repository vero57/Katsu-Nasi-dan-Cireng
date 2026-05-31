import 'package:equatable/equatable.dart';
import '../../data/models/order_model.dart';

abstract class OrderState extends Equatable {
  const OrderState();

  @override
  List<Object?> get props => [];
}

class OrderInitial extends OrderState {
  const OrderInitial();
}

class OrderProcessing extends OrderState {
  const OrderProcessing();
}

class OrderSuccess extends OrderState {
  final OrderModel order;

  const OrderSuccess({required this.order});

  @override
  List<Object?> get props => [order];
}

class OrderFailure extends OrderState {
  final String message;

  const OrderFailure({required this.message});

  @override
  List<Object?> get props => [message];
}
