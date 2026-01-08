class MediaModel {
  String? localPath;
  String? serverUrl;
  String? fileKey;
  String? thumbnail;
  int? order;
  String? type;


  Future<String?>? thumbnailFuture;

  MediaModel({
    this.localPath,
    this.serverUrl,
    this.fileKey,
    this.thumbnail,
    this.order,
    this.type,
  });
}
