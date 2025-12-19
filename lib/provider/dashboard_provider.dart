import 'package:flutter/cupertino.dart';
import 'package:patatoche_v2/provider/base_provider.dart';

import '../view/home_view.dart';
import '../view/settings_view.dart';
import '../view/shop_view.dart';

class DashboardProvider extends BaseProvider {
  List<Widget> pages = [HomeView(), ShopView(), SettingsView()];

  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  set selectedIndex(int value) {
    _selectedIndex = value;
    customNotify();
  }
}
