import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:patatoche_v2/enums/view_state.dart';
import 'package:patatoche_v2/helpers/extensions.dart';
import 'package:patatoche_v2/helpers/shared_pref.dart';
import 'package:patatoche_v2/provider/base_provider.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../helpers/toast_helper.dart';
import '../routes.dart';
import '../services/fetch_data_exception.dart';

class LoginProvider extends BaseProvider {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

  LoginProvider() {
    _googleSignIn.initialize(
      serverClientId:
          '628952148794-dpbld6ta31juio4s5gf2jice7udqaq7d.apps.googleusercontent.com',
    );
  }

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

  Future<void> googleSignIn(BuildContext context) async {
    setState(ViewState.busy);

    try {
      try {
        await _googleSignIn.disconnect();
        await _googleSignIn.signOut();
      } catch (_) {}

      // Authenticate the user
      final user = await _googleSignIn.authenticate();
      final auth = user.authentication;
      if (auth.idToken != null) {
        await socialLoginApi(context, 'google', auth.idToken!);
      } else {
        ToastHelper.showErrorMessage('something_went_wrong'.tr());
      }
    } catch (e) {
      debugPrint('Google Sign-In error: $e');
    } finally {
      setState(ViewState.idle);
    }
  }

  Future<void> appleSignIn(BuildContext context) async {
    setState(ViewState.busy);
    final credential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    );
    setState(ViewState.idle);
    String token = credential.identityToken ?? '';
    if (token.isNotEmpty) {
      debugPrint("Apple Sign-In successful");
    }
  }

  Future<void> socialLoginApi(
    BuildContext context,
    String provider,
    String idToken,
  ) async {
    try {
      var model = await api.socialLogin(provider: provider, idToken: idToken);

      setState(ViewState.idle);
      if (model?.success == true) {
        SharedPref.prefs?.setInt(SharedPref.userId, model?.userId ?? 0);
        context.go(AppPaths.dashboard);
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
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
