import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:patatoche_v2/helpers/extensions.dart';
import 'package:patatoche_v2/provider/base_provider.dart';
import '../helpers/toast_helper.dart';
import '../routes.dart';
import '../services/fetch_data_exception.dart';

class ForgotProvider extends BaseProvider {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    customNotify();
  }

  Future<void> forgotPassword(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      context.hideKeyboard();
      await forgotPasswordApi(context);
    }
  }

  Future<void> forgotPasswordApi(BuildContext context) async {
    try {
      isLoading = true;

      var model = await api.sendForgotPasswordOtp(
        email: emailController.text.trim(),
      );

      isLoading = false;
      if (model?.status == true) {
        ToastHelper.showMessage(model?.msg ?? '');
        context.push(
          AppPaths.verifyOtp,
          extra: {'type': 2, 'email': emailController.text.trim()},
        );
      } else {
        ToastHelper.showErrorMessage(model?.msg ?? '');
      }
    } on FetchDataException catch (e) {
      // Handle API-side validation error
      isLoading = false;
      ToastHelper.showErrorMessage(e.toString());
    } on SocketException catch (e) {
      // Handle socket exception (e.g., no internet connection)
      isLoading = false;
      ToastHelper.showErrorMessage(e.message.toString());
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }
}
