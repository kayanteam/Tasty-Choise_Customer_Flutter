import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:tasty_choise_customer/core/network/end_points.dart';
import 'package:tasty_choise_customer/core/utils/app_helpers.dart';

class DioService {
  static final DioService _singleton = DioService._internal();

  factory DioService() {
    return _singleton;
  }

  late final Dio dio;

  DioService._internal() {
    dio = Dio(
      BaseOptions(
        baseUrl: EndPoints.BASE_URL,
        followRedirects: false,
        validateStatus: (int? status) {
          return status! < 500;
        },
        headers: AppHelpers.getHeader(),
      ),
    );
    dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90));
  }
}
