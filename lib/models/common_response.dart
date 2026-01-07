class CommonResponse {
  bool? status;
  String? msg;

  CommonResponse({this.status, this.msg});

  factory CommonResponse.fromJson(Map<String, dynamic> json) => CommonResponse(
    status: json["status"] ?? json["success"],
    msg: json["msg"] ?? json["message"],
  );
}
