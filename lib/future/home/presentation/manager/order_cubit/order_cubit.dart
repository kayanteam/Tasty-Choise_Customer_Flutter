import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasty_choise_customer/future/home/domin/order_repo.dart';
import 'package:tasty_choise_customer/future/home/models/order/order.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  final OrderRepo repo;

  OrderCubit(this.repo) : super(OrderInitial());

  static OrderCubit get(BuildContext context) {
    return BlocProvider.of(context);
  }

  int indexTap = 0;
  changeIndex(int status) {
    indexTap = status;
    emit(OrderInitial());
  }

  List<OrderModel> orders = [];

  Future getOrder() async {
    String status = '';
    switch (indexTap) {
      case 0:
        status = 'open';
        break;

      case 1:
        status = 'accepted';
        break;

      case 2:
        status = 'finished';
        break;
    }
    emit(OrdersLoading());
    (await repo.orders(status)).fold(
      (l) {
        emit(OrdersFailure(l));
      },
      (r) {
        orders.clear();
        r.data.forEach((v) {
          orders.add(OrderModel.fromJson(v));
        });
        emit(OrdersSuccess());
      },
    );
  }

  Future updartOrder({required String status, required int orderId}) async {
    emit(UpdateOrderStatusLoading());
    (await repo.updateOrder(status: status, orderId: orderId)).fold(
      (l) {
        emit(UpdateOrderStatusFailure(l));
      },
      (r) {
        emit(UpdateOrderStatusSuccess(r.message ?? ""));
      },
    );
  }
}
