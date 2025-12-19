import 'dart:io';
import 'package:dio/dio.dart';

class FetchDataException implements Exception {
  final String? _message;
  final int? _statusCode;
  final Data? _data;

  FetchDataException([this._message, this._statusCode, this._data]);

  @override
  String toString() {
    if (_message == null) return "An error occurred. Please try again.";
    return _message;
  }

  int? statusCode() {
    return _statusCode;
  }

  Data? data() {
    return _data;
  }
}

class Data {
  String? redirect;
  String? reason;
  bool? timeout;

  Data({this.redirect, this.timeout, this.reason});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    redirect: json["redirect"],
    reason: json["reason"],
    timeout: json["timeout"],
  );
}

/// Handles DioException and throws a readable message
void handleDioException(DioException e) {
  if (e.response != null) {
    final responseData = e.response?.data;
    final String errorMessage =
        responseData != null &&
            responseData['messages'] is List &&
            responseData['messages'].isNotEmpty
        ? responseData['messages'][0]['text'] ?? 'Something went wrong.'
        : (responseData != null && responseData['message'] is String)
        ? responseData['message'] ?? 'Something went wrong.'
        : 'Something went wrong.';
    throw FetchDataException(
      errorMessage,
      e.response?.statusCode,
      responseData['data'] != null ? Data.fromJson(responseData['data']) : null,
    );
  } else {
    throw const SocketException("No internet connection");
  }
}
