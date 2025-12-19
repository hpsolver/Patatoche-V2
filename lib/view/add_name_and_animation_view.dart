import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:patatoche_v2/helpers/extensions.dart';
import 'package:patatoche_v2/widgets/image_view.dart';
import 'package:patatoche_v2/widgets/primary_button.dart';
import '../constants/assets_resource.dart';
import '../constants/color_constants.dart';
import '../helpers/common_textfield.dart';
import '../routes.dart';
import '../widgets/custom_appbar.dart';

class AddNameAndAnimationView extends StatefulWidget {
  final VoidCallback onContinueTap;
  const AddNameAndAnimationView({super.key,required this.onContinueTap});

  @override
  AddNameAndAnimationViewState createState() => AddNameAndAnimationViewState();
}

class AddNameAndAnimationViewState extends State<AddNameAndAnimationView> {
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
      backgroundColor: Colors.transparent,
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(left: 21.w, right: 21.w, bottom: 36.h,top: 16.h),
        child: PrimaryButton(
          title: 'continue'.tr(),
          onClick: widget.onContinueTap,
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 36.h),
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
              'start_your_meaningful_memory_page'.tr(),
            ).medium(fontSize: 16.sp, color: ColorConstants.color363636),
            SizedBox(height: 7.h),
            Text(
              'add_name_and_choose_an_animation'.tr(),
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
