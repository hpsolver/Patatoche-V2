import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:patatoche_v2/constants/assets_resource.dart';
import 'package:patatoche_v2/constants/color_constants.dart';
import 'package:patatoche_v2/helpers/extensions.dart';
import 'package:patatoche_v2/models/option_model.dart';
import 'package:patatoche_v2/provider/settings_provider.dart';
import 'package:patatoche_v2/routes.dart';
import 'package:patatoche_v2/view/base_view.dart';
import 'package:patatoche_v2/widgets/image_view.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<SettingsProvider>(
      builder: (context, provider, _) => Scaffold(
        body: Container(
          width: 1.sw,
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top + 53.h,
          ),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AssetsResource.background),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              Container(
                width: 78.w,
                height: 78.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: ColorConstants.colorD4A055,
                ),
                child: Center(
                  child: Text(
                    "Akshay Thakur".initials,
                  ).medium(fontSize: 35.sp, color: ColorConstants.colorFFFFFF),
                ),
              ),
              SizedBox(height: 10.h),
              Text(
                'Akshay Thakur',
              ).medium(fontSize: 18.sp, color: ColorConstants.color363636),
              SizedBox(height: 2.h),
              Text(
                'adamsmith@email.com',
              ).regular(fontSize: 16.sp, color: ColorConstants.color363636),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 22.w, vertical: 21.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.r),
                  gradient: LinearGradient(
                    colors: [
                      ColorConstants.colorFFFFFF.withValues(alpha: .43),
                      ColorConstants.colorFFFFFF,
                    ],
                  ),
                ),

                child: ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: EdgeInsets.only(top: 5.h, bottom: 2.h),
                  itemCount: provider.optionList.length,
                  itemBuilder: (context, index) =>
                      _itemBuilder(context, provider.optionList[index]),
                  separatorBuilder: (BuildContext context, int index) {
                    return Container(
                      height: 1.h,
                      color: ColorConstants.colorE7E7E7.withValues(alpha: .5),
                    );
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 13.h),
                margin: EdgeInsets.symmetric(horizontal: 22.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(11.r),
                  color: ColorConstants.colorFFE6E0,
                  border: Border.all(color: ColorConstants.colorFABFB0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ImageView(path: AssetsResource.icLogout),
                    SizedBox(width: 10.w),
                    Text('logout'.tr()).medium(
                      fontSize: 16.sp,
                      color: ColorConstants.colorE74A4A,
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

  _itemBuilder(BuildContext context, OptionModel option) {
    return GestureDetector(
      onTap: () {
        switch (option.title) {
          case 'account_settings':
            context.pushNamed(AppPaths.accountSettings);
            break;
          case 'change_password':
            context.pushNamed(AppPaths.changePassword);
            break;
          case 'contact_us':
            context.pushNamed(AppPaths.contactUs);
            break;
          case 'terms_and_conditions':
            break;
          case 'language':
            context.pushNamed(AppPaths.language);
            break;
          case 'about_app':
            break;
          default:
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 17.h),
        color: Colors.transparent,
        child: Row(
          children: [
            ImageView(path: option.icon),
            SizedBox(width: 16.w),
            Text(
              option.title.tr(),
            ).regular(fontSize: 16.sp, color: ColorConstants.color02031A),
          ],
        ),
      ),
    );
  }
}
