import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:patatoche_v2/helpers/extensions.dart';
import 'package:patatoche_v2/models/language_model.dart';
import 'package:patatoche_v2/provider/language_provider.dart';
import 'package:patatoche_v2/widgets/image_view.dart';

import '../constants/assets_resource.dart';
import '../constants/color_constants.dart';
import '../helpers/shared_pref.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/primary_button.dart';
import 'base_view.dart';

class LanguageView extends StatelessWidget {
  const LanguageView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<LanguageProvider>(
        onModelReady: (provider) {
          String langCode =
              SharedPref.prefs?.getString(SharedPref.langCode) ?? 'en';
          provider.selectedLang = provider.langList.firstWhere(
                (element) => element.langCode == langCode,
          );
        },
        builder: (context, provider, _) =>
            Scaffold(
              bottomNavigationBar: Padding(
                padding: EdgeInsets.only(
                  left: 21.w,
                  right: 21.w,
                  bottom: context.bottomSafePadding,),
                  child: PrimaryButton(title: 'update'.tr(), onClick: () {}),
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
                          'language'.tr(),
                        ).regular(
                            fontSize: 20.sp, color: ColorConstants.color000000),
                        onBack: () {
                          context.pop();
                        },
                      ),
                      SizedBox(height: 8.h),
                      ListView.separated(
                        shrinkWrap: true,
                        padding: EdgeInsets.symmetric(horizontal: 24.w),
                        itemBuilder: (context, index) {
                          return _itemBuilder(
                            context,
                            index,
                            provider.langList[index],
                            provider,
                          );
                        },
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 16.h),
                        itemCount: provider.langList.length,
                      ),
                    ],
                  ),
                ),
              ),
            );
    }

  _itemBuilder(BuildContext context,
      int index,
      LanguageModel lang,
      LanguageProvider provider,) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: ColorConstants.colorBBBBBB, width: 1.w),
      ),
      child: Row(
        children: [
          ImageView(
            path: provider.selectedLang?.langName == lang.langName
                ? AssetsResource.icRadioFilled
                : AssetsResource.icRadio,
          ),
          SizedBox(width: 10.w),
          Text(
            lang.langName ?? '',
          ).regular(fontSize: 16.sp, color: ColorConstants.color9E9E9E),
        ],
      ),
    );
  }
}
