class GetUploadUrlResponse {
  bool? success;
  Data? data;

  GetUploadUrlResponse({this.success, this.data});

  factory GetUploadUrlResponse.fromJson(Map<String, dynamic> json) =>
      GetUploadUrlResponse(
        success: json["success"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );
}

class Data {
  List<Media>? image;
  List<Media>? video;
  List<Media>? audio;

  Data({this.image, this.video, this.audio});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    image: json["image"] == null
        ? []
        : List<Media>.from(json["image"]!.map((x) => Media.fromJson(x))),
    video: json["video"] == null
        ? []
        : List<Media>.from(json["video"]!.map((x) => Media.fromJson(x))),
    audio: json["audio"] == null
        ? []
        : List<Media>.from(json["audio"]!.map((x) => Media.fromJson(x))),
  );
}

class Media {
  String? fileKey;
  String? uploadUrl;
  String? fileUrl;
  int? expiresIn;

  Media({this.fileKey, this.uploadUrl, this.fileUrl, this.expiresIn});

  factory Media.fromJson(Map<String, dynamic> json) => Media(
    fileKey: json["file_key"],
    uploadUrl: json["upload_url"],
    fileUrl: json["file_url"],
    expiresIn: json["expires_in"],
  );
}
