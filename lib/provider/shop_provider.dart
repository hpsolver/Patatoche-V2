import 'package:flutter/cupertino.dart';
import 'package:patatoche_v2/provider/base_provider.dart';

class ShopProvider extends BaseProvider{

  TextEditingController searchController= TextEditingController();


  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

}