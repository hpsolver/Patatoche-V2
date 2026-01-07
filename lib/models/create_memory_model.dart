import 'package:patatoche_v2/models/media_model.dart';

class CreateMemoryModel {
  String? batchId;
  String? title;
  String? receiverName;
  String? animation;
  List<MediaModel>? images;
  List<MediaModel>? videos;
  String? spotify;
  MediaModel? audio;

  CreateMemoryModel({
    this.batchId,
    this.title,
    this.receiverName,
    this.animation,
    this.images,
    this.videos,
    this.spotify,
    this.audio,
  });
}
