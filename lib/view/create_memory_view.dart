import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:patatoche_v2/helpers/extensions.dart';
import 'package:patatoche_v2/view/add_name_and_animation_view.dart';
import 'package:patatoche_v2/view/select_audio_vew.dart';
import 'package:patatoche_v2/view/select_photo_video_view.dart';
import '../constants/assets_resource.dart';
import '../constants/color_constants.dart';
import '../widgets/custom_appbar.dart';

class CreateMemoryView extends StatefulWidget {
  const CreateMemoryView({super.key});

  @override
  CreateMemoryViewState createState() => CreateMemoryViewState();
}

class CreateMemoryViewState extends State<CreateMemoryView> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
              onBack: onBackTap,
              centerTitle: true,
              titleWidget: Text(
                'memory_page'.tr(),
              ).medium(fontSize: 20.sp, color: ColorConstants.color363636),
            ),
            Expanded(
              child: PageView(
                physics: NeverScrollableScrollPhysics(),
                controller: _pageController,
                children: [
                  AddNameAndAnimationView(
                    onContinueTap: () {
                      _pageController.nextPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeIn,
                      );
                    },
                  ),
                  SelectPhotoVideoView(
                    onContinueTap: () {
                      _pageController.nextPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeIn,
                      );
                    },
                  ),
                  SelectAudioView(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onBackTap() {
    if (_pageController.page == 0) {
      context.pop();
    } else {
      _pageController.previousPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    }
  }
}
