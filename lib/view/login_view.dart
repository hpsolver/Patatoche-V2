import 'dart:io';

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

import '../routes.dart';
import '../widgets/divider.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<LoginProvider>(
      builder: (context, provider, _) => Scaffold(
        appBar: CustomAppBar(
          centerTitle: true,
          titleWidget: Text(
            'welcome_back'.tr(),
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
                'please_enter_your'.tr(),
              ).regular(color: ColorConstants.color363636, fontSize: 16.sp),
              SizedBox(height: 20.h),
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
              SizedBox(height: 12.h),

              Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: () {
                    context.push(AppPaths.forgotPassword);
                  },
                  child: Text('forgot_password'.tr()).regular(
                    color: ColorConstants.color363636,
                    fontSize: 14.sp,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              SizedBox(height: 49.h),

              PrimaryButton(
                title: 'sign_in'.tr(),
                onClick: () {
                  context.go(AppPaths.dashboard);
                },
                width: 1.sw,
              ),

              SizedBox(height: 20.h),
              PrimaryButton(
                width: 1.sw,
                height: 52.h,
                iconPath: AssetsResource.icGoogle,
                color: ColorConstants.colorF5F5F5,
                textColor: ColorConstants.colorBCBCBC,
                title: 'sign_in_with_google'.tr(),
                onClick: () {},
              ),

              Visibility(
                visible: Platform.isIOS,
                child: Column(
                  children: [
                    SizedBox(height: 20.h),
                    PrimaryButton(
                      width: 1.sw,
                      height: 52.h,
                      iconPath: AssetsResource.icApple,
                      color: ColorConstants.color272727,
                      textColor: ColorConstants.colorFFFFFF,
                      title: 'sign_in_with_apple'.tr(),
                      onClick: () {},
                    ),
                  ],
                ),
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
                title: 'register_here'.tr(),
                onClick: () {
                  context.push(AppPaths.register);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
