import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:patatoche_v2/models/create_memory_model.dart';
import 'package:patatoche_v2/models/media_model.dart';
import 'package:patatoche_v2/provider/base_provider.dart';
import '../enums/view_state.dart';
import '../helpers/shared_pref.dart';
import '../helpers/toast_helper.dart';
import '../routes.dart';
import '../services/fetch_data_exception.dart';

class PreviewProvider extends BaseProvider {
  String? headerImage;

  CreateMemoryModel? createMemoryModel;
  List<MediaModel> mediaList = [];

  /// Progress tracking
  int totalFiles = 0;
  int uploadedFiles = 0;
  double uploadProgress = 0.0;

  void _updateProgress() {
    if (totalFiles == 0) return;
    uploadProgress = uploadedFiles / totalFiles;
    customNotify();
  }

  /// Wrapper to track upload completion
  Future<void> _uploadWithProgress(File file, dynamic uploadUrl) async {
    await api.uploadFile(file, uploadUrl);
    uploadedFiles++;
    _updateProgress();
  }

  Future<void> saveMedia(BuildContext context) async {
    final memoryModel = createMemoryModel;
    if (memoryModel == null) return;

    setState(ViewState.busy);

    /// Reset progress
    uploadedFiles = 0;
    uploadProgress = 0;

    totalFiles =
        (memoryModel.images?.length ?? 0) +
        (memoryModel.videos?.length ?? 0) +
        (memoryModel.audio != null ? 1 : 0);

    customNotify();

    final request = <String, dynamic>{};

    if (memoryModel.images?.isNotEmpty ?? false) {
      request['image'] = {
        'count': memoryModel.images!.length,
        'file_type': 'image',
      };
    }

    if (memoryModel.videos?.isNotEmpty ?? false) {
      request['video'] = {
        'count': memoryModel.videos!.length,
        'file_type': 'video',
      };
    }

    if (memoryModel.audio != null) {
      request['audio'] = {'count': 1, 'file_type': 'audio'};
    }

    if (request.isEmpty) {
      setState(ViewState.idle);
      return;
    }

    try {
      /// 1️⃣ Get upload URLs
      final uploadUrlRes = await api.getUploadUrl(request: request);
      if (!(uploadUrlRes?.success ?? false)) {
        setState(ViewState.idle);
        return;
      }

      final tasks = <Future>[];

      /// 2️⃣ Upload images
      for (int i = 0; i < (uploadUrlRes?.data?.image?.length ?? 0); i++) {
        tasks.add(
          _uploadWithProgress(
            File(memoryModel.images![i].localPath!),
            uploadUrlRes!.data!.image![i],
          ),
        );
      }

      /// 3️⃣ Upload videos
      for (int i = 0; i < (uploadUrlRes?.data?.video?.length ?? 0); i++) {
        tasks.add(
          _uploadWithProgress(
            File(memoryModel.videos![i].localPath!),
            uploadUrlRes!.data!.video![i],
          ),
        );
      }

      /// 4️⃣ Upload audio
      if (uploadUrlRes?.data?.audio?.isNotEmpty ?? false) {
        tasks.add(
          _uploadWithProgress(
            File(memoryModel.audio!.localPath!),
            uploadUrlRes!.data!.audio!.first,
          ),
        );
      }

      /// Parallel upload
      await Future.wait(tasks);

      /// 5️⃣ Final payload
      final finalRequest = {
        "user_id": SharedPref.prefs?.getInt(SharedPref.userId),
        "batch_id": memoryModel.batchId,
        "title": memoryModel.title,
        "receive_name": memoryModel.receiverName,
        "animation": memoryModel.animation,
        "spotify": memoryModel.spotify ?? "",
        "image": buildMediaPayload(uploadUrlRes?.data?.image),
        "video": buildMediaPayload(uploadUrlRes?.data?.video),
        "audio": buildMediaPayload(uploadUrlRes?.data?.audio),
      };

      /// 6️⃣ Save media API
      final saveRes = await api.saveMedia(request: finalRequest);

      setState(ViewState.idle);

      if (saveRes?.status ?? false) {
        context.pushNamed(AppPaths.successView);
      } else {
        ToastHelper.showErrorMessage(saveRes?.msg ?? '');
      }
    } on FetchDataException catch (e) {
      setState(ViewState.idle);
      ToastHelper.showErrorMessage(e.toString());
    } on SocketException {
      setState(ViewState.idle);
      ToastHelper.showErrorMessage('no_internet_connection'.tr());
    } catch (e) {
      setState(ViewState.idle);
      ToastHelper.showErrorMessage(e.toString());
    }
  }

  /// Build payload for API
  List<Map<String, dynamic>> buildMediaPayload(List<dynamic>? uploadedFiles) {
    if (uploadedFiles == null) return [];

    return List.generate(uploadedFiles.length, (i) {
      return {
        "file_url": uploadedFiles[i].fileUrl,
        "file_key": uploadedFiles[i].fileKey,
        "order": i + 1,
      };
    });
  }

  void setData(CreateMemoryModel model) {
    createMemoryModel = model;
    loadMedia();
  }

  void loadMedia() {
    if (createMemoryModel == null) return;
    mediaList = [];

    headerImage = createMemoryModel?.images?.first.localPath;

    if (createMemoryModel?.images?.isNotEmpty ?? false) {
      mediaList.addAll(createMemoryModel!.images!);
    }
    if (createMemoryModel?.videos?.isNotEmpty ?? false) {
      mediaList.addAll(createMemoryModel!.videos!);
    }

    customNotify();
  }
}
