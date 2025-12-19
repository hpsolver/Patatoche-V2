import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/string_constants.dart';

extension DateFormatter on DateTime {
  String format(String pattern) {
    return DateFormat(pattern).format(this.toLocal());
  }
}

extension StringCasingExtension on String {
  String toCapitalized() {
    if (isEmpty) return this;
    return this[0].toUpperCase() + substring(1).toLowerCase();
  }

  String toTitleCase() {
    return split(' ').map((word) => word.toCapitalized()).join(' ');
  }
}

extension TextStyleExtension on Text {
  Text bold({
    double? fontSize,
    Color? color,
    TextAlign? textAlign,
    double? letterSpacing,
  }) {
    return _applyStyle(
      fontSize: fontSize,
      fontWeight: FontWeight.w700,
      color: color,
      textAlign: textAlign,
      fontFamily: StringConstants.fontFamilyFredoka,
      letterSpacing: letterSpacing,
    );
  }

  Text semiBold({double? fontSize, Color? color, TextAlign? textAlign}) {
    return _applyStyle(
      fontSize: fontSize,
      fontWeight: FontWeight.w600,
      color: color,
      textAlign: textAlign,
      fontFamily: StringConstants.fontFamilyFredoka,
    );
  }

  Text medium({double? fontSize, Color? color, TextAlign? textAlign}) {
    return _applyStyle(
      fontSize: fontSize,
      fontWeight: FontWeight.w500,
      color: color,
      textAlign: textAlign,
      fontFamily: StringConstants.fontFamilyFredoka,
    );
  }

  Text regular({
    double? fontSize,
    Color? color,
    TextAlign? textAlign,
    TextOverflow? textOverflow,
    TextDecoration? decoration,
  }) {
    return _applyStyle(
      fontSize: fontSize,
      fontWeight: FontWeight.w400,
      color: color,
      textAlign: textAlign,
      fontFamily: StringConstants.fontFamilyFredoka,
      textOverflow: textOverflow,
      letterSpacing: 0,
      decoration: decoration,
    );
  }

  Text _applyStyle({
    FontWeight? fontWeight,
    double? fontSize,
    Color? color,
    TextAlign? textAlign,
    String? fontFamily,
    List<Shadow>? shadows,
    double? letterSpacing,
    TextOverflow? textOverflow,
    TextDecoration? decoration,
  }) {
    final defaultStyle = this.style ?? const TextStyle();

    return Text(
      data ?? '',
      textAlign: textAlign ?? this.textAlign,
      maxLines: maxLines,
      style: defaultStyle.copyWith(
        fontWeight: fontWeight,
        fontSize: fontSize,
        color: color,
        fontFamily: fontFamily,
        shadows: shadows,
        letterSpacing: letterSpacing ?? 0.0,
        overflow: textOverflow,
        decoration: decoration,
      ),
    );
  }
}

extension HideKeyboardExtension on BuildContext {
  void hideKeyboard() {
    FocusScope.of(this).unfocus();
  }
}

extension ContextExtensions on BuildContext {
  /// Returns a SizedBox with height equal to status bar height
  SizedBox get statusBarHeightBox =>
      SizedBox(height: MediaQuery.of(this).padding.top);

  /// Returns just the status bar height as double
  double get statusBarHeight => MediaQuery.of(this).padding.top;
}

extension Validator on String {
  bool get isValidEmail {
    final RegExp emailRegExp = RegExp(r'^[\w.+-]+@([\w-]+\.)+[\w-]{2,}$');
    return emailRegExp.hasMatch(this);
  }

  bool get isValidPassword {
    if (isEmpty) {
      return false;
    }
    if (length < 8) {
      return false;
    }
    if (!contains(RegExp(r'[A-Z]'))) {
      return false;
    }
    if (!contains(RegExp(r'[a-z]'))) {
      return false;
    }
    if (!contains(RegExp(r'[0-9]'))) {
      return false;
    }
    // Adjust the set of special characters as needed
    if (!contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return false;
    }
    return true; // All checks passed
  }
}

extension TimeFormatter on int {
  String formatTime() {
    final minutes = (this ~/ 60).toString().padLeft(2, '0');
    final secs = (this % 60).toString().padLeft(2, '0');
    return "$minutes:$secs";
  }
}

extension StringInitials on String {
  String get initials {
    final parts = trim().split(RegExp(r"\s+"));

    if (parts.length >= 2) {
      return (parts[0][0] + parts[1][0]).toUpperCase();
    } else if (parts.isNotEmpty) {
      return parts[0].substring(0, parts[0].length >= 2 ? 2 : 1).toUpperCase();
    }
    return "";
  }
}

extension BottomPaddingExtension on BuildContext {
  double get bottomSafePadding {
    return MediaQuery.of(this).padding.bottom + (Platform.isIOS ? 0 : 24.h);
  }
}
