import 'dart:async';
import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:patatoche_v2/enums/view_state.dart';
import 'package:patatoche_v2/helpers/shared_pref.dart';
import 'package:patatoche_v2/provider/base_provider.dart';
import '../helpers/toast_helper.dart';
import '../routes.dart';
import '../services/fetch_data_exception.dart';

class OtpProvider extends BaseProvider {
  String firstName = '';
  String lastName = '';
  String email = '';
  String password = '';

  Timer? resendTimer;
  int _start = 120;

  int get start => _start;

  set start(int value) {
    _start = value;
    customNotify();
  } // seconds

  bool _canResend = false;

  bool get canResend => _canResend;

  set canResend(bool value) {
    _canResend = value;
    customNotify();
  }

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    customNotify();
  }

  Future<void> verifyOtp(BuildContext context, {String? otp, int? type}) async {
    try {
      isLoading = true;

      if (type == 1) {
        await registerApi(context, otp);
      } else {
        await forgotPasswordVerifyOtpApi(context, otp);
      }
      isLoading = false;
    } on FetchDataException catch (e) {
      isLoading = false;
    } on SocketException catch (e) {
      ToastHelper.showErrorMessage('no_internet_connection'.tr());
      isLoading = false;
    }
  }

  void startResendTimer() {
    _canResend = false;
    _start = 120;

    resendTimer?.cancel(); // Cancel if already running
    resendTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_start == 0) {
        canResend = true;
        timer.cancel();
      } else {
        start--;
      }
    });
  }

  Future<void> resendOtp(BuildContext context, int? type) async {
    if (type == 1) {
      await sendRegisterOtpApi(context);
    } else if (type == 2) {
      await sendForgotPasswordOtpApi(context);
    }
  }

  Future<void> sendRegisterOtpApi(BuildContext context) async {
    try {
      setState(ViewState.busy);
      var model = await api.sendRegisterOtp(email: email);
      setState(ViewState.idle);
      if (model?.status == true) {
        ToastHelper.showMessage(model?.msg ?? '');
      } else {
        ToastHelper.showErrorMessage(model?.msg ?? '');
      }
    } on FetchDataException catch (e) {
      // Handle API-side validation error
      setState(ViewState.idle);
      ToastHelper.showErrorMessage(e.toString());
    } on SocketException catch (e) {
      // Handle socket exception (e.g., no internet connection)
      setState(ViewState.idle);
      ToastHelper.showErrorMessage(e.message.toString());
    }
  }

  Future<void> sendForgotPasswordOtpApi(BuildContext context) async {
    try {
      setState(ViewState.busy);
      var model = await api.sendForgotPasswordOtp(email: email);
      setState(ViewState.idle);
      if (model?.status == true) {
        ToastHelper.showMessage(model?.msg ?? '');
      } else {
        ToastHelper.showErrorMessage(model?.msg ?? '');
      }
    } on FetchDataException catch (e) {
      // Handle API-side validation error
      setState(ViewState.idle);
      ToastHelper.showErrorMessage(e.toString());
    } on SocketException catch (e) {
      // Handle socket exception (e.g., no internet connection)
      setState(ViewState.idle);
      ToastHelper.showErrorMessage(e.message.toString());
    }
  }

  Future<void> registerApi(BuildContext context, String? otp) async {
    try {
      isLoading = true;

      var model = await api.register(
        email: email,
        password: password,
        firstName: firstName,
        lastName: lastName,
        otp: otp ?? '',
      );

      isLoading = false;
      if (model?.status == true) {
        ToastHelper.showMessage(model?.msg ?? '');
        SharedPref.prefs?.setInt(SharedPref.userId, model?.userId ?? 0);
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

  Future<void> forgotPasswordVerifyOtpApi(
    BuildContext context,
    String? otp,
  ) async {
    try {
      isLoading = true;

      var model = await api.forgotPasswordVerifyOtp(
        email: email,
        otp: otp ?? '',
      );

      isLoading = false;
      if (model?.status == true) {
        context.pushNamed(AppPaths.resetPassword, extra: {'email': email});
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

  void setData({
    String? firstName,
    String? lastName,
    String? email,
    String? password,
  }) {
    this.firstName = firstName ?? '';
    this.lastName = lastName ?? '';
    this.email = email ?? '';
    this.password = password ?? '';
  }
}
