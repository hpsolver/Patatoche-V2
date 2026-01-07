import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:patatoche_v2/enums/view_state.dart';
import 'package:patatoche_v2/helpers/extensions.dart';
import 'package:patatoche_v2/models/tag_list_response.dart';
import 'package:patatoche_v2/provider/home_provider.dart';
import 'package:patatoche_v2/view/base_view.dart';
import 'package:patatoche_v2/view/nfc_scan_view.dart';
import 'package:patatoche_v2/widgets/image_view.dart';
import 'package:patatoche_v2/widgets/primary_button.dart';

import '../constants/assets_resource.dart';
import '../constants/color_constants.dart';
import '../routes.dart';
import '../widgets/custom_bottom_sheet.dart';
import 'activation_code_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<HomeProvider>(
      onModelReady: (provider) async {
        await provider.getBatches(context);
      },
      builder: (context, provider, _) => Scaffold(
        body: Stack(
          children: [
            Container(
              width: 1.sw,
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + 15.h,
              ),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AssetsResource.background),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text('Hello, David').medium(
                                  color: ColorConstants.color363636,
                                  fontSize: 18.sp,
                                ),
                                SizedBox(width: 4.w),
                                ImageView(
                                  path: AssetsResource.icThumb,
                                  width: 16.w,
                                  height: 16.w,
                                ),
                              ],
                            ),
                            SizedBox(height: 1.h),
                            Text('ready_to_create'.tr()).regular(
                              fontSize: 12.sp,
                              color: ColorConstants.color6E6E6E,
                            ),
                          ],
                        ),
                        Spacer(),
                        _premiumChip(
                          context,
                          title: 'comfort'.tr(),
                          borderColors: [
                            ColorConstants.colorB4D144,
                            ColorConstants.color9FB35D,
                          ],
                          colors: [
                            ColorConstants.colorECFBAE,
                            ColorConstants.colorA1BC3E,
                          ],
                        ),
                      ],
                    ),
                  ),

                  Expanded(
                    child: provider.state == ViewState.busy
                        ? Center(child: CircularProgressIndicator())
                        : provider.tagList.isEmpty
                        ? _emptyWidget(context, provider)
                        : _patatocheWidget(context, provider),
                  ),
                ],
              ),
            ),
            Visibility(
              visible: provider.isLoading,
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

  Widget _emptyWidget(BuildContext context, HomeProvider provider) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 46.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'oops_no_patatoche_in_sight'.tr(),
          ).medium(fontSize: 20.sp, color: ColorConstants.color363636),
          SizedBox(height: 19.h),
          Text(
            'add_you_first_patatoche'.tr(),
            textAlign: TextAlign.center,
          ).regular(fontSize: 16.sp, color: ColorConstants.color363636),
          SizedBox(height: 8.h),
          Text(
            'it_just_waiting'.tr(),
            textAlign: TextAlign.center,
          ).regular(fontSize: 16.sp, color: ColorConstants.color363636),
          SizedBox(height: 40.h),
          PrimaryButton(
            title: 'add_my_patatoche'.tr(),
            onClick: () async {
              await provider.readNfcTag(context);
            },
          ),
          SizedBox(height: 38.h),
          Text(
            'where_all_your_patatoche_live'.tr(),
            textAlign: TextAlign.center,
          ).regular(fontSize: 14.sp, color: ColorConstants.color363636),
        ],
      ),
    );
  }

  _premiumChip(
    BuildContext context, {
    required String title,
    required List<Color> borderColors,
    required List<Color> colors,
  }) {
    return GestureDetector(
      onTap: () {
        context.pushNamed(AppPaths.membershipPlanView);
      },
      child: Container(
        padding: EdgeInsets.all(1.3.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(21.r),
          gradient: LinearGradient(colors: borderColors),
        ),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(21.r),
            gradient: LinearGradient(colors: colors),
          ),
          child: Row(
            children: [
              ImageView(path: AssetsResource.icDiamond),
              SizedBox(width: 4.w),
              Text(
                title,
              ).regular(fontSize: 14.sp, color: ColorConstants.color000000),
            ],
          ),
        ),
      ),
    );
  }

  Widget _patatocheWidget(BuildContext context, HomeProvider provider) {
    return Column(
      children: [
        SizedBox(height: 8.h),
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.only(left: 22.w, right: 22.w, top: 8.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('your_patatoche'.tr()).medium(
                      fontSize: 18.sp,
                      color: ColorConstants.color363636,
                    ),

                    PrimaryButton(
                      height: 34.h,
                      title: 'add_new'.tr(),
                      fontSize: 14.sp,
                      onClick: () async {
                        await provider.readNfcTag(context);
                      },
                    ),
                  ],
                ),
                SizedBox(height: 14.h),
                ListView.separated(
                  shrinkWrap: true,
                  padding: EdgeInsets.only(bottom: 24.h),
                  itemCount: provider.tagList.length,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return _itemBuilder(context, provider.tagList[index]);
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(height: 12.h);
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  _itemBuilder(BuildContext context, Tag tag) {
    return GestureDetector(
      onTap: () {
        context.pushNamed(AppPaths.editMemory);
      },
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 14),
              blurRadius: 39.r,
              spreadRadius: 0,
              color: ColorConstants.color000000.withValues(alpha: .4),
            ),
          ],
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(18.r),
              child: ImageView(
                height: 237.h,
                fit: BoxFit.cover,
                path: tag.image ?? AssetsResource.placeholder2,
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 6.h),

                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(18.r),
                    bottomRight: Radius.circular(18.r),
                  ),
                  color: ColorConstants.color1E0E01.withValues(alpha: .09),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 3),
                            blurRadius: 5.r,
                            spreadRadius: 0,
                            color: ColorConstants.color000000.withValues(
                              alpha: .25,
                            ),
                          ),
                        ],
                      ),
                      child: Text("${tag.title}").regular(
                        fontSize: 16.sp,
                        color: ColorConstants.colorFFFFFF,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
