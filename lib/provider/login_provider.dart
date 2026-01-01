import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:patatoche_v2/helpers/extensions.dart';
import 'package:patatoche_v2/helpers/shared_pref.dart';
import 'package:patatoche_v2/provider/base_provider.dart';

import '../helpers/toast_helper.dart';
import '../routes.dart';
import '../services/fetch_data_exception.dart';

class LoginProvider extends BaseProvider {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _showPassword = false;

  bool get showPassword => _showPassword;

  set showPassword(bool value) {
    _showPassword = value;
    customNotify();
  }

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    customNotify();
  }

  Future<void> login(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      context.hideKeyboard();
      await loginApi(context);
    }
  }

  Future<void> loginApi(BuildContext context) async {
    try {
      isLoading = true;

      var model = await api.login(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      isLoading = false;
      if (model?.status == true) {
        SharedPref.prefs?.setInt(SharedPref.userId, model?.data?.userId ?? 0);
        context.go(AppPaths.dashboard);
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
    passwordController.dispose();
    super.dispose();
  }
}
