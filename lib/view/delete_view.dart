import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:patatoche_v2/constants/assets_resource.dart';
import 'package:patatoche_v2/constants/color_constants.dart';
import 'package:patatoche_v2/helpers/extensions.dart';
import 'package:patatoche_v2/routes.dart';
import 'package:patatoche_v2/widgets/image_view.dart';
import 'package:patatoche_v2/widgets/primary_button.dart';

import '../helpers/common_textfield.dart';

class DeleteView extends StatelessWidget {
  final String title;
  final String subTitle;

  const DeleteView({super.key, required this.title, required this.subTitle});

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
                  child: ImageView(path: AssetsResource.icDelete2),
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
                        onClick: () {},
                      ),
                    ),
                    SizedBox(width: 18.w),
                    Expanded(
                      child: PrimaryButton(
                        width: 1.sw,
                        showBorder: true,
                        borderColor: ColorConstants.colorFFE3DE,
                        color: ColorConstants.colorFFECEC,
                        textColor: ColorConstants.colorD1270B,
                        title: 'delete'.tr(),
                        onClick: () {},
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
