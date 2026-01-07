import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:patatoche_v2/enums/view_state.dart';
import 'package:patatoche_v2/provider/base_provider.dart';
import '../helpers/shared_pref.dart';
import '../helpers/toast_helper.dart';
import '../services/fetch_data_exception.dart';

class ActivationCodeProvider extends BaseProvider {
  Future<void> checkActivationCode(
    BuildContext context, {
    required String batchCode,
    required String activationCode,
  }) async {
    try {
      setState(ViewState.busy);
      int userId = SharedPref.prefs?.getInt(SharedPref.userId) ?? 0;

      var model = await api.checkActivationCode(
        batchId: batchCode,
        activationCode: activationCode,
        userId: userId,
      );
      setState(ViewState.idle);
      if (model?.success ?? false) {
        context.pop(model?.data?.id);
      } else {
        ToastHelper.showErrorMessage(model?.message ?? "");
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
}
