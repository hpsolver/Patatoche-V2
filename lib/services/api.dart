import 'dart:convert';
import 'package:dio/dio.dart';
import '../app_config.dart';
import '../constants/api_constants.dart';
import '../locator.dart';
import 'fetch_data_exception.dart';

class Api {


  Dio dio = locator<Dio>();

  Future<void> login({String? email}) async {
    try {
      dio.options.headers[AppConfig.contentType] = AppConfig.applicationJson;
      var response = await dio.post(
        AppConfig.baseUrl + ApiConstants.login,
        data: {"email": email},
      );
      //return AuthResponse.fromJson(response.data);
    } on DioException catch (e) {
      handleDioException(e);
    }
  }
}
