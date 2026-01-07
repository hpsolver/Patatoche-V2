class MediaModel {
  String? localPath;
  String? serverUrl;
  String? fileKey;
  String? thumbnail;
  int? order;


  Future<String?>? thumbnailFuture;

  MediaModel({
    this.localPath,
    this.serverUrl,
    this.fileKey,
    this.thumbnail,
    this.order,
  });
}
