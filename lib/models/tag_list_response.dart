class TagListResponse {
  bool? success;
  List<Tag>? data;

  TagListResponse({
    this.success,
    this.data,
  });

  factory TagListResponse.fromJson(Map<String, dynamic> json) => TagListResponse(
    success: json["success"],
    data: json["data"] == null ? [] : List<Tag>.from(json["data"]!.map((x) => Tag.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Tag {
  String? id;
  String? batchCode;
  String? title;
  String? receiveName;
  String? animation;
  String? spotify;
  String? image;

  Tag({
    this.id,
    this.batchCode,
    this.title,
    this.receiveName,
    this.animation,
    this.spotify,
    this.image,
  });

  factory Tag.fromJson(Map<String, dynamic> json) => Tag(
    id: json["id"],
    batchCode: json["batch_code"],
    title: json["title"],
    receiveName: json["receive_name"],
    animation: json["animation"],
    spotify: json["spotify"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "batch_code": batchCode,
    "title": title,
    "receive_name": receiveName,
    "animation": animation,
    "spotify": spotify,
    "image": image,
  };
}