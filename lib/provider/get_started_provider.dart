import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:patatoche_v2/enums/view_state.dart';
import 'package:patatoche_v2/provider/base_provider.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../helpers/shared_pref.dart';
import '../helpers/toast_helper.dart';
import '../routes.dart';
import '../services/fetch_data_exception.dart';

class GetStartedProvider extends BaseProvider {
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

  GetStartedProvider() {
    _googleSignIn.initialize(
      serverClientId:
          '628952148794-dpbld6ta31juio4s5gf2jice7udqaq7d.apps.googleusercontent.com',
    );
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

  Future<void> appleSignIn() async {
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
}
