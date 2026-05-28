import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'api_endpoints.dart';

class DioHelper {

  static Dio? dio;

  static void initDio() {
    dio ??= Dio(
      BaseOptions(
        baseUrl: ApiEndpoints.baseUrl,
        receiveDataWhenStatusError: true,
      ),
    );
    dio!.interceptors.add(PrettyDioLogger());
  }

  static Future<Response?> getRequest({
    required String endPoint,
    required Map<String, dynamic> query,
  }) async {
    try {
      return await dio!.get(
        endPoint,
        queryParameters: query,
      );
    } catch (e) {
      log(e.toString());
      return null;
    }
  }


}