import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:patatoche_v2/helpers/extensions.dart';
import 'package:reorderable_grid/reorderable_grid.dart';

import '../constants/assets_resource.dart';
import '../constants/color_constants.dart';
import '../helpers/common_textfield.dart';
import '../widgets/audio_wave_player.dart';
import '../widgets/custom_bottom_sheet.dart';
import '../widgets/image_view.dart';
import '../widgets/common_dialog_view.dart';

class EditMemoryPage extends StatefulWidget {
  const EditMemoryPage({super.key});

  @override
  EditMemoryPageState createState() => EditMemoryPageState();
}

class EditMemoryPageState extends State<EditMemoryPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _receiverNameController = TextEditingController();
  final TextEditingController _animationController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _receiverNameController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: 24.h),
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
                    path: AssetsResource.placeholder2,
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

                      GestureDetector(
                        onTap: () {},
                        child: Text('save'.tr()).medium(
                          fontSize: 16.sp,
                          color: ColorConstants.colorFFFFFF,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(left: 22.w, right: 22.w, top: 14.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'title'.tr(),
                  ).regular(fontSize: 16.sp, color: ColorConstants.color363636),
                  SizedBox(height: 7.h),
                  CommonTextField(
                    controller: _titleController,
                    hintText: 'enter_title'.tr(),
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(height: 18.h),
                  Text(
                    'receiver_name'.tr(),
                  ).regular(fontSize: 16.sp, color: ColorConstants.color363636),
                  SizedBox(height: 7.h),
                  CommonTextField(
                    controller: _receiverNameController,
                    hintText: 'enter_receiver_name'.tr(),
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(height: 18.h),
                  Text(
                    'animation'.tr(),
                  ).regular(fontSize: 16.sp, color: ColorConstants.color363636),
                  SizedBox(height: 7.h),
                  CommonTextField(
                    isRead: true,
                    controller: _animationController,
                    hintText: 'select_animation'.tr(),
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(height: 8.h),
                  Text('note_this_will_appear'.tr()).regular(
                    fontSize: 12.sp,
                    color: Theme.of(context).primaryColor,
                  ),
                  SizedBox(height: 16.h),

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
                                  child: ImageView(path: AssetsResource.icPlus),
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
                                  child: ImageView(path: AssetsResource.icPlus),
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

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: [
                      Text('audio'.tr()).medium(
                        fontSize: 16.sp,
                        color: ColorConstants.color363636,
                      ),
                      Text('0/01').medium(
                        fontSize: 16.sp,
                        color: ColorConstants.color363636,
                      ),
                    ],
                  ),

                  SizedBox(height: 20.h),

                  AudioWavePlayer(
                    assetPath: 'assets/audios/sample_audio.mp3',
                    onDeleteTap: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _photoItemBuilder(BuildContext context, int index) {
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
                    child: CommonDialogView(
                      title: 'delete_photo'.tr(),
                      subTitle: 'are_you_sure_you'.tr(),
                      icon: AssetsResource.icDelete2,
                      okayButtonText: 'delete'.tr(),
                      okayButtonClick: () {},
                      okayTextColor: ColorConstants.colorD1270B, okayButtonColor: ColorConstants.colorFFECEC, okayButtonBorderColor: ColorConstants.colorFFE3DE,
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
