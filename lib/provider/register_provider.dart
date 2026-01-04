import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:patatoche_v2/helpers/extensions.dart';
import 'package:patatoche_v2/helpers/toast_helper.dart';
import 'package:patatoche_v2/provider/base_provider.dart';

import '../routes.dart';
import '../services/fetch_data_exception.dart';

class RegisterProvider extends BaseProvider {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    customNotify();
  }

  bool _showPassword = false;

  bool get showPassword => _showPassword;

  set showPassword(bool value) {
    _showPassword = value;
    customNotify();
  }

  bool _showConfirmPassword = false;

  bool get showConfirmPassword => _showConfirmPassword;

  set showConfirmPassword(bool value) {
    _showConfirmPassword = value;
    customNotify();
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> register(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      context.hideKeyboard();
      await sendRegisterOtpApi(context);
    }
  }

  Future<void> sendRegisterOtpApi(BuildContext context) async {
    try {
      isLoading = true;

      var model = await api.sendRegisterOtp(email: emailController.text.trim());

      isLoading = false;
      if (model?.status == true) {
        ToastHelper.showMessage(model?.msg ?? '');
        context.push(
          AppPaths.verifyOtp,
          extra: {
            'type': 1,
            'first_name': firstNameController.text.trim(),
            'last_name': lastNameController.text.trim(),
            'email': emailController.text.trim(),
            'password': passwordController.text.trim(),
          },
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
}
