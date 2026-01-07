import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:patatoche_v2/constants/string_constants.dart';
import 'package:patatoche_v2/helpers/shared_pref.dart';
import 'package:patatoche_v2/provider/base_provider.dart';
import '../models/media_model.dart';

class CreateMemoryProvider extends BaseProvider {
  String batchId = '';
  String title = '';
  String receiverName = '';
  String animation = '';
  String? spotify;
  MediaModel? audio;

  List<MediaModel> videosList = [];
  List<MediaModel> imagesList = [];

  String get getMembership {
    return SharedPref.prefs?.getString(SharedPref.membership) ??
        StringConstants.free;
  }

  int? get videoLimit {
    return getMembership == StringConstants.free
        ? 1
        : getMembership == StringConstants.basic
        ? 3
        : null;
  }

  int? get imageLimit {
    return getMembership == StringConstants.free
        ? 3
        : getMembership == StringConstants.basic
        ? 10
        : null;
  }

  Future<void> pickImagesWithLimit(BuildContext context) async {
    final picker = ImagePicker();

    final pickedImages = await picker.pickMultiImage(
      limit: imageLimit,
      imageQuality: 60,
    );

    if (pickedImages.isEmpty) return;

    final remainingSlots =
    imageLimit == null ? pickedImages.length : imageLimit! - imagesList.length;

    if (remainingSlots <= 0) return;

    final imagesToAdd = pickedImages.take(remainingSlots).toList();
    final startIndex = imagesList.length;

    imagesList.addAll(
      imagesToAdd.asMap().entries.map((entry) {
        return MediaModel(
          localPath: entry.value.path,
          order: startIndex + entry.key,
        );
      }),
    );

    customNotify();
  }

  Future<void> pickVideosWithLimit(BuildContext context) async {
    final picker = ImagePicker();

    final pickedVideos = await picker.pickMultiVideo(limit: videoLimit);
    if (pickedVideos.isEmpty) return;

    final remainingSlots =
    videoLimit == null ? pickedVideos.length : videoLimit! - videosList.length;

    if (remainingSlots <= 0) return;

    final videosToAdd = pickedVideos.take(remainingSlots).toList();
    final startIndex = videosList.length;

    videosList.addAll(
      videosToAdd.asMap().entries.map(
            (entry) => MediaModel(
          localPath: entry.value.path,
          order: startIndex + entry.key,
        ),
      ),
    );

    customNotify();
  }


  void deleteImage(int index) {
    imagesList.removeAt(index);
    customNotify();
  }

  void deleteVideo(index) {
    videosList.removeAt(index);
    customNotify();
  }
}
