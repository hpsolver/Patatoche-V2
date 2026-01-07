import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:patatoche_v2/enums/view_state.dart';
import 'package:patatoche_v2/helpers/extensions.dart';
import 'package:patatoche_v2/provider/base_provider.dart';

import '../helpers/shared_pref.dart';
import '../helpers/toast_helper.dart';
import '../services/fetch_data_exception.dart';

class AccountSettingsProvider extends BaseProvider {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();

  Future<void> updateProfile(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      context.hideKeyboard();
      await updateProfileApi(context);
    }
  }

  Future<void> updateProfileApi(BuildContext context) async {
    try {
      setState(ViewState.busy);
      int userId = SharedPref.prefs?.getInt(SharedPref.userId) ?? 0;

      Map<String, dynamic> request = {
        "user_id": userId,
        "first_name": firstNameController.text.trim(),
        "last_name": lastNameController.text.trim(),
      };

      var model = await api.updateProfile(request: request);

      setState(ViewState.idle);

      if (model?.success == true) {
        ToastHelper.showMessage(model?.message ?? '');
        context.pop();
      } else {
        ToastHelper.showErrorMessage(model?.message ?? '');
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

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    super.dispose();
  }
}
