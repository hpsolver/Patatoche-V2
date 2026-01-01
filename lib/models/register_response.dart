class RegisterResponse {
  bool? status;
  String? msg;
  int? userId;

  RegisterResponse({
    this.status,
    this.msg,
    this.userId,
  });

  factory RegisterResponse.fromJson(Map<String, dynamic> json) => RegisterResponse(
    status: json["status"],
    msg: json["msg"],
    userId: json["user_id"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "msg": msg,
    "user_id": userId,
  };
}
