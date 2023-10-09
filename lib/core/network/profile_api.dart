import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:tasty_choise_customer/core/network/end_points.dart';
import 'package:tasty_choise_customer/core/network/home_api.dart';
import 'package:tasty_choise_customer/core/services/dio_service.dart';
import 'package:tasty_choise_customer/core/utils/app_helpers.dart';
import 'package:tasty_choise_customer/future/home/models/general_response.dart';

class ProfileApi {
  final DioService dio;

  ProfileApi({required this.dio});

  EitherType<GeneralResponse> appSettings(String value) async {
    try {
      final response = await dio.dio.post(
        EndPoints.APP_SETTINGS,
        data: {"key": value},
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

  EitherType<GeneralResponse> getTransaction() async {
    try {
      final response = await dio.dio.get(
        EndPoints.WALLET,
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

  EitherType<GeneralResponse> getSubscribtions() async {
    try {
      final response = await dio.dio.get(
        EndPoints.SUBSCRIBTION,
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

  EitherType<GeneralResponse> subscribe(int id) async {
    try {
      final response = await dio.dio.post(
        EndPoints.SUBSCRIBTION,
        data: {"subscription_id": id},
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

  EitherType<GeneralResponse> requestMoney({
    required String name,
    required String ibanNumber,
    required String accountNumber,
    required String amount,
  }) async {
    try {
      final response = await dio.dio.post(
        EndPoints.REQUEST_MONY,
        data: {
          "name": name,
          "iban_number": ibanNumber,
          "account_number": accountNumber,
          "amount": amount,
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
