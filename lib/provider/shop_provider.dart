import 'dart:io';

import 'package:flutter/cupertino.dart';

import '../enums/view_state.dart';
import '../helpers/toast_helper.dart';
import '../models/product_model.dart';
import '../services/fetch_data_exception.dart';
import 'base_provider.dart';

class ShopProvider extends BaseProvider {

  // Constructor
  ShopProvider() {
    searchController.addListener(() {
      customNotify();
    });
  }

  final TextEditingController searchController = TextEditingController();
  Map<String, List<Product>> products = {};

  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  set selectedIndex(int value) {
    _selectedIndex = value;
    searchController.clear();
    customNotify();
  }

  /// Filtered products for selected category
  List<Product> get filteredProducts {
    if (products.isEmpty) return [];

    final entries = products.entries.toList();

    if (_selectedIndex >= entries.length) return [];

    final selectedProducts = entries[_selectedIndex].value;
    final query = searchController.text.trim().toLowerCase();

    if (query.isEmpty) {
      return selectedProducts;
    }

    return selectedProducts.where((product) {
      return (product.name ?? '').toLowerCase().contains(query);
    }).toList();
  }

  Future<void> getProducts(BuildContext context) async {
    try {
      setState(ViewState.busy);

      var model = await api.getProducts();
      setState(ViewState.idle);
      if (model?.status == true) {
        products = groupByCategory(model?.products ?? []);
      }
    } on FetchDataException catch (e) {
      setState(ViewState.idle);
      ToastHelper.showErrorMessage(e.toString());
    } on SocketException catch (e) {
      setState(ViewState.idle);
      ToastHelper.showErrorMessage(e.message.toString());
    }
  }

  Map<String, List<Product>> groupByCategory(List<Product> products) {
    final Map<String, List<Product>> categoryMap = {};

    for (final product in products) {
      for (final category in product.categories ?? []) {
        categoryMap.putIfAbsent(category, () => []);
        categoryMap[category]!.add(product);
      }
    }

    return categoryMap;
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
