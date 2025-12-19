import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:patatoche_v2/constants/assets_resource.dart';
import 'package:patatoche_v2/constants/color_constants.dart';
import 'package:patatoche_v2/helpers/extensions.dart';
import 'package:patatoche_v2/provider/account_settings_provider.dart';
import 'package:patatoche_v2/view/base_view.dart';
import 'package:patatoche_v2/widgets/primary_button.dart';
import '../helpers/common_textfield.dart';
import '../widgets/custom_appbar.dart';

class AccountSettingsView extends StatelessWidget {
  const AccountSettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<AccountSettingsProvider>(
      builder: (context, provider, _) => Scaffold(
        bottomNavigationBar: Padding(
          padding: EdgeInsets.only(
            left: 21.w,
            right: 21.w,
            bottom: context.bottomSafePadding,
          ),
          child: PrimaryButton(title: 'save_changes'.tr(), onClick: () {}),
        ),
        body: Container(
          width: 1.sw,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AssetsResource.background2),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              CustomAppBar(
                backgroundColor: Colors.transparent,
                centerTitle: true,
                titleWidget: Text(
                  'account_settings'.tr(),
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
                    Text('first_name'.tr()).medium(
                      color: ColorConstants.color343434,
                      fontSize: 16.sp,
                    ),
                    SizedBox(height: 2.h),

                    CommonTextField(controller: provider.firstNameController),

                    SizedBox(height: 15.h),

                    Text('last_name'.tr()).medium(
                      color: ColorConstants.color343434,
                      fontSize: 16.sp,
                    ),
                    SizedBox(height: 2.h),

                    CommonTextField(controller: provider.lastNameController),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
