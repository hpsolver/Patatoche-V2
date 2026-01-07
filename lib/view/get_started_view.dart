import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:patatoche_v2/enums/view_state.dart';
import 'package:patatoche_v2/helpers/extensions.dart';
import 'package:patatoche_v2/provider/get_started_provider.dart';
import 'package:patatoche_v2/routes.dart';
import 'package:patatoche_v2/view/base_view.dart';
import '../constants/assets_resource.dart';
import '../constants/color_constants.dart';
import '../widgets/divider.dart';
import '../widgets/image_view.dart';
import '../widgets/primary_button.dart';

class GetStartedView extends StatelessWidget {
  const GetStartedView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<GetStartedProvider>(
      builder: (context, provider, _) => Scaffold(
        body: Stack(
          children: [
            ImageView(
              width: 1.sw,
              height: 1.sh,
              path: AssetsResource.onBoardingImg1,
              fit: BoxFit.cover,
            ),

            Positioned(
              bottom: 0,
              left: 1,
              right: 1,
              child: Stack(
                children: [
                  Container(
                    padding: EdgeInsets.only(
                      top: 19.h + 47.h,
                      left: 21.w,
                      right: 21.w,
                      bottom: 39.h,
                    ),
                    margin: EdgeInsets.only(top: 47.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.r),
                        topRight: Radius.circular(30.r),
                      ),
                      color: ColorConstants.colorFFFFFF,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 23.h),
                        Text('please_select_the_desired'.tr()).regular(
                          fontSize: 16.sp,
                          color: ColorConstants.color363636,
                        ),
                        SizedBox(height: 19.h),
                        PrimaryButton(
                          width: 1.sw,
                          height: 52.h,
                          title: 'continue_with_email'.tr(),
                          onClick: () {
                            context.push(
                              AppPaths.register,
                              extra: {'from': 'get_started'},
                            );
                          },
                        ),
                        SizedBox(height: 20.h),
                        PrimaryButton(
                          width: 1.sw,
                          height: 52.h,
                          iconPath: AssetsResource.icGoogle,
                          color: ColorConstants.colorF5F5F5,
                          textColor: ColorConstants.colorBCBCBC,
                          title: 'sign_in_with_google'.tr(),
                          onClick: () async {
                            if (provider.state == ViewState.idle) {
                              await provider.googleSignIn(context);
                            }
                          },
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
                                onClick: () async {
                                  if (provider.state == ViewState.idle) {
                                    await provider.appleSignIn();
                                  }
                                },
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
                              child: Text('already_have_an_account'.tr())
                                  .regular(
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
                            context.push(AppPaths.login);
                          },
                        ),
                      ],
                    ),
                  ),
                  Center(
                    child: ImageView(
                      path: AssetsResource.appIconRounded,
                      width: 134.w,
                    ),
                  ),
                ],
              ),
            ),

            Visibility(
              visible: provider.state == ViewState.busy,
              child: Positioned.fill(
                child: Container(
                  color: Colors.black.withValues(alpha: 0.5),
                  child: const Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
