import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:patatoche_v2/constants/string_constants.dart';
import 'package:patatoche_v2/helpers/common_function.dart';
import 'package:patatoche_v2/helpers/extensions.dart';
import 'package:patatoche_v2/helpers/toast_helper.dart';
import 'package:patatoche_v2/models/media_model.dart';
import 'package:patatoche_v2/provider/create_memory_provider.dart';
import 'package:patatoche_v2/widgets/common_dialog_view.dart';
import 'package:patatoche_v2/widgets/image_view.dart';
import 'package:patatoche_v2/widgets/primary_button.dart';
import 'package:reorderable_grid/reorderable_grid.dart';
import '../constants/assets_resource.dart';
import '../constants/color_constants.dart';
import '../widgets/custom_bottom_sheet.dart';

class SelectPhotoVideoView extends StatelessWidget {
  final VoidCallback onContinueTap;
  final CreateMemoryProvider provider;

  const SelectPhotoVideoView({
    super.key,
    required this.onContinueTap,
    required this.provider,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
          left: 21.w,
          right: 21.w,
          bottom: 36.h,
          top: 16.h,
        ),
        child: PrimaryButton(
          title: 'continue_to_audio'.tr(),
          onClick: () {
            if (provider.imagesList.isEmpty) {
              ToastHelper.showErrorMessage(
                'please_select_at_least_once_image'.tr(),
              );
            } else {
              onContinueTap();
            }
          },
        ),
      ),
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
                child: ImageView(path: AssetsResource.icAdd),
              ),
            ),
            SizedBox(height: 19.h),
            Text(
              'create_your_beautiful_visual_story'.tr(),
            ).medium(fontSize: 16.sp, color: ColorConstants.color363636),
            SizedBox(height: 7.h),
            Text(
              'add_your_best_memories'.tr(),
            ).regular(fontSize: 15.sp, color: ColorConstants.color363636),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: [
                      Text('main_photo_requirement'.tr()).medium(
                        fontSize: 16.sp,
                        color: ColorConstants.color363636,
                      ),
                      Text(
                        provider.getMembership == StringConstants.premium
                            ? '${provider.imagesList.length}'
                            : '${provider.imagesList.length}/${provider.getMembership == StringConstants.free ? '3' : '10'}',
                      ).medium(
                        fontSize: 16.sp,
                        color: ColorConstants.color363636,
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    'move_frame_to_an_image'.tr(),
                  ).regular(fontSize: 16.sp, color: ColorConstants.color363636),

                  ReorderableGridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: EdgeInsets.symmetric(vertical: 20.h),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 10.w,
                      mainAxisSpacing: 10.w,
                      childAspectRatio: 1, // width / height
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      if (index == provider.imagesList.length) {
                        return GestureDetector(
                          key: ValueKey(index),
                          onTap: () async {
                            await provider.pickImagesWithLimit(context);
                          },
                          child: _addMediaItem(context, index),
                        );
                      }
                      return _photoItemBuilder(
                        context,
                        index,
                        provider,
                        provider.imagesList[index],
                      );
                    },
                    itemCount:
                        provider.imagesList.length +
                        ((provider.imageLimit == null ||
                                provider.imageLimit !=
                                    provider.imagesList.length)
                            ? 1
                            : 0),
                    onReorder: (int oldIndex, int newIndex) {},
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: [
                      Text('videos'.tr()).medium(
                        fontSize: 16.sp,
                        color: ColorConstants.color363636,
                      ),
                      Text(
                        provider.getMembership == StringConstants.premium
                            ? '${provider.videosList.length}'
                            : '${provider.videosList.length}/${provider.getMembership == StringConstants.free ? '1' : '3'}',
                      ).medium(
                        fontSize: 16.sp,
                        color: ColorConstants.color363636,
                      ),
                    ],
                  ),

                  ReorderableGridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: EdgeInsets.symmetric(vertical: 20.h),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 10.w,
                      mainAxisSpacing: 10.w,
                      childAspectRatio: 1, // width / height
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      if (index == provider.videosList.length) {
                        return GestureDetector(
                          key: ValueKey(index),
                          onTap: () async {
                            await provider.pickVideosWithLimit(context);
                          },
                          child: _addMediaItem(context, index),
                        );
                      }
                      return _videoItemBuilder(
                        context,
                        index,
                        provider,
                        provider.videosList[index],
                      );
                    },
                    itemCount:
                        provider.videosList.length +
                        ((provider.videoLimit == null ||
                                provider.videoLimit !=
                                    provider.videosList.length)
                            ? 1
                            : 0),
                    onReorder: (int oldIndex, int newIndex) {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _photoItemBuilder(
    BuildContext context,
    int index,
    CreateMemoryProvider provider,
    MediaModel media,
  ) {
    return Stack(
      key: ValueKey(index),
      children: [
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withValues(alpha: .3),
            borderRadius: BorderRadius.circular(8.r),
            border: index == 0
                ? Border.all(color: Theme.of(context).primaryColor, width: 2.w)
                : null,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(6.r),
            child: ImageView(
              width: 1.sw,
              path: media.localPath ?? media.serverUrl!,
              fit: BoxFit.cover,
            ),
          ),
        ),

        Positioned(
          top: 5.w,
          right: 5.w,
          left: 5.w,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              index == 0
                  ? Container(
                      padding: EdgeInsets.all(3.w),
                      width: 15.w,
                      height: 15.w,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        shape: BoxShape.circle,
                      ),
                      child: ImageView(path: AssetsResource.icStar),
                    )
                  : SizedBox(),

              GestureDetector(
                onTap: () {
                  CustomBottomSheet.show(
                    context: context,
                    isDismissible: true,
                    enableDrag: true,
                    child: CommonDialogView(
                      title: 'delete_photo'.tr(),
                      subTitle: 'are_you_sure_you'.tr(),
                      icon: AssetsResource.icDelete2,
                      okayButtonText: 'delete'.tr(),
                      okayButtonClick: () {
                        context.pop();
                        provider.deleteImage(index);
                      },
                      okayTextColor: ColorConstants.colorD1270B,
                      okayButtonColor: ColorConstants.colorFFECEC,
                      okayButtonBorderColor: ColorConstants.colorFFE3DE,
                    ),
                  );
                },
                child: ImageView(path: AssetsResource.icDelete),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget? _addMediaItem(BuildContext context, int index) {
    return DottedBorder(
      options: RoundedRectDottedBorderOptions(
        radius: Radius.circular(8.r),
        strokeWidth: 1.w,
        color: Theme.of(context).primaryColor,
        dashPattern: [2, 2],
      ),
      child: Container(
        decoration: BoxDecoration(
          color: ColorConstants.colorFDF5E9,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Center(
          child: Container(
            width: 21.w,
            height: 21.w,
            padding: EdgeInsets.all(5.w),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).primaryColor,
            ),
            child: ImageView(path: AssetsResource.icPlus),
          ),
        ),
      ),
    );
  }

  Widget _videoItemBuilder(
    BuildContext context,
    int index,
    CreateMemoryProvider provider,
    MediaModel media,
  ) {
    // Create Future ONCE
    media.thumbnailFuture ??= media.thumbnail != null
        ? Future.value(media.thumbnail) // wrap String? in Future
        : CommonFunction.generateHighQualityThumbnail(
            media.localPath ?? media.serverUrl!,
          );

    return FutureBuilder<String?>(
      key: ValueKey(media.fileKey ?? index),
      future: media.thumbnailFuture,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final thumbnailPath = snapshot.data!;
        media.thumbnail ??= thumbnailPath;

        return Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: ImageView(
                width: 1.sw,
                fit: BoxFit.cover,
                path: thumbnailPath,
              ),
            ),

            Positioned(
              top: 5.w,
              right: 5.w,
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => _showDeleteDialog(context, index),
                child: ImageView(path: AssetsResource.icDelete),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showDeleteDialog(BuildContext context, int index) {
    CustomBottomSheet.show(
      context: context,
      isDismissible: true,
      enableDrag: true,
      child: CommonDialogView(
        title: 'delete_photo'.tr(),
        subTitle: 'are_you_sure_you'.tr(),
        icon: AssetsResource.icDelete2,
        okayButtonText: 'delete'.tr(),
        okayButtonClick: () {
          provider.deleteVideo(index);
          context.pop();
        },
        okayTextColor: ColorConstants.colorD1270B,
        okayButtonColor: ColorConstants.colorFFECEC,
        okayButtonBorderColor: ColorConstants.colorFFE3DE,
      ),
    );
  }
}
