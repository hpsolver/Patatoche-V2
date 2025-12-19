import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:patatoche_v2/constants/assets_resource.dart';
import 'package:patatoche_v2/constants/color_constants.dart';
import 'package:patatoche_v2/helpers/common_textfield.dart';
import 'package:patatoche_v2/helpers/extensions.dart';
import 'package:patatoche_v2/provider/login_provider.dart';
import 'package:patatoche_v2/view/base_view.dart';
import 'package:patatoche_v2/widgets/custom_appbar.dart';
import 'package:patatoche_v2/widgets/image_view.dart';
import 'package:patatoche_v2/widgets/primary_button.dart';

import '../provider/reset_password_provider.dart';
import '../routes.dart';
import '../widgets/divider.dart';

class ResetPasswordView extends StatelessWidget {
  const ResetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<ResetPasswordProvider>(
      builder: (context, provider, _) => Scaffold(
        appBar: CustomAppBar(
          centerTitle: true,
          titleWidget: Text(
            'reset_your_password'.tr(),
          ).medium(color: ColorConstants.color363636, fontSize: 20.sp),
          onBack: () {
            context.pop();
          },
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 4.h),
              Text(
                'enter_a_new_password'.tr(),
              ).regular(color: ColorConstants.color363636, fontSize: 16.sp),
              SizedBox(height: 20.h),
              Text(
                'new_password'.tr(),
              ).medium(color: ColorConstants.color343434, fontSize: 16.sp),
              SizedBox(height: 2.h),

              CommonTextField(
                controller: provider.newPasswordController,
                obscureText: !provider.newPassword,
                suffix: GestureDetector(
                  onTap: () {
                    provider.newPassword = !provider.newPassword;
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 8.h,
                    ),
                    child: ImageView(
                      path: provider.newPassword
                          ? AssetsResource.icShowPassword
                          : AssetsResource.icHidePassword,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 17.5.h),
              Text(
                'confirm_password'.tr(),
              ).medium(color: ColorConstants.color343434, fontSize: 16.sp),
              SizedBox(height: 2.h),

              CommonTextField(
                controller: provider.confirmPasswordController,
                obscureText: !provider.confirmPassword,
                suffix: GestureDetector(
                  onTap: () {
                    provider.confirmPassword = !provider.confirmPassword;
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 8.h,
                    ),
                    child: ImageView(
                      path: provider.confirmPassword
                          ? AssetsResource.icShowPassword
                          : AssetsResource.icHidePassword,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 44.h),

              PrimaryButton(
                title: 'submit'.tr(),
                onClick: () {
                  context.pop();
                  context.pop();
                  context.pop();
                },
                width: 1.sw,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
