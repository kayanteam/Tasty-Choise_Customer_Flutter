import 'package:tasty_choise_customer/core/network/home_api.dart';
import 'package:tasty_choise_customer/future/home/models/app.dart';
import 'package:tasty_choise_customer/future/home/models/general_response.dart';
import 'package:tasty_choise_customer/future/home/models/home_response.dart';

abstract class HomeRepo {
  EitherType<GeneralResponse<App>> appConfig();
  EitherType<GeneralResponse<HomeResponse>> homeData();
  EitherType<GeneralResponse> storeProduct({
    required String name,
    required String price,
    required String? image,
    required String productTypeId,
    required String description,
    required int? productId,
  });
  EitherType<GeneralResponse> getRestaurants(
    int? categoryId, {
    required double? maxPrice,
    required double? minPrice,
  });
  EitherType<GeneralResponse> getRestaurantProducts(int categoryId);
  EitherType<GeneralResponse> getProductDetails(int productId);
  EitherType<GeneralResponse> makeOrder(
      {required int productId, required int quintity});

  EitherType<GeneralResponse> deleteProduct(int id);
}
