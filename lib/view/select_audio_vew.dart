import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:patatoche_v2/helpers/extensions.dart';
import 'package:patatoche_v2/models/create_memory_model.dart';
import 'package:patatoche_v2/provider/create_memory_provider.dart';
import 'package:patatoche_v2/routes.dart';
import 'package:patatoche_v2/view/add_spotify_playlist_view.dart';
import 'package:patatoche_v2/widgets/image_view.dart';
import 'package:patatoche_v2/widgets/primary_button.dart';
import '../constants/assets_resource.dart';
import '../constants/color_constants.dart';
import '../widgets/common_dialog_view.dart';
import '../widgets/custom_bottom_sheet.dart';

class SelectAudioView extends StatelessWidget {
  final CreateMemoryProvider provider;

  const SelectAudioView({super.key, required this.provider});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,

      body: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: 16.h, top: 36.h),
        child: Column(
          children: [
            Center(
              child: Container(
                width: 68.w,
                height: 68.w,
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  border: Border.all(color: ColorConstants.colorFFECCE),
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      ColorConstants.colorFFFFFF,
                      ColorConstants.colorFFF4E3,
                    ],
                  ),
                ),
                child: ImageView(path: AssetsResource.icMusic),
              ),
            ),
            SizedBox(height: 19.h),
            Text(
              'playlist_audio'.tr(),
            ).medium(fontSize: 16.sp, color: ColorConstants.color363636),
            SizedBox(height: 18.h),

            Container(
              width: 1.sw,
              margin: EdgeInsets.symmetric(horizontal: 21.w),
              padding: EdgeInsets.only(
                left: 12.w,
                right: 12.w,
                top: 18.h,
                bottom: 15.h,
              ),
              decoration: BoxDecoration(
                color: ColorConstants.colorFFFFFF,
                borderRadius: BorderRadius.circular(14.r),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 5),
                    blurRadius: 11.r,
                    spreadRadius: 0,
                    color: ColorConstants.color000000.withValues(alpha: .05),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'one_soundtrack_for_the'.tr(),
                  ).regular(fontSize: 16.sp, color: ColorConstants.color363636),

                  SizedBox(height: 20.h),
                  GestureDetector(
                    onTap: () {
                      CustomBottomSheet.show(
                        context: context,
                        isDismissible: true,
                        enableDrag: true,
                        child: AddSpotifyPlaylistView(
                          spotifyUrl: provider.spotify ?? '',
                        ),
                      ).then((value) {
                        if (value != null && value is String) {
                          provider.setSpotifyUrl(value);
                        }
                      });
                    },
                    child: Container(
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
                          Text('add_spotify_playlist'.tr()).regular(
                            fontSize: 16.sp,
                            color: ColorConstants.color363636,
                          ),
                          Spacer(),

                          provider.spotify != null &&
                                  provider.spotify!.isNotEmpty
                              ? Row(
                                  children: [
                                    Text('added'.tr()).medium(
                                      fontSize: 16.sp,
                                      color: Theme.of(context).primaryColor,
                                    ),

                                    SizedBox(width: 8.w),

                                    GestureDetector(
                                      onTap: () {
                                        showDeletePopUp(context, provider, 1);
                                      },
                                      child: ImageView(
                                        path: AssetsResource.icDelete3,
                                      ),
                                    ),
                                  ],
                                )
                              : SizedBox(),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 12.h),
                  GestureDetector(
                    onTap: () async {
                      await provider.pickAudioFile();
                    },
                    child: Container(
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
                          Container(
                            width: 31.w,
                            height: 31.w,
                            padding: EdgeInsets.symmetric(
                              horizontal: 10.w,
                              vertical: 8.h,
                            ),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Theme.of(context).primaryColor,
                            ),
                            child: ImageView(path: AssetsResource.icAudio),
                          ),
                          SizedBox(width: 12.w),
                          Text('upload_audio_file'.tr()).regular(
                            fontSize: 16.sp,
                            color: ColorConstants.color363636,
                          ),
                          Spacer(),

                          provider.audio != null
                              ? Row(
                                  children: [
                                    Text('added'.tr()).medium(
                                      fontSize: 16.sp,
                                      color: Theme.of(context).primaryColor,
                                    ),

                                    SizedBox(width: 8.w),

                                    GestureDetector(
                                      onTap: () {
                                        showDeletePopUp(context, provider, 2);
                                      },
                                      child: ImageView(
                                        path: AssetsResource.icDelete3,
                                      ),
                                    ),
                                  ],
                                )
                              : SizedBox(),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 20.h),
                  PrimaryButton(
                    width: 1.sw,
                    title: 'complete_setup'.tr(),
                    onClick: () {
                      navigateToPreview(context);
                    },
                  ),
                  SizedBox(height: 10.h),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        navigateToPreview(context);
                      },
                      child: Text('skip_audio'.tr()).regular(
                        fontSize: 14.sp,
                        color: Theme.of(context).primaryColor,
                      ),
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

  void navigateToPreview(BuildContext context) {
    var model = CreateMemoryModel(
      batchId: provider.batchId,
      title: provider.title,
      receiverName: provider.receiverName,
      animation: provider.animation,
      images: provider.imagesList,
      videos: provider.videosList,
      spotify: provider.spotify,
      audio: provider.audio,
    );
    context.pushNamed(AppPaths.preview, extra: model);
  }

  void showDeletePopUp(
    BuildContext context,
    CreateMemoryProvider provider,
    int type,
  ) {
    String title = '';
    String subTitle = '';

    if (type == 1) {
      title = 'delete_spotify_playlist'.tr();
      subTitle = 'are_you_sure_you_want_to_delete_this_spotify_playlist'.tr();
    } else {
      title = 'delete_audio'.tr();
      subTitle = 'are_you_sure_you_want_to_delete_this_audio'.tr();
    }

    CustomBottomSheet.show(
      context: context,
      isDismissible: true,
      enableDrag: true,
      child: CommonDialogView(
        title: title,
        subTitle: subTitle,
        icon: AssetsResource.icDelete2,
        okayButtonText: 'delete'.tr(),
        okayButtonClick: () {
          context.pop();
          provider.deleteAudio(type);
        },
        okayTextColor: ColorConstants.colorD1270B,
        okayButtonColor: ColorConstants.colorFFECEC,
        okayButtonBorderColor: ColorConstants.colorFFE3DE,
      ),
    );
  }
}
