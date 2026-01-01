class CommonResponse {
  bool? status;
  String? msg;

  CommonResponse({this.status, this.msg});

  factory CommonResponse.fromJson(Map<String, dynamic> json) =>
      CommonResponse(status: json["status"], msg: json["msg"]);

  Map<String, dynamic> toJson() => {"status": status, "msg": msg};
}
