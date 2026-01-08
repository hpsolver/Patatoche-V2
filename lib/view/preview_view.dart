import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import 'package:patatoche_v2/constants/color_constants.dart';
import 'package:patatoche_v2/constants/string_constants.dart';
import 'package:patatoche_v2/helpers/extensions.dart';
import 'package:patatoche_v2/models/create_memory_model.dart';
import 'package:patatoche_v2/provider/create_memory_provider.dart';
import 'package:patatoche_v2/provider/preview_provider.dart';
import 'package:patatoche_v2/routes.dart';
import 'package:patatoche_v2/view/base_view.dart';
import 'package:patatoche_v2/widgets/image_view.dart';
import 'package:readmore/readmore.dart';
import '../constants/assets_resource.dart';
import '../helpers/common_function.dart';
import '../widgets/audio_wave_player.dart';
import '../widgets/primary_button.dart';

class PreviewView extends StatelessWidget {
  final CreateMemoryModel model;

  const PreviewView({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return BaseView<PreviewProvider>(
      onModelReady: (provider) {
        provider.setData(model);
      },
      builder: (context, provider, _) => Scaffold(
        extendBody: true,
        bottomNavigationBar: _submitButton(context, provider),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AssetsResource.background2),
              fit: BoxFit.cover,
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(18.r),
                        bottomRight: Radius.circular(18.r),
                      ),
                      child: ImageView(
                        height: 237.h,
                        width: 1.sw,
                        path: provider.headerImage??'',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      top: MediaQuery.of(context).padding.top,
                      left: 12.w,
                      right: 18.w,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              context.pop();
                            },
                            child: Container(
                              padding: EdgeInsets.all(6.w),
                              color: Colors.transparent,
                              child: ImageView(
                                path: AssetsResource.icBack,
                                color: ColorConstants.colorFFFFFF,
                              ),
                            ),
                          ),

                          SizedBox(),

                          /*GestureDetector(
                            onTap: () {
                              context.pushNamed(AppPaths.editMemory);
                            },
                            child: Text('edit'.tr()).medium(
                              fontSize: 16.sp,
                              color: ColorConstants.colorFFFFFF,
                            ),
                          ),*/
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 18.h, left: 20.w, right: 20.w),
                  child: Column(
                    children: [
                      ReadMoreText(
                        '“${model.title?.trim()}”',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20.sp,
                          color: ColorConstants.color363636,
                          fontWeight: FontWeight.w300,
                          fontFamily: StringConstants.fontFamilyFredoka,
                        ),
                        trimMode: TrimMode.Line,
                        trimLines: 2,
                        colorClickableText: Theme.of(context).primaryColor,
                        trimCollapsedText: 'Show more',
                        trimExpandedText: ' Show less',
                        lessStyle: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          fontFamily: StringConstants.fontFamilyFredoka,
                        ),
                        moreStyle: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          fontFamily: StringConstants.fontFamilyFredoka,
                        ),
                      ),
                      SizedBox(height: 17.h),

                      model.spotify == null || model.spotify!.isEmpty
                          ? SizedBox()
                          : GestureDetector(
                              onTap: () {
                                CommonFunction.openUrl("${model.spotify}");
                              },
                              child: Container(
                                margin: EdgeInsets.only(bottom: 17.h),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 16.w,
                                  vertical: 16.h,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.r),
                                  border: Border.all(
                                    color: ColorConstants.colorBBBBBB,
                                    width: 1.w,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    ImageView(path: AssetsResource.icSpotify),
                                    SizedBox(width: 12.w),
                                    Text('spotify_playlist'.tr()).regular(
                                      fontSize: 16.sp,
                                      color: ColorConstants.color363636,
                                    ),
                                  ],
                                ),
                              ),
                            ),

                      model.audio?.localPath == null
                          ? SizedBox()
                          : AudioWavePlayer(filePath: model.audio!.localPath!),
                    ],
                  ),
                ),

                MasonryGridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  mainAxisSpacing: 8.h,
                  crossAxisSpacing: 8.h,
                  itemCount: provider.mediaList.length,
                  padding: EdgeInsets.only(
                    left: 20.w,
                    right: 20.w,
                    top: 20.h,
                    bottom: 100.h,
                  ),
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12.r),
                          child: Container(
                            width: 1.sw,
                            color: Colors.blue,
                            height: (index % 2 + 1) * 148.h,
                            child: ImageView(
                              path: provider.mediaList[index].localPath??'',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),

                        Positioned(
                          bottom: 8.h,
                          left: 7.w,

                          child: Container(
                            decoration: BoxDecoration(
                              color: ColorConstants.colorBDBDBD.withValues(
                                alpha: .3,
                              ),
                              borderRadius: BorderRadius.circular(90.r),
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: 6.w,
                              vertical: 3.h,
                            ),

                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ImageView(path: AssetsResource.icPlay),

                                SizedBox(width: 4.w),

                                Text('5:50').regular(
                                  fontSize: 14.sp,
                                  color: ColorConstants.colorFFFFFF,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget? _submitButton(BuildContext context, PreviewProvider provider) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            ColorConstants.colorFFFFFF.withValues(alpha: .27),
            ColorConstants.colorFFFFFF,
          ],
        ),
      ),
      padding: EdgeInsets.only(
        left: 21.w,
        right: 21.w,
        bottom: 36.h,
        top: 16.h,
      ),
      child: PrimaryButton(
        title: 'submit'.tr(),
        onClick: () async {
          await provider.saveMedia(context);
        },
      ),
    );
  }
}
