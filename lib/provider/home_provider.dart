import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:patatoche_v2/enums/view_state.dart';
import 'package:patatoche_v2/helpers/extensions.dart';
import 'package:patatoche_v2/provider/base_provider.dart';
import 'package:patatoche_v2/routes.dart';
import '../helpers/shared_pref.dart';
import '../helpers/toast_helper.dart';
import '../models/tag_list_response.dart';
import '../services/fetch_data_exception.dart';
import '../view/activation_code_view.dart';
import '../view/nfc_scan_view.dart';
import '../widgets/custom_bottom_sheet.dart';

class HomeProvider extends BaseProvider {
  List<Tag> tagList = [];

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    customNotify();
  }

  Future<void> readNfcTag(BuildContext context) async {
    try {
      context.hideKeyboard();

      try {
        await NfcManager.instance.stopSession();
      } catch (_) {
        debugPrint('no session active');
      }

      await NfcManager.instance.checkAvailability().then((
        NfcAvailability nfcAvailability,
      ) {
        if (nfcAvailability == NfcAvailability.unsupported) {
          ToastHelper.showErrorMessage('nfc_not_supported'.tr());
        } else if (nfcAvailability == NfcAvailability.disabled) {
          ToastHelper.showErrorMessage('make_sure_nfc_is_enabled'.tr());
        } else if (nfcAvailability == NfcAvailability.enabled) {
          if (Platform.isAndroid && context.mounted) {
            CustomBottomSheet.show(
              context: context,
              isDismissible: true,
              enableDrag: true,
              child: NfcScanView(),
            ).then((value) async {
              if (value != null && value is String) {
                await checkBatchCode(context, value);
              }
            });
          } else {
            return NfcManager.instance.startSession(
              pollingOptions: {NfcPollingOption.iso14443},

              onDiscovered: (tag) async {
                // Do something with an NfcTag instance...
                if (kDebugMode) {
                  print(tag);
                }

                // Stop the session when no longer needed.
                await NfcManager.instance.stopSession();
              },
            );
          }
        }
      });
    } catch (e) {
      debugPrint("Error $e");
    }
  }

  Future<void> getBatches(BuildContext context) async {
    try {
      setState(ViewState.busy);
      int userId = SharedPref.prefs?.getInt(SharedPref.userId) ?? 0;
      var model = await api.getBatches(userId);
      setState(ViewState.idle);

      if (model?.success ?? false) {
        tagList = model?.data ?? [];
      }
    } on FetchDataException catch (e) {
      // Handle API-side validation error
      setState(ViewState.idle);
      ToastHelper.showErrorMessage(e.toString());
    } on SocketException catch (e) {
      // Handle socket exception (e.g., no internet connection)
      setState(ViewState.idle);
      ToastHelper.showErrorMessage(e.message.toString());
    }
  }

  Future<void> checkBatchCode(BuildContext context, String batchCode) async {
    try {
      isLoading = true;
      var model = await api.checkBatchCode(batchCode);
      isLoading = false;
      if (model?.success ?? false) {
        if (model?.data?.activeCode == null) {
          CustomBottomSheet.show(
            context: context,
            isDismissible: true,
            enableDrag: true,
            child: ActivationCodeView(batchCode: batchCode),
          ).then((value) {
            if (value != null && value is String) {
              context.pushNamed(
                AppPaths.createMemory,
                extra: {'batch_id': value},
              );
            }
          });
        } else if (model?.data?.activeCode != null &&
            model?.data?.status == "0") {
          context.pushNamed(
            AppPaths.createMemory,
            extra: {'batch_id': model?.data?.codeId},
          );
        }
      } else {
        ToastHelper.showErrorMessage(model?.message ?? "");
      }
    } on FetchDataException catch (e) {
      // Handle API-side validation error
      isLoading = false;
      ToastHelper.showErrorMessage(e.toString());
    } on SocketException catch (e) {
      // Handle socket exception (e.g., no internet connection)
      isLoading = false;
      ToastHelper.showErrorMessage(e.message.toString());
    }
  }
}
