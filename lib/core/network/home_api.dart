import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:tasty_choise_customer/core/network/end_points.dart';
import 'package:tasty_choise_customer/core/services/dio_service.dart';
import 'package:tasty_choise_customer/core/utils/app_helpers.dart';
import 'package:tasty_choise_customer/future/home/models/app.dart';
import 'package:tasty_choise_customer/future/home/models/general_response.dart';
import 'package:tasty_choise_customer/future/home/models/home_response.dart';

typedef EitherType<T> = Future<Either<String, T>>;

class HomeApi {
  final DioService dio;

  HomeApi({required this.dio});

  EitherType<GeneralResponse<App>> appConfig() async {
    try {
      final response = await dio.dio.get(EndPoints.APP_CONFIG);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return right(GeneralResponse.fromJson(response.data));
      } else {
        return left(response.data['message']);
      }
    } catch (ex) {
      return left(ex.toString());
    }
  }

  EitherType<GeneralResponse<HomeResponse>> getHomeData() async {
    try {
      final response = await dio.dio.get(
        EndPoints.HOME,
        options: Options(headers: AppHelpers.getHeader()),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return right(GeneralResponse.fromJson(response.data));
      } else {
        return left(response.data['message']);
      }
    } catch (ex) {
      return left(ex.toString());
    }
  }

  EitherType<GeneralResponse> storeProduct({
    required String name,
    required String price,
    required String? image,
    required String productTypeId,
    required String description,
    required int? productId,
  }) async {
    FormData data = FormData.fromMap({
      'name': name,
      'price': price,
      'product_type_id': productTypeId,
      'description': description,
      if (productId != null) 'product_id': productId,
      if (image != null) 'image': await MultipartFile.fromFile(image),
    });

    try {
      final response = productId != null
          ? await dio.dio.post(
              EndPoints.PRODUCT_UPDATED,
              data: data,
              options: Options(headers: AppHelpers.getHeader()),
            )
          : await dio.dio.post(
              EndPoints.PRODUCT,
              data: data,
              options: Options(headers: AppHelpers.getHeader()),
            );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return right(GeneralResponse.fromJson(response.data));
      } else {
        return left(response.data['message']);
      }
    } catch (ex) {
      return left(ex.toString());
    }
  }

  EitherType<GeneralResponse> deleteProduct({
    required int id,
  }) async {
    try {
      final response = await dio.dio.delete(
        "${EndPoints.PRODUCT}/$id",
        options: Options(headers: AppHelpers.getHeader()),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return right(GeneralResponse.fromJson(response.data));
      } else {
        return left(response.data['message']);
      }
    } catch (ex) {
      return left(ex.toString());
    }
  }

  EitherType<GeneralResponse> getRestaurants(
    int? categoryId, {
    required double? minPrice,
    required double? maxPrice,
  }) async {
    try {
      final response = await dio.dio.get(
        categoryId != null
            ? maxPrice != null
                ? "${EndPoints.RESTAURANT}?category_id=$categoryId&max_price=${maxPrice.toInt()}&min_price=${minPrice!.toInt()}"
                : "${EndPoints.RESTAURANT}?category_id=$categoryId}"
            : "${EndPoints.RESTAURANT}?max_price=${maxPrice!.toInt()}&min_price=${minPrice!.toInt()}",
        options: Options(headers: AppHelpers.getHeader()),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return right(GeneralResponse.fromJson(response.data));
      } else {
        return left(response.data['message']);
      }
    } catch (ex) {
      return left(ex.toString());
    }
  }

  EitherType<GeneralResponse> getRestaurantProducts(int categoryId) async {
    try {
      final response = await dio.dio.get(
        "${EndPoints.RESTAURANT}/$categoryId/products",
        options: Options(headers: AppHelpers.getHeader()),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return right(GeneralResponse.fromJson(response.data));
      } else {
        return left(response.data['message']);
      }
    } catch (ex) {
      return left(ex.toString());
    }
  }

  EitherType<GeneralResponse> getProductDetails(int productId) async {
    try {
      final response = await dio.dio.get(
        "${EndPoints.PRODUCT}/$productId",
        options: Options(headers: AppHelpers.getHeader()),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return right(GeneralResponse.fromJson(response.data));
      } else {
        return left(response.data['message']);
      }
    } catch (ex) {
      return left(ex.toString());
    }
  }

  EitherType<GeneralResponse> makeOrder(
      {required int quntity, required int productId}) async {
    try {
      final response = await dio.dio.post(
        EndPoints.MAKE_ORDER,
        data: {
          "quantity": quntity,
          "product_id": productId,
        },
        options: Options(headers: AppHelpers.getHeader()),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return right(GeneralResponse.fromJson(response.data));
      } else {
        return left(response.data['message']);
      }
    } catch (ex) {
      return left(ex.toString());
    }
  }
}
