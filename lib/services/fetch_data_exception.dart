import 'dart:io';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';

class FetchDataException implements Exception {
  final String? _message;
  final int? _statusCode;

  FetchDataException([this._message, this._statusCode]);

  @override
  String toString() {
    if (_message == null) return "An error occurred. Please try again.";
    return _message;
  }

  int? statusCode() {
    return _statusCode;
  }
}

/// Handles DioException and throws a readable message
void handleDioException(DioException e) {
  if (e.response != null) {
    throw FetchDataException(
      'something_went_wrong'.tr(),
      e.response?.statusCode,
    );
  } else {
    throw SocketException("no_internet_connection".tr());
  }
}
