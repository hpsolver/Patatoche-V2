import 'package:flutter/cupertino.dart';
import 'package:patatoche_v2/provider/base_provider.dart';

class ForgotProvider extends BaseProvider {
  final TextEditingController emailController = TextEditingController();



  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }
}
