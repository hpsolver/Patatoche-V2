import 'dart:async';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:patatoche_v2/constants/string_constants.dart';
import 'package:patatoche_v2/enums/view_state.dart';
import 'package:patatoche_v2/helpers/shared_pref.dart';
import 'package:patatoche_v2/provider/base_provider.dart';
import '../constants/color_constants.dart';
import '../helpers/toast_helper.dart';
import '../services/fetch_data_exception.dart';

class MembershipPlanProvider extends BaseProvider {
  final InAppPurchase _iap = InAppPurchase.instance;
  late StreamSubscription<List<PurchaseDetails>> _subscription;
  final Set<String> _productIds = {'basic', 'premium'};
  List<ProductDetails> products = [];

  String _selectedPlan = StringConstants.free;

  String get selectedPlan => _selectedPlan;

  set selectedPlan(String value) {
    _selectedPlan = value;
    customNotify();
  }

  Future<void> loadProducts(BuildContext context) async {
    final available = await _iap.isAvailable();
    if (!available) return;
    listenToPurchases(context);

    setState(ViewState.busy);
    final response = await _iap.queryProductDetails(_productIds);

    if (response.error != null) {
      setState(ViewState.idle);
      debugPrint(response.error?.message ?? '');
      return;
    }

    products.add(
      ProductDetails(
        id: 'free',
        title: 'Starter',
        description: '',
        price: '0',
        rawPrice: 0.0,
        currencyCode: response.productDetails[0].currencyCode,
        currencySymbol: response.productDetails[0].currencySymbol,
      ),
    );
    products.addAll(response.productDetails);
    setState(ViewState.idle);
  }

  Future<void> buyProduct(BuildContext context, ProductDetails product) async {
    final PurchaseParam purchaseParam = PurchaseParam(productDetails: product);

    await _iap.buyNonConsumable(purchaseParam: purchaseParam);
  }

  void listenToPurchases(BuildContext context) {
    _subscription = _iap.purchaseStream.listen(
      (purchases) {
        for (final purchase in purchases) {
          handlePurchase(purchase, context);
        }
      },
      onDone: () => _subscription.cancel(),
      onError: (error) {
        print(error);
      },
    );
  }

  Future<void> handlePurchase(
    PurchaseDetails purchase,
    BuildContext context,
  ) async {
    if (purchase.status == PurchaseStatus.purchased ||
        purchase.status == PurchaseStatus.restored) {
      // Unlock feature based on product ID
      if (purchase.productID == 'basic') {
        SharedPref.prefs?.setString(
          SharedPref.membership,
          StringConstants.basic,
        );
      } else if (purchase.productID == 'premium') {
        SharedPref.prefs?.setString(
          SharedPref.membership,
          StringConstants.premium,
        );
      }

      // Update membership in backend
      await updateMembershipApi(context, purchase.productID);

      if (purchase.pendingCompletePurchase) {
        await _iap.completePurchase(purchase);
      }
    }

    if (purchase.status == PurchaseStatus.error) {
      print(purchase.error);
    }
  }

  Future<void> restore() async {
    await _iap.restorePurchases();
  }

  String getSubtitle(String id) {
    switch (id) {
      case 'free':
        return 'perfect_to_get_started'.tr();
      case 'basic':
        return 'for_special_moments'.tr();
      case 'premium':
        return 'unlimited_memories'.tr();
      default:
        return '';
    }
  }

  Color getPlanColor(BuildContext context, String id) {
    switch (id) {
      case 'free':
        return Theme.of(context).primaryColor;
      case 'basic':
        return ColorConstants.color8C9764;
      case 'premium':
        return ColorConstants.colorDE917D;
      default:
        return Theme.of(context).primaryColor;
    }
  }

  List<Color> getHeaderColors(BuildContext context, String id) {
    switch (id) {
      case 'free':
        return [
          ColorConstants.colorFFF0DB,
          ColorConstants.colorFFFFFF.withValues(alpha: .8),
        ];
      case 'basic':
        return [
          ColorConstants.colorDBE3BD,
          ColorConstants.colorFFFFFF.withValues(alpha: .8),
        ];
      case 'premium':
        return [
          ColorConstants.colorFFEBE5,
          ColorConstants.colorFFFFFF.withValues(alpha: .8),
        ];
      default:
        return [
          ColorConstants.colorFFF0DB,
          ColorConstants.colorFFFFFF.withValues(alpha: .8),
        ];
    }
  }

  Future<void> updateMembershipApi(
    BuildContext context,
    String membership,
  ) async {
    try {
      int userId = SharedPref.prefs?.getInt(SharedPref.userId) ?? 0;

      Map<String, dynamic> request = {
        "user_id": userId,
        "membership": membership,
      };

      var model = await api.updateProfile(request: request);

      if (model?.success != true) {
        ToastHelper.showErrorMessage(model?.message ?? '');
      }
    } on FetchDataException catch (e) {
      // Handle API-side validation error
      ToastHelper.showErrorMessage(e.toString());
    } on SocketException catch (e) {
      // Handle socket exception (e.g., no internet connection)
      ToastHelper.showErrorMessage(e.message.toString());
    }
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
