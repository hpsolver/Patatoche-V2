class UploadUrlRequest {
  UploadCount? image;
  UploadCount? video;
  UploadCount? audio;

  UploadUrlRequest({
    this.image,
    this.video,
    this.audio,
  });

  factory UploadUrlRequest.fromJson(Map<String, dynamic> json) => UploadUrlRequest(
    image: json["image"] == null ? null : UploadCount.fromJson(json["image"]),
    video: json["video"] == null ? null : UploadCount.fromJson(json["video"]),
    audio: json["audio"] == null ? null : UploadCount.fromJson(json["audio"]),
  );

  Map<String, dynamic> toJson() => {
    "image": image?.toJson(),
    "video": video?.toJson(),
    "audio": audio?.toJson(),
  };
}

class UploadCount {
  int? count;
  String? fileType;

  UploadCount({
    this.count,
    this.fileType,
  });

  factory UploadCount.fromJson(Map<String, dynamic> json) => UploadCount(
    count: json["count"],
    fileType: json["file_type"],
  );

  Map<String, dynamic> toJson() => {
    "count": count,
    "file_type": fileType,
  };
}
