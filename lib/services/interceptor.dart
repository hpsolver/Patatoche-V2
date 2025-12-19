import 'package:dio/dio.dart';

class AuthInterceptor implements InterceptorsWrapper {
  @override
  Future onRequest(RequestOptions options,RequestInterceptorHandler handler) async {
    return handler.next(options);
  }

  @override
  Future onResponse(Response response,ResponseInterceptorHandler handler) async {
    return handler.next(response);
  }

  @override
  Future onError(DioError err,ErrorInterceptorHandler handler) async {
    return  handler.next(err);
  }

}
