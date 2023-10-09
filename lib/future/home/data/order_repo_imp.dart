import 'package:tasty_choise_customer/core/network/home_api.dart';
import 'package:tasty_choise_customer/core/network/order_api.dart';
import 'package:tasty_choise_customer/future/home/domin/order_repo.dart';
import 'package:tasty_choise_customer/future/home/models/general_response.dart';

class OrderRepoImp extends OrderRepo {
  final OrderApi api;

  OrderRepoImp({required this.api});

  @override
  EitherType<GeneralResponse> orders(String status) {
    return api.orders(status);
  }

  @override
  EitherType<GeneralResponse> updateOrder(
      {required String status, required int orderId}) {
    return api.updateOrder(status: status, orderId: orderId);
  }
}
