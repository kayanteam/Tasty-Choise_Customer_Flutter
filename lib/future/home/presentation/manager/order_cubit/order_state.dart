part of 'order_cubit.dart';

sealed class OrderState {}

final class OrderInitial extends OrderState {}

final class OrdersLoading extends OrderState {}

final class OrdersFailure extends OrderState {
  final String message;
  OrdersFailure(this.message);
}

final class OrdersSuccess extends OrderState {}

final class UpdateOrderStatusLoading extends OrderState {}

final class UpdateOrderStatusFailure extends OrderState {
  final String message;
  UpdateOrderStatusFailure(this.message);
}

final class UpdateOrderStatusSuccess extends OrderState {
  final String message;
  UpdateOrderStatusSuccess(this.message);
}
