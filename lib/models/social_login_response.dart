class SocialLoginResponse {
  bool? success;
  int? userId;
  String? email;
  String? firstName;
  String? lastName;
  String? membership;
  String? token;

  SocialLoginResponse({
    this.success,
    this.userId,
    this.email,
    this.firstName,
    this.lastName,
    this.membership,
    this.token,
  });

  factory SocialLoginResponse.fromJson(Map<String, dynamic> json) => SocialLoginResponse(
    success: json["success"],
    userId: json["user_id"],
    email: json["email"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    membership: json["membership"],
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "user_id": userId,
    "email": email,
    "first_name": firstName,
    "last_name": lastName,
    "membership": membership,
    "token": token,
  };
}