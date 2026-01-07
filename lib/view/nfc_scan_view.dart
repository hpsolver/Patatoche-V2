import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gif_view/gif_view.dart';
import 'package:go_router/go_router.dart';
import 'package:patatoche_v2/constants/assets_resource.dart';
import 'package:patatoche_v2/constants/color_constants.dart';
import 'package:patatoche_v2/helpers/extensions.dart';
import 'package:patatoche_v2/provider/nfc_scan_view_provider.dart';
import 'package:patatoche_v2/view/base_view.dart';
import 'package:patatoche_v2/widgets/image_view.dart';
import 'package:patatoche_v2/widgets/primary_button.dart';

class NfcScanView extends StatelessWidget {
  const NfcScanView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<NfcScanViewProvider>(
      onModelReady: (provider) {
        provider.readNfcTag(context);
      },
      builder: (context, provider, _) => Container(
        width: 1.sw,
        padding: EdgeInsets.only(top: 21.h),
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
            Text(
              'nfc_reading_approach_your_phone'.tr(),
            ).medium(fontSize: 16.sp, color: ColorConstants.color363636),
            SizedBox(height: 47.h),
            ImageView(path: AssetsResource.icScan, width: 99.w),
            /* GifView.asset(AssetsResource.scanGif,
            frameRate: 30,
          ),*/
            SizedBox(height: 34.h),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 21.w),
              padding: EdgeInsets.only(
                top: 19.h,
                bottom: 16.h,
                left: 32.w,
                right: 32.w,
              ),
              decoration: BoxDecoration(
                color: ColorConstants.colorFFFFFF,
                borderRadius: BorderRadius.circular(14.r),
                boxShadow: [
                  BoxShadow(
                    color: ColorConstants.color000000.withValues(alpha: .05),
                    offset: Offset(0, 10),
                    blurRadius: 28.r,
                    spreadRadius: 14.r,
                  ),
                ],
              ),
              child: Column(
                children: [
                  Text('hold_your_phone_against_the_card'.tr()).regular(
                    fontSize: 16.sp,
                    color: ColorConstants.color363636,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    'it_tickles_a_little_but_patatoche_loves_it'.tr(),
                  ).regular(
                    fontSize: 16.sp,
                    color: ColorConstants.color363636,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 21.h),
                  Text('make_sure_nfc_is_enabled'.tr()).regular(
                    fontSize: 14.sp,
                    color: Theme.of(context).primaryColor,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            SizedBox(height: 22.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 21.w),
              child: PrimaryButton(
                width: 1.sw,
                title: 'cancel'.tr(),
                onClick: () async {
                  await provider.stopSession();
                  context.pop();
                },
              ),
            ),
            SizedBox(height: 30.h),
          ],
        ),
      ),
    );
  }
}
