import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:nfc_manager/ndef_record.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:nfc_manager_ndef/nfc_manager_ndef.dart';
import 'package:patatoche_v2/helpers/common_function.dart';
import 'package:patatoche_v2/helpers/toast_helper.dart';
import 'package:patatoche_v2/provider/base_provider.dart';

class NfcScanViewProvider extends BaseProvider {
  Future<void> readNfcTag(BuildContext context) async {
    await NfcManager.instance.startSession(
      pollingOptions: const {NfcPollingOption.iso14443},
      onDiscovered: (NfcTag tag) async {
        try {
          final ndef = Ndef.from(tag);
          if (ndef == null) {
            _fail(context, 'this_tag_is_not'.tr());
            return;
          }

          final message = await ndef.read();
          if (message == null || message.records.isEmpty) {
            _fail(context, 'no_ndef_records'.tr());
            return;
          }

          final record = message.records.first;
          if (record.typeNameFormat != TypeNameFormat.wellKnown ||
              record.payload.isEmpty) {
            _fail(context, 'unsupported_record'.tr());
            return;
          }

          // Skip language byte for well-known text / URI records
          final payload = String.fromCharCodes(record.payload.skip(1));

          final lastId = CommonFunction.extractLastIdFromUrl(payload);
          if (lastId.isNotEmpty && context.mounted) {
            context.pop(lastId);
          }
        } catch (e, stack) {
          debugPrint('Error reading NDEF: $e\n$stack');
          if (context.mounted) {
            ToastHelper.showErrorMessage('nfc_read_error'.tr());
          }
        } finally {
          await NfcManager.instance.stopSession();
        }
      },
    );
  }

  void _fail(BuildContext context, String message) {
    if (!context.mounted) return;
    ToastHelper.showErrorMessage(message);
    context.pop();
  }

  Future<void> stopSession() async {
    await NfcManager.instance.stopSession();
  }
}
