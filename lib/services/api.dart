import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:patatoche_v2/models/get_upload_url_response.dart';
import 'package:patatoche_v2/models/login_response.dart';
import 'package:patatoche_v2/models/product_model.dart';
import 'package:patatoche_v2/models/social_login_response.dart';
import '../app_config.dart';
import '../constants/api_constants.dart';
import '../locator.dart';
import '../models/activation_code_response.dart';
import '../models/common_response.dart';
import '../models/forgot_password_response.dart';
import '../models/register_response.dart';
import '../models/tag_list_response.dart';
import '../models/update_profile_response.dart';
import '../models/verify_nfc_tag_response.dart';
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

  Future<SocialLoginResponse?> socialLogin({
    required String provider,
    required String idToken,
  }) async {
    try {
      dio.options.headers[AppConfig.contentType] = AppConfig.applicationJson;
      var response = await dio.post(
        AppConfig.baseUrl + ApiConstants.socialLogin,
        data: {"provider": provider, "id_token": idToken},
      );

      return SocialLoginResponse.fromJson(response.data);
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

  Future<CommonResponse?> sendForgotPasswordOtp({required String email}) async {
    try {
      dio.options.headers[AppConfig.contentType] = AppConfig.applicationJson;
      var response = await dio.post(
        AppConfig.baseUrl + ApiConstants.fpSendOtp,
        data: {"email": email},
      );

      return CommonResponse.fromJson(response.data);
    } on DioException catch (e) {
      handleDioException(e);
    }
    return null;
  }

  Future<CommonResponse?> forgotPasswordVerifyOtp({
    required String email,
    required String otp,
  }) async {
    try {
      dio.options.headers[AppConfig.contentType] = AppConfig.applicationJson;
      var response = await dio.post(
        AppConfig.baseUrl + ApiConstants.fpVerifyOtp,
        data: {"email": email, "otp": otp},
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
    required String otp,
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
          "otp": otp,
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
    required String password,
  }) async {
    try {
      dio.options.headers[AppConfig.contentType] = AppConfig.applicationJson;
      var response = await dio.post(
        AppConfig.baseUrl + ApiConstants.forgotPassword,
        data: {"email": email, "new_password": password},
      );
      return ForgotPasswordResponse.fromJson(response.data);
    } on DioException catch (e) {
      handleDioException(e);
    }
    return null;
  }

  Future<CommonResponse?> updatePassword({
    required int userId,
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      dio.options.headers[AppConfig.contentType] = AppConfig.applicationJson;
      var response = await dio.post(
        AppConfig.baseUrl + ApiConstants.updatePassword,
        data: {
          "user_id": userId,
          "currentpassword": currentPassword,
          "newpassword": newPassword,
        },
      );
      return CommonResponse.fromJson(response.data);
    } on DioException catch (e) {
      handleDioException(e);
    }
    return null;
  }

  Future<UpdateProfileResponse?> updateProfile({
    required Map<String, dynamic> request,
  }) async {
    try {
      dio.options.headers[AppConfig.contentType] = AppConfig.applicationJson;
      var response = await dio.post(
        AppConfig.baseUrl + ApiConstants.updateProfile,
        data: request,
      );
      return UpdateProfileResponse.fromJson(response.data);
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

  Future<GetUploadUrlResponse?> getUploadUrl({
    required Map<String, dynamic> request,
  }) async {
    try {
      dio.options.headers[AppConfig.contentType] = AppConfig.applicationJson;
      var response = await dio.post(
        AppConfig.baseUrl + ApiConstants.getUploadUrl,
        data: request,
      );
      return GetUploadUrlResponse.fromJson(response.data);
    } on DioException catch (e) {
      handleDioException(e);
    }
    return null;
  }

  Future<TagListResponse?> getBatches(int userId) async {
    try {
      dio.options.headers[AppConfig.contentType] = AppConfig.applicationJson;
      var response = await dio.post(
        AppConfig.baseUrl + ApiConstants.getBatches,
        data: {'user_id': userId},
      );
      return TagListResponse.fromJson(response.data);
    } on DioException catch (e) {
      handleDioException(e);
    }
    return null;
  }

  Future<VerifyNfcTagResponse?> checkBatchCode(String batchId) async {
    try {
      dio.options.headers[AppConfig.contentType] = AppConfig.applicationJson;
      var response = await dio.post(
        AppConfig.baseUrl + ApiConstants.checkBatchCode,
        data: {'batch_code': batchId},
      );
      return VerifyNfcTagResponse.fromJson(response.data);
    } on DioException catch (e) {
      handleDioException(e);
    }
    return null;
  }

  Future<ActivationCodeResponse?> checkActivationCode({
    required String batchId,
    required String activationCode,
    required int userId,
  }) async {
    try {
      dio.options.headers[AppConfig.contentType] = AppConfig.applicationJson;
      var response = await dio.post(
        AppConfig.baseUrl + ApiConstants.checkActivationCode,
        data: {
          'batch_code': batchId,
          'active_code': activationCode,
          'user_id': userId,
        },
      );
      return ActivationCodeResponse.fromJson(response.data);
    } on DioException catch (e) {
      handleDioException(e);
    }
    return null;
  }

  Future<CommonResponse?> saveMedia({
    required Map<String, dynamic> request,
  }) async {
    try {
      dio.options.headers[AppConfig.contentType] = AppConfig.applicationJson;
      var response = await dio.post(
        AppConfig.baseUrl + ApiConstants.saveMedia,
        data: request,
      );
      return CommonResponse.fromJson(response.data);
    } on DioException catch (e) {
      handleDioException(e);
    }
    return null;
  }

  Future<void> uploadFile(File file, Media model) async {
    await dio.put(
      model.uploadUrl!,
      data: file.openRead(),
      options: Options(headers: {'x-amz-acl': 'public-read'}),
      onSendProgress: (sent, total) {
        if (total != -1) {
          final progress = (sent / total * 100).toStringAsFixed(2);
          debugPrint('Progress: $progress%');
        }
      },
    );
  }
}
