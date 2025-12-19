import 'dart:async';
import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:patatoche_v2/provider/base_provider.dart';
import '../helpers/toast_helper.dart';
import '../services/fetch_data_exception.dart';

class OtpProvider extends BaseProvider {
  String? email;
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

  Future<void> resendOtp(BuildContext context) async {

  }
}
