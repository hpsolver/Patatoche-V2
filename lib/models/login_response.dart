class LoginResponse {
  bool? status;
  String? msg;
  Data? data;

  LoginResponse({
    this.status,
    this.msg,
    this.data,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
    status: json["status"],
    msg: json["msg"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "msg": msg,
    "data": data?.toJson(),
  };
}

class Data {
  int? userId;
  String? username;
  String? email;
  String? firstname;

  Data({
    this.userId,
    this.username,
    this.email,
    this.firstname,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    userId: json["user_id"],
    username: json["username"],
    email: json["email"],
    firstname: json["firstname"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "username": username,
    "email": email,
    "firstname": firstname,
  };
}