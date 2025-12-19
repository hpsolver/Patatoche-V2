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

class ActivationCodeView extends StatefulWidget {
  const ActivationCodeView({super.key});

  @override
  ActivationCodeViewState createState() => ActivationCodeViewState();
}

class ActivationCodeViewState extends State<ActivationCodeView> {
  final TextEditingController _codeController = TextEditingController();

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      padding: EdgeInsets.only(top: 26.h, left: 21.w, right: 21.w),
      decoration: BoxDecoration(
        color: ColorConstants.colorFFFFFF,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.r),
          topRight: Radius.circular(30.r),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 68.w,
            height: 68.w,
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  ColorConstants.colorFFFFFF,
                  ColorConstants.colorFFF4E3,
                ],
              ),
              border: Border.all(color: ColorConstants.colorFFECCE, width: 1.w),
            ),
            child: ImageView(path: AssetsResource.icLock, width: 99.w),
          ),
          SizedBox(height: 20.h),
          Text(
            'activation_code'.tr(),
          ).medium(fontSize: 16.sp, color: ColorConstants.color363636),
          SizedBox(height: 12.h),

          Text('it_printed_on_the_flyer_inside_your_packaging'.tr()).regular(
            fontSize: 14.sp,
            color: ColorConstants.color363636,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 12.h),

          CommonTextField(
            controller: _codeController,
            hintText: 'enter_activation_code'.tr(),
            textAlign: TextAlign.center,
          ),

          SizedBox(height: 20.h),
          PrimaryButton(
            width: 1.sw,
            title: 'validate_code'.tr(),
            onClick: () {
              context.pushNamed(AppPaths.createMemory);
            },
          ),
          SizedBox(height: 30.h),
        ],
      ),
    );
  }
}
