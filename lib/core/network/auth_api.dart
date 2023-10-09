import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:tasty_choise_customer/core/network/end_points.dart';
import 'package:tasty_choise_customer/core/services/dio_service.dart';
import 'package:tasty_choise_customer/core/utils/app_helpers.dart';
import 'package:tasty_choise_customer/future/auth/models/general_auth_response.dart';
import 'package:tasty_choise_customer/future/auth/models/user_model.dart';
import 'package:tasty_choise_customer/future/home/models/general_response.dart';

typedef EitherType<T> = Future<Either<String, T>>;

class AuthApi {
  final DioService dio;

  AuthApi({required this.dio});

  EitherType<GeneralAuthResponse<UserModel>> login(
      String email, String password) async {
    try {
      final data = {
        "email": email,
        "password": password,
        "fcm_token": (await FirebaseMessaging.instance.getToken()) ?? "",
      };
      final response = await dio.dio.post(
        EndPoints.LOGIN,
        data: data,
        options: Options(headers: AppHelpers.getHeader()),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return right(GeneralAuthResponse.fromJson(response.data));
      } else {
        return left(response.data['message']);
      }
    } catch (ex) {
      return left(ex.toString());
    }
  }

  EitherType<GeneralAuthResponse<UserModel>> register({
    required String email,
    required String name,
    required String password,
  }) async {
    try {
      final data = {
        "email": email,
        "password": password,
        "name": name,
        "fcm_token": (await FirebaseMessaging.instance.getToken()) ?? "",
      };
      final response = await dio.dio.post(
        EndPoints.REGISTR,
        options: Options(headers: AppHelpers.getHeader()),
        data: data,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return right(GeneralAuthResponse.fromJson(response.data));
      } else {
        return left(response.data['message']);
      }
    } catch (ex) {
      return left(ex.toString());
    }
  }

  EitherType<GeneralAuthResponse<UserModel>> verifyCode(
    String email,
    String code,
  ) async {
    try {
      final data = {
        "email": email,
        "code": code,
      };
      final response = await dio.dio.post(
        EndPoints.VERIFY_CODE,
        options: Options(headers: AppHelpers.getHeader()),
        data: data,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return right(GeneralAuthResponse.fromJson(response.data));
      } else {
        return left(response.data['message']);
      }
    } catch (ex) {
      return left(ex.toString());
    }
  }

  EitherType<GeneralAuthResponse<void>> forgetPassword(String email) async {
    try {
      final data = {"email": email};
      final response = await dio.dio.post(
        EndPoints.FORGET_PASSWORD,
        data: data,
        options: Options(headers: AppHelpers.getHeader()),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return right(GeneralAuthResponse.fromJson(response.data));
      } else {
        return left(response.data['message']);
      }
    } catch (ex) {
      return left(ex.toString());
    }
  }

  EitherType<GeneralAuthResponse<void>> resetPassword(
    String email,
    String password,
    String passwordConfirmation,
  ) async {
    try {
      final data = {
        "email": email,
        "password": password,
        "password_confirmation": passwordConfirmation,
      };
      final response = await dio.dio.post(
        EndPoints.RESET_PASSWORD,
        data: data,
        options: Options(headers: AppHelpers.getHeader()),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return right(GeneralAuthResponse.fromJson(response.data));
      } else {
        return left(response.data['message']);
      }
    } catch (ex) {
      return left(ex.toString());
    }
  }

  EitherType<GeneralAuthResponse<void>> changePassword(
    String currentPass,
    String newPass,
    String confirmPass,
  ) async {
    try {
      final data = {
        "current_password": currentPass,
        "password": newPass,
        "password_confirmation": confirmPass,
      };
      final response = await dio.dio.post(
        EndPoints.CHANGE_PASSWORD,
        data: data,
        options: Options(headers: AppHelpers.getHeader()),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return right(GeneralAuthResponse.fromJson(response.data));
      } else {
        return left(response.data['message']);
      }
    } catch (ex) {
      return left(ex.toString());
    }
  }

  EitherType<GeneralResponse> updateProfileData(
    UserModel user,
  ) async {
    try {
      FormData data = FormData.fromMap({
        "name": user.name,
        "phone": user.phone,
        "email": user.email,
        // if (user.image != null)
        //   'image': await MultipartFile.fromFile(
        //     user.image!,
        //     filename: DateTime.now().toString(),
        //   )
      });

      final response = await dio.dio.post(
        EndPoints.UPDATE_ACCOUNT_DATA,
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

  EitherType<GeneralResponse<dynamic>> updateProfileImage(String image) async {
    try {
      FormData data = FormData.fromMap({
        'image': await MultipartFile.fromFile(
          image,
          filename: DateTime.now().toString(),
        )
      });

      final response = await dio.dio.post(
        EndPoints.UPDATE_ACCOUNT_IMAGE,
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
}
