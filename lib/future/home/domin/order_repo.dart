import 'package:tasty_choise_customer/core/network/home_api.dart';
import 'package:tasty_choise_customer/future/home/models/general_response.dart';

abstract class OrderRepo {
  EitherType<GeneralResponse> orders(String status);
  EitherType<GeneralResponse> updateOrder({
    required String status,
    required int orderId,
  });
}
