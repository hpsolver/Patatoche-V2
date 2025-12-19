import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:patatoche_v2/app_config.dart';
import 'package:patatoche_v2/helpers/extensions.dart';
import 'package:patatoche_v2/provider/contact_us_provider.dart';
import 'package:patatoche_v2/widgets/image_view.dart';

import '../constants/assets_resource.dart';
import '../constants/color_constants.dart';
import '../widgets/custom_appbar.dart';
import 'base_view.dart';

class ContactUsView extends StatelessWidget {
  const ContactUsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<ContactUsProvider>(
      builder: (context, provider, _) => Scaffold(
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
                  'contact_us'.tr(),
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
                    _itemBuilder(
                      context,
                      AssetsResource.icCall,
                      'call'.tr(),
                      AppConfig.contactNumber,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      child: Container(
                        height: 1.h,
                        color: ColorConstants.color6C7278.withValues(
                          alpha: .10,
                        ),
                      ),
                    ),
                    _itemBuilder(
                      context,
                      AssetsResource.icEmail,
                      'email'.tr(),
                      AppConfig.email,
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

  _itemBuilder(
    BuildContext context,
    String iconPath,
    String title,
    String subTitle,
  ) {
    return Container(
      color: Colors.transparent,
      child: Row(
        children: [
          Container(
            width: 40.w,
            height: 40.w,
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).primaryColor,
            ),
            child: ImageView(path: iconPath),
          ),
          SizedBox(width: 15.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
              ).medium(fontSize: 16.sp, color: ColorConstants.color1A1C1E),
              SizedBox(height: 5.h),
              Text(subTitle),
            ],
          ),
        ],
      ),
    );
  }
}
