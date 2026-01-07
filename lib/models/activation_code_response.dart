class ActivationCodeResponse {
  bool? success;
  String? message;
  Data? data;

  ActivationCodeResponse({
    this.success,
    this.message,
    this.data,
  });

  factory ActivationCodeResponse.fromJson(Map<String, dynamic> json) => ActivationCodeResponse(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data?.toJson(),
  };
}

class Data {
  String? id;
  String? batchCode;
  String? activeCode;
  String? userId;
  String? status;

  Data({
    this.id,
    this.batchCode,
    this.activeCode,
    this.userId,
    this.status,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    batchCode: json["batch_code"],
    activeCode: json["active_code"],
    userId: json["user_id"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "batch_code": batchCode,
    "active_code": activeCode,
    "user_id": userId,
    "status": status,
  };
}