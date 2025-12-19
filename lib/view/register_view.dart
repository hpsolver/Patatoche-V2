import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:patatoche_v2/constants/assets_resource.dart';
import 'package:patatoche_v2/constants/color_constants.dart';
import 'package:patatoche_v2/helpers/common_textfield.dart';
import 'package:patatoche_v2/helpers/extensions.dart';
import 'package:patatoche_v2/provider/login_provider.dart';
import 'package:patatoche_v2/provider/register_provider.dart';
import 'package:patatoche_v2/view/base_view.dart';
import 'package:patatoche_v2/widgets/custom_appbar.dart';
import 'package:patatoche_v2/widgets/image_view.dart';
import 'package:patatoche_v2/widgets/primary_button.dart';

import '../routes.dart';
import '../widgets/divider.dart';

class RegisterView extends StatelessWidget {
  final String? from;

  const RegisterView({super.key, this.from});

  @override
  Widget build(BuildContext context) {
    return BaseView<RegisterProvider>(
      builder: (context, provider, _) => Scaffold(
        appBar: CustomAppBar(
          centerTitle: true,
          titleWidget: Text(
            'create_your_account'.tr(),
          ).medium(color: ColorConstants.color363636, fontSize: 20.sp),
          onBack: () {
            context.pop();
          },
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 4.h),
              Text(
                'please_select_the_desired_method'.tr(),
              ).regular(color: ColorConstants.color363636, fontSize: 16.sp),
              SizedBox(height: 20.h),
              Text(
                'first_name'.tr(),
              ).medium(color: ColorConstants.color343434, fontSize: 16.sp),
              SizedBox(height: 2.h),

              CommonTextField(controller: provider.firstNameController),
              SizedBox(height: 17.5.h),
              Text(
                'last_name'.tr(),
              ).medium(color: ColorConstants.color343434, fontSize: 16.sp),
              SizedBox(height: 2.h),

              CommonTextField(controller: provider.lastNameController),
              SizedBox(height: 17.5.h),
              Text(
                'email'.tr(),
              ).medium(color: ColorConstants.color343434, fontSize: 16.sp),
              SizedBox(height: 2.h),

              CommonTextField(controller: provider.emailController),
              SizedBox(height: 17.5.h),
              Text(
                'password'.tr(),
              ).medium(color: ColorConstants.color343434, fontSize: 16.sp),
              SizedBox(height: 2.h),

              CommonTextField(
                controller: provider.passwordController,
                obscureText: !provider.showPassword,
                suffix: GestureDetector(
                  onTap: () {
                    provider.showPassword = !provider.showPassword;
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 8.h,
                    ),
                    child: ImageView(
                      path: provider.showPassword
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

                obscureText: !provider.showConfirmPassword,
                suffix: GestureDetector(
                  onTap: () {
                    provider.showConfirmPassword =
                        !provider.showConfirmPassword;
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 8.h,
                    ),
                    child: ImageView(
                      path: provider.showConfirmPassword
                          ? AssetsResource.icShowPassword
                          : AssetsResource.icHidePassword,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 30.h),

              PrimaryButton(
                title: 'create_my_account'.tr(),
                onClick: () {
                  context.push(AppPaths.verifyOtp, extra: {'type': 1});
                },
                width: 1.sw,
              ),

              SizedBox(height: 20.h),

              Row(
                children: [
                  Expanded(child: DividerWidget()),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    child: Text('already_have_an_account'.tr()).regular(
                      fontSize: 16.sp,
                      color: ColorConstants.colorBCBCBC,
                    ),
                  ),

                  Expanded(child: DividerWidget()),
                ],
              ),

              SizedBox(height: 20.h),
              PrimaryButton(
                width: 1.sw,
                height: 52.h,
                color: ColorConstants.colorFFFFFF,
                textColor: Theme.of(context).primaryColor,
                showBorder: true,
                title: 'log_in_here'.tr(),
                onClick: () {
                  if (from != null && from == 'get_started') {
                    context.pushReplacement(AppPaths.login);
                  } else {
                    context.pop();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
