import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:patatoche_v2/constants/assets_resource.dart';
import 'package:patatoche_v2/constants/color_constants.dart';
import 'package:patatoche_v2/helpers/common_textfield.dart';
import 'package:patatoche_v2/helpers/extensions.dart';
import 'package:patatoche_v2/provider/forgot_provider.dart';
import 'package:patatoche_v2/routes.dart';
import 'package:patatoche_v2/view/base_view.dart';
import 'package:patatoche_v2/widgets/custom_appbar.dart';
import 'package:patatoche_v2/widgets/image_view.dart';
import 'package:patatoche_v2/widgets/primary_button.dart';

class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<ForgotProvider>(
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
                'enter_your_email_address'.tr(),
              ).regular(color: ColorConstants.color363636, fontSize: 16.sp),
              SizedBox(height: 20.h),
              Text(
                'email'.tr(),
              ).medium(color: ColorConstants.color343434, fontSize: 16.sp),
              SizedBox(height: 2.h),

              CommonTextField(controller: provider.emailController),

              SizedBox(height: 50.h),

              PrimaryButton(
                title: 'submit'.tr(),
                onClick: () {
                  context.push(AppPaths.verifyOtp, extra: {'type': 2});
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
