import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:patatoche_v2/constants/assets_resource.dart';
import 'package:patatoche_v2/constants/color_constants.dart';
import 'package:patatoche_v2/constants/string_constants.dart';
import 'package:patatoche_v2/helpers/extensions.dart';
import 'package:patatoche_v2/provider/introduction_provider.dart';
import 'package:patatoche_v2/routes.dart';
import 'package:patatoche_v2/view/base_view.dart';
import 'package:patatoche_v2/widgets/image_view.dart';
import 'package:patatoche_v2/widgets/primary_button.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class IntroductionView extends StatelessWidget {
  const IntroductionView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<IntroductionProvider>(
      builder: (context, provider, _) => Scaffold(
        body: Stack(
          children: [
            CarouselSlider.builder(
              options: CarouselOptions(
                height: 1.sh,
                initialPage: provider.selectedIndex,
                viewportFraction: 1,
                enlargeCenterPage: true,
                enlargeFactor: 0,
                autoPlay: true,
                scrollDirection: Axis.horizontal,
                onPageChanged: (index, reason) {
                  provider.onPageChanged(context, index);
                },
              ),
              itemCount: provider.onBoardingImagesList.length,
              itemBuilder: (BuildContext context, int index, int realIndex) {
                return ImageView(
                  path: provider.onBoardingImagesList[index],
                  fit: BoxFit.cover,
                  width: 1.sw,
                );
              },
            ),

            Positioned(
              bottom: 0,
              left: 1,
              right: 1,
              child: Stack(
                children: [
                  Container(
                    padding: EdgeInsets.only(
                      top: 38.h + 47.h, //padding + margin
                      left: 21.w,
                      right: 21.w,
                      bottom: 39.h,
                    ),
                    margin: EdgeInsets.only(top: 47.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.r),
                        topRight: Radius.circular(30.r),
                      ),
                      color: ColorConstants.colorFFFFFF,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: AnimatedSmoothIndicator(
                            activeIndex: provider.selectedIndex,
                            count: provider.onBoardingImagesList.length,
                            effect: ExpandingDotsEffect(
                              dotHeight: 8.h,
                              dotWidth: 14.w,
                              expansionFactor: 2.2,
                              activeDotColor: Theme.of(context).primaryColor,
                              dotColor: Theme.of(
                                context,
                              ).primaryColor.withValues(alpha: .31),
                            ),
                          ),
                        ),
                        SizedBox(height: 16.h),
                        Text('welcome_to_patatoche'.tr()).medium(
                          fontSize: 18.sp,
                          color: ColorConstants.color363636,
                        ),

                        SizedBox(height: 10.h),
                        RichText(
                          text: TextSpan(
                            text: 'scan_the_plush'.tr(),
                            style: TextStyle(
                              fontSize: 34.sp,
                              fontWeight: FontWeight.w500,
                              color: ColorConstants.color363636,
                              fontFamily: StringConstants.fontFamilyFredoka,
                            ),
                            children: [
                              TextSpan(
                                text: 'meet_the_magic'.tr(),
                                style: TextStyle(
                                  fontSize: 34.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Theme.of(context).primaryColor,
                                  fontFamily: StringConstants.fontFamilyFredoka,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 29.h),
                        PrimaryButton(
                          width: 1.sw,
                          height: 52.h,
                          title: 'get_started'.tr(),
                          onClick: () {
                            context.pushReplacement(AppPaths.getStarted);
                          },
                        ),
                      ],
                    ),
                  ),

                  Center(
                    child: ImageView(
                      path: AssetsResource.appIconRounded,
                      width: 134.w,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
