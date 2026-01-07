class VerifyNfcTagResponse {
  bool? success;
  String? message;
  Data? data;

  VerifyNfcTagResponse({this.success, this.message, this.data});

  factory VerifyNfcTagResponse.fromJson(Map<String, dynamic> json) =>
      VerifyNfcTagResponse(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );
}

class Data {
  String? id;
  String? batchCode;
  dynamic activeCode;
  dynamic codeId;
  dynamic userId;
  String? status;

  Data({
    this.id,
    this.batchCode,
    this.activeCode,
    this.codeId,
    this.userId,
    this.status,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    batchCode: json["batch_code"],
    activeCode: json["active_code"],
    codeId: json["code_id"],
    userId: json["user_id"],
    status: json["status"],
  );
}
