import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:patatoche_v2/provider/base_provider.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class GetStartedProvider extends BaseProvider {
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

  GetStartedProvider() {
    _googleSignIn.initialize(
      serverClientId:
          '628952148794-dpbld6ta31juio4s5gf2jice7udqaq7d.apps.googleusercontent.com',
    );
  }

  Future<void> googleSignIn() async {
    try {
      final user = await _googleSignIn.authenticate(
        scopeHint: ['email', 'profile',],
      );

      debugPrint(user.displayName);
      debugPrint(user.email);
      debugPrint(user.photoUrl);
      debugPrint(user.id);

      final auth = user.authentication;
      debugPrint(auth.idToken);
    } catch (e) {
      debugPrint('Google Sign-In error: $e');
    }
  }

  Future<void> appleSignIn() async {
    final credential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    );

    String token = credential.identityToken ?? '';
    if (token.isNotEmpty) {
      debugPrint("Apple Sign-In successful");
    }
  }

  Future<void> googleSignOut() async {
    await _googleSignIn.signOut();
  }
}
