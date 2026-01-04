import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:patatoche_v2/helpers/extensions.dart';
import '../helpers/toast_helper.dart';
import '../services/fetch_data_exception.dart';
import 'base_provider.dart';

class ResetPasswordProvider extends BaseProvider {
  String email = '';

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    customNotify();
  }

  bool _newPassword = false;

  bool get newPassword => _newPassword;

  set newPassword(bool value) {
    _newPassword = value;
    customNotify();
  }

  bool _confirmPassword = false;

  bool get confirmPassword => _confirmPassword;

  set confirmPassword(bool value) {
    _confirmPassword = value;
    customNotify();
  }

  Future<void> resetPassword(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      context.hideKeyboard();
      await resetPasswordApi(context);
    }
  }

  Future<void> resetPasswordApi(BuildContext context) async {
    try {
      isLoading = true;

      var model = await api.forgotPassword(
        email: email,
        password: newPasswordController.text.trim(),
      );

      isLoading = false;

      if (model?.status == true) {
        ToastHelper.showMessage(model?.msg ?? '');
        context.pop();
        context.pop();
        context.pop();
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
}
