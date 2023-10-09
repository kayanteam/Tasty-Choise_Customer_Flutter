import 'package:get_it/get_it.dart';
import 'package:tasty_choise_customer/core/network/home_api.dart';
import 'package:tasty_choise_customer/core/network/auth_api.dart';
import 'package:tasty_choise_customer/core/network/notification_api.dart';
import 'package:tasty_choise_customer/core/network/order_api.dart';
import 'package:tasty_choise_customer/core/network/profile_api.dart';
import 'package:tasty_choise_customer/core/services/dio_service.dart';
import 'package:tasty_choise_customer/core/services/navigation_service.dart';
import 'package:tasty_choise_customer/future/auth/data/auth_repo_imp.dart';
import 'package:tasty_choise_customer/future/auth/domin/auth_repo.dart';
import 'package:tasty_choise_customer/future/home/data/home_repo_imp.dart';
import 'package:tasty_choise_customer/future/home/data/notification_repo_imp.dart';
import 'package:tasty_choise_customer/future/home/data/order_repo_imp.dart';
import 'package:tasty_choise_customer/future/home/data/profile_repo_imp.dart';
import 'package:tasty_choise_customer/future/home/domin/home_repo.dart';
import 'package:tasty_choise_customer/future/home/domin/notification_repo.dart';
import 'package:tasty_choise_customer/future/home/domin/order_repo.dart';
import 'package:tasty_choise_customer/future/home/domin/profile_repo.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => DioService());

  HomeApi api = HomeApi(dio: locator<DioService>());
  OrderApi orderApi = OrderApi(dio: locator<DioService>());
  NotificationApi notificationApi = NotificationApi(dio: locator<DioService>());
  ProfileApi profileApi = ProfileApi(dio: locator<DioService>());

  locator.registerLazySingleton<AuthRepo>(
      () => AuthRepoImp(api: AuthApi(dio: locator<DioService>())));

  locator.registerFactory<HomeRepo>(() => HomeRepoImp(api: api));
  locator.registerFactory<OrderRepo>(() => OrderRepoImp(api: orderApi));
  locator.registerFactory<ProfileRepo>(() => ProfileRepoImp(api: profileApi));
  locator.registerFactory<NotificationRepo>(
      () => NotificationRepoImp(api: notificationApi));
}
