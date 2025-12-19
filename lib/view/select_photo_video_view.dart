import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:patatoche_v2/helpers/extensions.dart';
import 'package:patatoche_v2/provider/select_photo_video_provider.dart';
import 'package:patatoche_v2/view/base_view.dart';
import 'package:patatoche_v2/view/delete_view.dart';
import 'package:patatoche_v2/widgets/image_view.dart';
import 'package:patatoche_v2/widgets/primary_button.dart';
import 'package:reorderable_grid/reorderable_grid.dart';
import '../constants/assets_resource.dart';
import '../constants/color_constants.dart';
import '../widgets/custom_bottom_sheet.dart';

class SelectPhotoVideoView extends StatelessWidget {
  final VoidCallback onContinueTap;

  const SelectPhotoVideoView({super.key, required this.onContinueTap});

  @override
  Widget build(BuildContext context) {
    return BaseView<SelectPhotoVideoProvider>(
      builder: (context, provider, _) => Scaffold(
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
            onClick: onContinueTap,
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
                      color: ColorConstants.color000000.withValues(
                        alpha: .05,
                      ),
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
                        Text('0/10').medium(
                          fontSize: 16.sp,
                          color: ColorConstants.color363636,
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    Text('move_frame_to_an_image'.tr()).regular(
                      fontSize: 16.sp,
                      color: ColorConstants.color363636,
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
                        if (index == 9) {
                          return GestureDetector(
                            key: ValueKey(index),
                            onTap: () {},
                            child: DottedBorder(
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
                                    child: ImageView(
                                      path: AssetsResource.icPlus,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }
                        return _photoItemBuilder(context, index);
                      },
                      itemCount: 10,
                      onReorder: (int oldIndex, int newIndex) {},
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children: [
                        Text('videos'.tr()).medium(
                          fontSize: 16.sp,
                          color: ColorConstants.color363636,
                        ),
                        Text('0/03').medium(
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
                        if (index == 3) {
                          return GestureDetector(
                            key: ValueKey(index),
                            onTap: () {},
                            child: DottedBorder(
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
                                    child: ImageView(
                                      path: AssetsResource.icPlus,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }
                        return Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          key: ValueKey(index),
                        );
                      },
                      itemCount: 4,
                      onReorder: (int oldIndex, int newIndex) {},
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

  Widget _photoItemBuilder(BuildContext context, int index) {
    return Stack(
      key: ValueKey(index),
      children: [
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withValues(alpha: .3),
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(
              color: Theme.of(context).primaryColor,
              width: 2.w,
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
              Container(
                padding: EdgeInsets.all(3.w),
                width: 15.w,
                height: 15.w,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  shape: BoxShape.circle,
                ),
                child: ImageView(path: AssetsResource.icStar),
              ),

              GestureDetector(
                onTap: () {
                  CustomBottomSheet.show(
                    context: context,
                    isDismissible: true,
                    enableDrag: true,
                    child: DeleteView(
                      title: 'delete_photo'.tr(),
                      subTitle: 'are_you_sure_you'.tr(),
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
}
