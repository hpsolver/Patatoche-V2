import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:patatoche_v2/models/login_response.dart';
import 'package:patatoche_v2/models/product_model.dart';
import '../app_config.dart';
import '../constants/api_constants.dart';
import '../locator.dart';
import '../models/common_response.dart';
import '../models/forgot_password_response.dart';
import '../models/register_response.dart';
import 'fetch_data_exception.dart';

class Api {
  Dio dio = locator<Dio>();

  Future<LoginResponse?> login({
    required String email,
    required String password,
  }) async {
    try {
      dio.options.headers[AppConfig.contentType] = AppConfig.applicationJson;
      var response = await dio.post(
        AppConfig.baseUrl + ApiConstants.login,
        data: {"email": email, "password": password},
      );

      return LoginResponse.fromJson(response.data);
    } on DioException catch (e) {
      handleDioException(e);
    }
    return null;
  }

  Future<CommonResponse?> sendRegisterOtp({required String email}) async {
    try {
      dio.options.headers[AppConfig.contentType] = AppConfig.applicationJson;
      var response = await dio.post(
        AppConfig.baseUrl + ApiConstants.sendRegisterOtp,
        data: {"email": email},
      );

      return CommonResponse.fromJson(response.data);
    } on DioException catch (e) {
      handleDioException(e);
    }
    return null;
  }

  Future<RegisterResponse?> register({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) async {
    try {
      dio.options.headers[AppConfig.contentType] = AppConfig.applicationJson;
      var response = await dio.post(
        AppConfig.baseUrl + ApiConstants.register,
        data: {
          "email": email,
          "password": password,
          "first_name": firstName,
          "last_name": lastName,
        },
      );

      return RegisterResponse.fromJson(response.data);
    } on DioException catch (e) {
      handleDioException(e);
    }
    return null;
  }

  Future<ForgotPasswordResponse?> forgotPassword({
    required String email,
  }) async {
    try {
      dio.options.headers[AppConfig.contentType] = AppConfig.applicationJson;
      var response = await dio.post(
        AppConfig.baseUrl + ApiConstants.forgotPassword,
        data: {"email": email},
      );
      return ForgotPasswordResponse.fromJson(response.data);
    } on DioException catch (e) {
      handleDioException(e);
    }
    return null;
  }

  Future<ProductModel?> getProducts() async {
    try {
      dio.options.headers[AppConfig.contentType] = AppConfig.applicationJson;
      var response = await dio.get(
        AppConfig.baseUrl + ApiConstants.getProducts,
      );
      return ProductModel.fromJson(response.data);
    } on DioException catch (e) {
      handleDioException(e);
    }
    return null;
  }
}
