import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class ToastHelper {
  static showErrorMessage(String message) {
    toastification.show(
      title: Text(message,maxLines: 4,),
      type: ToastificationType.error,
      style: ToastificationStyle.minimal,
      autoCloseDuration: const Duration(seconds: 2),
    );
  }

  static showMessage(String message) {
    toastification.show(
      title: Text(message,maxLines: 4,),
      style: ToastificationStyle.minimal,
      type: ToastificationType.success,
      autoCloseDuration: const Duration(seconds: 2),
    );
  }
}
