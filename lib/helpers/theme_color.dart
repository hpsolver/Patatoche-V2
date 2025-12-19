import 'package:flutter/material.dart';
import '../constants/color_constants.dart';

ThemeData? activeTheme;

final lightTheme = ThemeData(
  primaryColor: const Color(0xFFD4A055),
  brightness: Brightness.light,
  scaffoldBackgroundColor: ColorConstants.colorFFFFFF,
  colorScheme: ColorScheme.fromSwatch(
    primarySwatch: primaryColor,
    backgroundColor: ColorConstants.colorFFFFFF,
  ),
);

MaterialColor primaryColor = const MaterialColor(0xFFD4A055, <int, Color>{
  50: Color(0xFFD4A055),
  100: Color(0xFFD4A055),
  200: Color(0xFFD4A055),
  300: Color(0xFFD4A055),
  400: Color(0xFFD4A055),
  500: Color(0xFFD4A055),
  600: Color(0xFFD4A055),
  700: Color(0xFFD4A055),
  800: Color(0xFFD4A055),
  900: Color(0xFFD4A055),
});
