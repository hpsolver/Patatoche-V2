import 'package:flutter/cupertino.dart';
import 'package:patatoche_v2/provider/base_provider.dart';

class LoginProvider extends BaseProvider{

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _showPassword = false;

  bool get showPassword => _showPassword;

  set showPassword(bool value) {
    _showPassword = value;
    customNotify();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}