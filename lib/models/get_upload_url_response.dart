class GetUploadUrlResponse {
  bool? success;
  String? uploadUrl;
  String? fileKey;
  String? fileUrl;
  int? expiresIn;

  GetUploadUrlResponse({
    this.success,
    this.uploadUrl,
    this.fileKey,
    this.fileUrl,
    this.expiresIn,
  });

  factory GetUploadUrlResponse.fromJson(Map<String, dynamic> json) => GetUploadUrlResponse(
    success: json["success"],
    uploadUrl: json["upload_url"],
    fileKey: json["file_key"],
    fileUrl: json["file_url"],
    expiresIn: json["expires_in"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "upload_url": uploadUrl,
    "file_key": fileKey,
    "file_url": fileUrl,
    "expires_in": expiresIn,
  };
}
