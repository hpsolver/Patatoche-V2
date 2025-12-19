import 'package:flutter/src/widgets/framework.dart';
import 'package:patatoche_v2/constants/assets_resource.dart';
import 'package:patatoche_v2/provider/base_provider.dart';

class IntroductionProvider extends BaseProvider {
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  set selectedIndex(int value) {
    _selectedIndex = value;
    customNotify();
  }

  List<String> onBoardingImagesList = [
    AssetsResource.onBoardingImg1,
    AssetsResource.onBoardingImg2,
    AssetsResource.onBoardingImg3,
  ];

  void onPageChanged(BuildContext context, int index) {
    selectedIndex = index;
  }
}
