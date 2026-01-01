import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:in_app_purchase_platform_interface/src/types/product_details.dart';
import 'package:patatoche_v2/constants/color_constants.dart';
import 'package:patatoche_v2/constants/string_constants.dart';
import 'package:patatoche_v2/enums/view_state.dart';
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
      onModelReady: (provider) async {
        await provider.loadProducts();
      },
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
                child: provider.state == ViewState.busy
                    ? Center(child: CircularProgressIndicator())
                    : ListView.separated(
                        padding: EdgeInsets.only(
                          left: 20.w,
                          right: 20.w,
                          bottom: 32.h,
                        ),
                        shrinkWrap: true,

                        itemBuilder: (BuildContext context, int index) {
                          return _planItemBuilder(
                            context,
                            provider.products[index],
                            provider,
                            showBorder:
                                provider.selectedPlan ==
                                provider.products[index].id,
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return SizedBox(height: 20.h);
                        },
                        itemCount: provider.products.length,
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _planItemBuilder(
    BuildContext context,
    ProductDetails product,
    MembershipPlanProvider provider, {
    bool showBorder = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: ColorConstants.colorFFFFFF,
        border: showBorder
            ? Border.all(color: provider.getPlanColor(context, product.id))
            : null,
        borderRadius: BorderRadius.circular(22.r),
        boxShadow: [
          BoxShadow(
            color: provider
                .getPlanColor(context, product.id)
                .withValues(alpha: .15),
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
                colors: provider.getHeaderColors(context, product.id),
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
                    color: provider.getPlanColor(context, product.id),
                  ),
                  child: ImageView(path: AssetsResource.icDiamond, width: 19.w),
                ),
                SizedBox(width: 8.w),
                Text(
                  product.title,
                ).medium(fontSize: 18.sp, color: ColorConstants.color000000),
                Text(
                  ' - ',
                ).regular(fontSize: 14.sp, color: ColorConstants.color000000),

                Text(provider.getSubtitle(product.id)).regular(
                  fontSize: 14.sp,
                  color: provider.getPlanColor(context, product.id),
                ),
              ],
            ),
          ),
          ListView(
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.only(left: 15.w, right: 15.w),
            shrinkWrap: true,
            children: [
              _featureTile(
                '${product.id == StringConstants.free
                    ? '3'
                    : product.id == StringConstants.basic
                    ? '10'
                    : 'unlimited'.tr()}  ${'photos'.tr()}',
                provider.getPlanColor(context, product.id),
              ),
              _featureTile(
                '${product.id == StringConstants.free
                    ? '1'
                    : product.id == StringConstants.basic
                    ? '3'
                    : 'unlimited'.tr()}  ${'video'.tr()}',
                provider.getPlanColor(context, product.id),
              ),
              _featureTile(
                '1 ${'audio_playlist'.tr()}',
                provider.getPlanColor(context, product.id),
              ),
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
                  product.id == StringConstants.free
                      ? 'free'.tr()
                      : product.price,
                ).regular(fontSize: 28.sp, color: ColorConstants.color000000),

                Visibility(
                  visible: showBorder,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 4.h,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24.r),
                      color: provider
                          .getPlanColor(context, product.id)
                          .withValues(alpha: .25),
                    ),
                    child: Text('current_plan'.tr()).medium(
                      fontSize: 14.sp,
                      color: provider.getPlanColor(context, product.id),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Visibility(
            visible: product.id != StringConstants.free,
            child: Column(
              children: [
                SizedBox(height: 24.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: PrimaryButton(
                    width: 1.sw,
                    height: 44.h,
                    color: provider.getPlanColor(context, product.id),
                    title: 'buy'.tr(),
                    onClick: () async {
                      await provider.buyProduct(context, product);
                    },
                  ),
                ),
              ],
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
