class UpdateProfileResponse {
  bool? success;
  String? message;
  Data? data;

  UpdateProfileResponse({
    this.success,
    this.message,
    this.data,
  });

  factory UpdateProfileResponse.fromJson(Map<String, dynamic> json) => UpdateProfileResponse(
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
  int? userId;
  String? firstName;
  String? lastName;
  String? membership;

  Data({
    this.userId,
    this.firstName,
    this.lastName,
    this.membership,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    userId: json["user_id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    membership: json["membership"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "first_name": firstName,
    "last_name": lastName,
    "membership": membership,
  };
}
