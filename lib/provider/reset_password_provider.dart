import 'package:flutter/cupertino.dart';
import 'base_provider.dart';

class ResetPasswordProvider extends BaseProvider{

  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();


  bool _newPassword = false;

  bool get newPassword => _newPassword;

  set newPassword(bool value) {
    _newPassword = value;
    customNotify();
  }

  bool _confirmPassword = false;

  bool get confirmPassword => _confirmPassword;

  set confirmPassword(bool value) {
    _confirmPassword = value;
    customNotify();
  }
}