import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:patatoche_v2/constants/color_constants.dart';
import 'package:patatoche_v2/helpers/extensions.dart';
import 'package:patatoche_v2/provider/membership_plan_provider.dart';
import 'package:patatoche_v2/view/base_view.dart';
import 'package:patatoche_v2/widgets/custom_appbar.dart';
import 'package:patatoche_v2/widgets/image_view.dart';
import 'package:patatoche_v2/widgets/primary_button.dart';
import '../constants/assets_resource.dart';

class MembershipPlanView extends StatelessWidget {
  const MembershipPlanView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<MembershipPlanProvider>(
      builder: (context, provider, _) => Scaffold(
        body: Container(
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
                onBack: () {
                  context.pop();
                },
                centerTitle: true,
                titleWidget: Text(
                  'choose_your_plan'.tr(),
                ).medium(fontSize: 20.sp, color: ColorConstants.color363636),
              ),
              SizedBox(height: 4.h),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.only(
                    left: 20.w,
                    right: 20.w,
                    bottom: 32.h,
                  ),
                  shrinkWrap: true,
                  children: [
                    _planItemBuilder(
                      context,
                      title: 'starter'.tr(),
                      subtitle: 'perfect_to_get_started'.tr(),
                      borderColor: Theme.of(context).primaryColor,
                      headerColors: [
                        ColorConstants.colorFFF0DB,
                        ColorConstants.colorFFFFFF.withValues(alpha: .8),
                      ],
                      primaryColor: Theme.of(context).primaryColor,
                      showBorder: true,
                      price: 'free'.tr(),
                      type: 0,
                    ),
                    SizedBox(height: 20),
                    _planItemBuilder(
                      context,
                      title: 'comfort'.tr(),
                      subtitle: 'for_special_moments'.tr(),
                      borderColor: ColorConstants.color8C9764,
                      headerColors: [
                        ColorConstants.colorDBE3BD,
                        ColorConstants.colorFFFFFF.withValues(alpha: .8),
                      ],
                      primaryColor: ColorConstants.color8C9764,
                      price: '\$100',
                      type: 1,
                    ),
                    SizedBox(height: 20),
                    _planItemBuilder(
                      context,
                      title: 'suprama'.tr(),
                      subtitle: 'unlimited_memories'.tr(),
                      borderColor: ColorConstants.colorDE917D,
                      headerColors: [
                        ColorConstants.colorFFEBE5,
                        ColorConstants.colorFFFFFF.withValues(alpha: .8),
                      ],
                      primaryColor: ColorConstants.colorDE917D,
                      price: '\$200',
                      type: 2,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _planItemBuilder(
    BuildContext context, {
    required String title,
    required String subtitle,
    required Color borderColor,
    required Color primaryColor,
    required List<Color> headerColors,
    bool showBorder = false,
    required String price,
    required int type,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: ColorConstants.colorFFFFFF,
        border: showBorder ? Border.all(color: borderColor) : null,
        borderRadius: BorderRadius.circular(22.r),
        boxShadow: [
          BoxShadow(
            color: primaryColor.withValues(alpha: .15),
            offset: Offset(0, 4),
            spreadRadius: 0,
            blurRadius: 32.r,
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 1.sw,
            padding: EdgeInsets.symmetric(horizontal: 13.w, vertical: 17.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(22.r),
                topRight: Radius.circular(22.r),
              ),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: headerColors,
              ),
            ),

            child: Row(
              children: [
                Container(
                  width: 37.w,
                  height: 37.w,
                  padding: EdgeInsets.only(
                    left: 8.w,
                    right: 8.w,
                    bottom: 8.h,
                    top: 11.h,
                  ),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: primaryColor,
                  ),
                  child: ImageView(path: AssetsResource.icDiamond, width: 19.w),
                ),
                SizedBox(width: 8.w),
                Text(
                  title,
                ).medium(fontSize: 18.sp, color: ColorConstants.color000000),
                Text(
                  ' - ',
                ).regular(fontSize: 14.sp, color: ColorConstants.color000000),

                Text(subtitle).regular(fontSize: 14.sp, color: primaryColor),
              ],
            ),
          ),
          ListView(
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.only(left: 15.w, right: 15.w),
            shrinkWrap: true,
            children: [
              _featureTile(
                '${type == 0
                    ? '3'
                    : type == 1
                    ? '10'
                    : 'unlimited'.tr()}  ${'photos'.tr()}',
                primaryColor,
              ),
              _featureTile(

                  '${type == 0
                      ? '1'
                      : type == 1
                      ? '3'
                      : 'unlimited'.tr()}  ${'video'.tr()}', primaryColor),
              _featureTile('1 ${'audio_playlist'.tr()}', primaryColor),
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            height: 1.h,
            color: ColorConstants.colorECECEC,
          ),
          SizedBox(height: 23.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  price,
                ).regular(fontSize: 28.sp, color: ColorConstants.color000000),

                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 4.h,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24.r),
                    color: primaryColor.withValues(alpha: .25),
                  ),
                  child: Text(
                    'current_plan'.tr(),
                  ).medium(fontSize: 14.sp, color: primaryColor),
                ),
              ],
            ),
          ),
          SizedBox(height: 24.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: PrimaryButton(
              width: 1.sw,
              height: 44.h,
              color: primaryColor,
              title: 'buy'.tr(),
              onClick: () {},
            ),
          ),
          SizedBox(height: 24.h),
        ],
      ),
    );
  }

  _featureTile(String title, Color color) {
    return Padding(
      padding: EdgeInsets.only(bottom: 23.h),
      child: Row(
        children: [
          ImageView(path: AssetsResource.icTick, color: color),
          SizedBox(width: 8.w),
          Text(
            title,
          ).regular(fontSize: 16.sp, color: ColorConstants.color000000),
        ],
      ),
    );
  }
}
