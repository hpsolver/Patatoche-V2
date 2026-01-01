import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:patatoche_v2/constants/assets_resource.dart';
import 'package:patatoche_v2/constants/color_constants.dart';
import 'package:patatoche_v2/helpers/extensions.dart';
import 'package:patatoche_v2/widgets/image_view.dart';
import 'package:patatoche_v2/widgets/primary_button.dart';

class CommonDialogView extends StatelessWidget {
  final String title;
  final String subTitle;
  final String icon;
  final String okayButtonText;
  final Color okayTextColor;
  final Color okayButtonColor;
  final Color okayButtonBorderColor;
  final VoidCallback okayButtonClick;

  const CommonDialogView({
    super.key,
    required this.title,
    required this.subTitle,
    required this.icon,
    required this.okayTextColor,
    required this.okayButtonText,
    required this.okayButtonClick,
    required this.okayButtonColor,
    required this.okayButtonBorderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      decoration: BoxDecoration(
        color: ColorConstants.colorFFFFFF,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.r),
          topRight: Radius.circular(30.r),
        ),
      ),
      child: Stack(
        children: [
          Container(
            height: 165.h,
            decoration: BoxDecoration(
              color: ColorConstants.colorFFFFFF,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.r),
                topRight: Radius.circular(30.r),
              ),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  ColorConstants.colorF4CF9B,
                  ColorConstants.colorFFFFFF,
                ],
              ),
            ),
            child: ImageView(path: AssetsResource.popupBg),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 10.h),
                Container(
                  width: 48.w,
                  height: 6.h,
                  decoration: BoxDecoration(
                    color: ColorConstants.colorFFFFFF,
                    borderRadius: BorderRadius.circular(99.r),
                  ),
                ),
                SizedBox(height: 39.h),

                Container(
                  width: 68.w,
                  height: 68.w,
                  padding: EdgeInsets.all(20.w),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        ColorConstants.colorFFFFFF,
                        ColorConstants.colorFFECD0,
                      ],
                    ),
                    border: Border.all(
                      color: ColorConstants.colorEAC185,
                      width: 1.w,
                    ),
                  ),
                  child: ImageView(
                    path: icon,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                SizedBox(height: 23.h),
                Text(
                  title,
                ).semiBold(fontSize: 20.sp, color: ColorConstants.color22262C),
                SizedBox(height: 10.h),

                Text(subTitle).regular(
                  fontSize: 14.sp,
                  color: ColorConstants.color000000,
                  textAlign: TextAlign.center,
                ),

                SizedBox(height: 28.h),
                Row(
                  children: [
                    Expanded(
                      child: PrimaryButton(
                        width: 1.sw,
                        borderColor: ColorConstants.colorDADADA,
                        title: 'cancel'.tr(),
                        showBorder: true,
                        color: ColorConstants.colorFFFFFF,
                        textColor: ColorConstants.color000000,
                        onClick: () {
                          context.pop();
                        },
                      ),
                    ),
                    SizedBox(width: 18.w),
                    Expanded(
                      child: PrimaryButton(
                        width: 1.sw,
                        showBorder: true,
                        borderColor: okayButtonBorderColor,
                        color: okayButtonColor,
                        textColor: okayTextColor,
                        title: okayButtonText,
                        onClick: okayButtonClick,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30.h),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
