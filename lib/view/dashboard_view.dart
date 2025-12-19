import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:patatoche_v2/constants/assets_resource.dart';
import 'package:patatoche_v2/constants/color_constants.dart';
import 'package:patatoche_v2/provider/dashboard_provider.dart';
import 'package:patatoche_v2/view/base_view.dart';
import 'package:patatoche_v2/widgets/image_view.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<DashboardProvider>(
      builder: (context, provider, _) => Scaffold(
        body: provider.pages[provider.selectedIndex],
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: ColorConstants.colorFFFFFF.withValues(alpha: .6),
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 20),
                blurRadius: 107,
                spreadRadius: -25,
                color: ColorConstants.color000000.withValues(alpha: .32),
              ),
            ],
          ),
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 35.w, vertical: 16.h),
              child: GNav(
                rippleColor: Colors.grey[300]!,
                hoverColor: Colors.grey[100]!,
                gap: 8.w,
                iconSize: 24.w,
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
                duration: Duration(milliseconds: 400),
                tabBackgroundColor: ColorConstants.colorFAF3E9,
                color: ColorConstants.color292D32,
                textStyle: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).primaryColor,
                ),
                tabs: [
                  GButton(
                    text: 'home'.tr(),
                    icon: Icons.home,
                    leading: ImageView(
                      path: provider.selectedIndex == 0
                          ? AssetsResource.icHomeFilled
                          : AssetsResource.icHome,
                      // your custom icon
                      height: 24.w,
                      width: 24.w,
                    ),
                  ),
                  GButton(
                    text: 'shop'.tr(),
                    icon: Icons.shop,
                    leading: ImageView(
                      path: provider.selectedIndex == 1
                          ? AssetsResource.icShopFilled
                          : AssetsResource.icShop,
                      // your custom icon
                      height: 24.w,
                      width: 24.w,
                    ),
                  ),
                  GButton(
                    text: 'settings'.tr(),
                    icon: Icons.settings,
                    leading: ImageView(
                      path: provider.selectedIndex == 2
                          ? AssetsResource.icSettingFilled
                          : AssetsResource.icSetting,
                      // your custom icon
                      height: 24.w,
                      width: 24.w,
                    ),
                  ),
                ],
                selectedIndex: provider.selectedIndex,
                onTabChange: (index) {
                  provider.selectedIndex = index;
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
