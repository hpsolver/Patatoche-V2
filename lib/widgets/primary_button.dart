import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:patatoche_v2/helpers/extensions.dart';
import 'image_view.dart';

class PrimaryButton extends StatelessWidget {
  final String title;
  final double? width;
  final double? height;
  final double? radius;
  final String? iconPath;
  final Color? color;
  final Color? borderColor;
  final Color textColor;
  final Widget? widget;
  final double? fontSize;
  final bool? showBorder;
  final bool isLoading;

  final void Function() onClick;

  const PrimaryButton({
    super.key,
    required this.title,
    required this.onClick,
    this.width,
    this.height,
    this.radius,
    this.iconPath,
    this.textColor = Colors.white,
    this.color,
    this.fontSize,
    this.widget,
    this.showBorder,
    this.borderColor,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 52.h,
      width: width,
      decoration: BoxDecoration(
        color: color ?? Theme.of(context).primaryColor,
        border: showBorder == null
            ? null
            : Border.all(
                color: borderColor ?? Theme.of(context).primaryColor,
                width: 1.5,
              ),
        borderRadius: BorderRadius.all(Radius.circular(radius ?? 8.r)),
      ),
      child: ElevatedButton(
        onPressed: onClick,
        style: ButtonStyle(
          elevation: WidgetStateProperty.all(0),
          backgroundColor: WidgetStateProperty.all(
            color ?? Theme.of(context).primaryColor,
          ),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(radius ?? 8.r)),
            ),
          ),
        ),
        child: isLoading
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 32.w,
                    height: 32.w,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 3.w,
                    ),
                  ),
                ],
              )
            : (widget ??
                  (iconPath != null
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ImageView(path: iconPath!),
                            SizedBox(width: 10.w),
                            Center(
                              child: Text(title).medium(
                                fontSize: fontSize ?? 18.sp,
                                color: textColor,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        )
                      : Text(title).medium(
                          fontSize: fontSize ?? 18.sp,
                          color: textColor,
                          textAlign: TextAlign.center,
                        ))),
      ),
    );
  }
}
