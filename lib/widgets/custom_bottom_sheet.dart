import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomBottomSheet {
  // Static method to show the bottom sheet with customizable content and style
  static Future<T?> show<T>({
    required BuildContext context,
    required Widget child, // Your template widget inside bottom sheet
    double? height, // Height of the bottom sheet container
    Color backgroundColor = Colors.transparent,
    ShapeBorder? shape,
    bool isScrollControlled = true,
    bool enableDrag = false,
    bool isDismissible = true,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: isScrollControlled,
      isDismissible: isDismissible,
      shape:
          shape ??
          RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
          ),
      backgroundColor: backgroundColor,
      enableDrag: enableDrag,
      builder: (BuildContext context) {
        return child;
      },
    );
  }
}
