import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:patatoche_v2/constants/color_constants.dart';
import 'package:patatoche_v2/helpers/extensions.dart';
import 'package:patatoche_v2/widgets/primary_button.dart';
import '../constants/assets_resource.dart';
import '../widgets/image_view.dart';

class SuccessView extends StatelessWidget {
  const SuccessView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AssetsResource.background),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 68.w,
                height: 68.w,
                padding: EdgeInsets.all(18.w),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      ColorConstants.colorFFFFFF,
                      ColorConstants.colorFFF4E3,
                    ],
                  ),
                  border: Border.all(
                    color: ColorConstants.colorFFECCE,
                    width: 1.w,
                  ),
                ),
                child: ImageView(path: AssetsResource.icSuccess),
              ),
              SizedBox(height: 15.h),
              Text(
                'youhoo'.tr(),
              ).medium(fontSize: 22.sp, color: Theme.of(context).primaryColor),
              SizedBox(height: 8.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 35.w),
                child: Text(
                  'your_patatoche_is_now'.tr(),
                  textAlign: TextAlign.center,
                ).regular(fontSize: 16.sp, color: ColorConstants.color363636),
              ),
              SizedBox(height: 35.h),

              PrimaryButton(
                width: 233.w,
                title: 'go_to_home'.tr(),
                onClick: () {
                  context.pop();
                  context.pop();
                  context.pop();
                },
                height: 52.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
