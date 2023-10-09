import 'package:tasty_choise_customer/core/network/home_api.dart';
import 'package:tasty_choise_customer/future/home/models/general_response.dart';

abstract class NotificationRepo {
  EitherType<GeneralResponse> notification();
}
