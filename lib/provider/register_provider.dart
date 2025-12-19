import 'package:flutter/cupertino.dart';
import 'package:patatoche_v2/provider/base_provider.dart';

class RegisterProvider extends BaseProvider{

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

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
}