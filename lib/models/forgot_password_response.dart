class ForgotPasswordResponse {
  bool? status;
  String? msg;

  ForgotPasswordResponse({this.status, this.msg});

  factory ForgotPasswordResponse.fromJson(Map<String, dynamic> json) =>
      ForgotPasswordResponse(status: json["status"], msg: json["msg"]);

  Map<String, dynamic> toJson() => {"status": status, "msg": msg};
}
