import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:patatoche_v2/helpers/extensions.dart';
import 'package:patatoche_v2/provider/base_provider.dart';

import '../helpers/toast_helper.dart';
import '../view/activation_code_view.dart';
import '../view/nfc_scan_view.dart';
import '../widgets/custom_bottom_sheet.dart';

class HomeProvider extends BaseProvider {
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
            ).then((value) {
              CustomBottomSheet.show(
                context: context,
                isDismissible: true,
                enableDrag: true,
                child: ActivationCodeView(),
              );
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
}
