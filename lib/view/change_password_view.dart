import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:patatoche_v2/helpers/extensions.dart';
import 'package:patatoche_v2/provider/change_password_provider.dart';

import '../constants/assets_resource.dart';
import '../constants/color_constants.dart';
import '../helpers/common_textfield.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/image_view.dart';
import '../widgets/primary_button.dart';
import 'base_view.dart';

class ChangePasswordView extends StatelessWidget {
  const ChangePasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<ChangePasswordProvider>(
      builder: (context, provider, _) => Scaffold(
        bottomNavigationBar: Padding(
          padding: EdgeInsets.only(
            left: 21.w,
            right: 21.w,
            bottom: context.bottomSafePadding,
          ),
          child: PrimaryButton(
            isLoading: provider.isLoading,
            title: 'save_changes'.tr(),
            onClick: () async {
              await provider.updatePassword(context);
            },
          ),
        ),
        body: Container(
          width: 1.sw,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AssetsResource.background2),
              fit: BoxFit.cover,
            ),
          ),
          child: Form(
            key: provider.formKey,
            child: Column(
              children: [
                CustomAppBar(
                  backgroundColor: Colors.transparent,
                  centerTitle: true,
                  titleWidget: Text(
                    'change_password'.tr(),
                  ).regular(fontSize: 20.sp, color: ColorConstants.color000000),
                  onBack: () {
                    context.pop();
                  },
                ),
                SizedBox(height: 8.h),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('old_password'.tr()).medium(
                        color: ColorConstants.color343434,
                        fontSize: 16.sp,
                      ),
                      SizedBox(height: 2.h),

                      CommonTextField(
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.text,
                        controller: provider.oldPasswordController,
                        hintText: 'enter_old_password'.tr(),
                        obscureText: !provider.oldPassword,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'enter_old_password'.tr();
                          } else if (value.isNotEmpty &&
                              !value.isValidPassword) {
                            return 'password_must_be_at_least'.tr();
                          }
                          return null;
                        },
                        suffix: GestureDetector(
                          onTap: () {
                            provider.oldPassword = !provider.oldPassword;
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 8.h,
                            ),
                            child: ImageView(
                              path: provider.oldPassword
                                  ? AssetsResource.icShowPassword
                                  : AssetsResource.icHidePassword,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 15.h),

                      Text('new_password'.tr()).medium(
                        color: ColorConstants.color343434,
                        fontSize: 16.sp,
                      ),
                      SizedBox(height: 2.h),

                      CommonTextField(
                        controller: provider.newPasswordController,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'enter_new_password'.tr();
                          } else if (value.isNotEmpty &&
                              !value.isValidPassword) {
                            return 'password_must_be_at_least'.tr();
                          }
                          return null;
                        },
                        hintText: 'enter_new_password'.tr(),
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

                      SizedBox(height: 15.h),

                      Text('confirm_password'.tr()).medium(
                        color: ColorConstants.color343434,
                        fontSize: 16.sp,
                      ),
                      SizedBox(height: 2.h),

                      CommonTextField(
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.text,
                        onFieldSubmitted: (value){
                          provider.updatePassword(context);
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'enter_confirm_password'.tr();
                          } else if (value !=
                              provider.newPasswordController.text.trim()) {
                            return 'passwords_do_not_match'.tr();
                          }
                          return null;
                        },

                        controller: provider.confirmPasswordController,
                        hintText: 'enter_confirm_password'.tr(),

                        obscureText: !provider.confirmPassword,
                        suffix: GestureDetector(
                          onTap: () {
                            provider.confirmPassword =
                                !provider.confirmPassword;
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
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
