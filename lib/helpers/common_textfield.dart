import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../constants/color_constants.dart';
import '../constants/string_constants.dart';

class CommonTextField extends StatelessWidget {
  final Function(String? value)? onChange;
  final FocusNode? focusNode;
  final TextEditingController controller;
  final String? hintText;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? suffix;
  final Widget? preffix;
  final bool isRead;
  final bool obscureText;
  final bool autocorrect;
  final bool enableSuggestions;
  final int length;
  final int maxLines;
  final Color? borderColor;
  final Color? fillColor;
  final Color? hintColor;
  final double? borderRadius;
  final EdgeInsetsGeometry? contentPadding;
  final Function()? onTap;
  final TextInputAction textInputAction;
  final TextCapitalization textCapitalization;
  final String? Function(String? value)? validator;
  final TextAlign textAlign;

  const CommonTextField({
    super.key,
    this.onChange,
    this.focusNode,
    required this.controller,
    this.hintText,
    this.keyboardType,
    this.inputFormatters,
    this.suffix,
    this.preffix,
    this.isRead = false,
    this.obscureText = false,
    this.autocorrect = true,
    this.enableSuggestions = true,
    this.length = 256,
    this.maxLines = 1,
    this.borderColor,
    this.fillColor,
    this.hintColor,
    this.borderRadius,
    this.contentPadding,
    this.onTap,
    this.textInputAction = TextInputAction.done,
    this.textCapitalization = TextCapitalization.none,
    this.validator,
    this.textAlign = TextAlign.start,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      inputFormatters: inputFormatters ?? [],
      keyboardType: keyboardType ?? TextInputType.text,
      controller: controller,
      cursorColor: ColorConstants.colorFF2C20,
      readOnly: isRead,
      focusNode: focusNode,
      obscureText: obscureText,
      maxLength: length,
      textAlign: textAlign,
      textInputAction: textInputAction,
      obscuringCharacter: '*',
      textCapitalization: textCapitalization,
      onChanged: onChange ?? (value) {},
      autocorrect: autocorrect,
      enableSuggestions: enableSuggestions,
      style: TextStyle(
        color: ColorConstants.color363636,
        fontSize: 16.sp,
        fontFamily: StringConstants.fontFamilyFredoka,
        fontWeight: FontWeight.w400,
      ),
      onTap: onTap,
      decoration: InputDecoration(
        fillColor: fillColor,
        filled: fillColor != null,
        errorMaxLines: 3,
        suffixIconConstraints: BoxConstraints(minHeight: 24.w, minWidth: 24.w),
        prefixIconConstraints: BoxConstraints(minHeight: 24.w, minWidth: 24.w),
        prefixIcon: preffix,
        counterText: '',
        hintText: hintText,
        hintStyle: TextStyle(
          color: hintColor ?? ColorConstants.colorBCBCBC,
          fontSize: 16.sp,
          fontFamily: StringConstants.fontFamilyFredoka,
          fontWeight: FontWeight.w400,
        ),
        errorText: null,
        border: border(borderColor, borderRadius),
        enabledBorder: border(borderColor, borderRadius),
        focusedBorder: focusedBorder(borderColor, borderRadius),
        disabledBorder: border(borderColor, borderRadius),
        focusedErrorBorder: errorBorder(borderRadius),
        suffixIcon: suffix,
        errorBorder: errorBorder(borderRadius),
        contentPadding:
            contentPadding ??
            EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      ),
    );
  }
}

OutlineInputBorder border(Color? borderColor, double? borderRadius) =>
    OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius ?? 8.r),
      borderSide: BorderSide(
        width: 1,
        color: borderColor ?? ColorConstants.colorBBBBBB,
      ),
    );

OutlineInputBorder focusedBorder(Color? borderColor, double? borderRadius) =>
    OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius ?? 8.r),
      borderSide: BorderSide(
        width: 1,
        color: borderColor ?? ColorConstants.primaryColor,
      ),
    );

OutlineInputBorder errorBorder(double? borderRadius) => OutlineInputBorder(
  borderRadius: BorderRadius.circular(borderRadius ?? 8.r),
  borderSide: BorderSide(width: 1, color: ColorConstants.colorFF2C20),
);
