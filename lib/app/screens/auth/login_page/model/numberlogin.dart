class PhoneNumberM {
  int? number;
  PhoneNumberM({required this.number});
  Map<String, dynamic> toJson() => {"user_number": number};
}

class LoginNumberResponesM {
  LoginNumberResponesM({
    this.status,
    this.id,
    this.message,
    this.error,
  });
  bool? error;
  bool? status;
  String? id;
  String? message;

  factory LoginNumberResponesM.fromJson(Map<String, dynamic> json) =>
      LoginNumberResponesM(
        status: json["status"],
        id: json["_id"],
        message: json["message"],
        error: json["error"] ?? true,
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "_id": id,
        "message": message,
      };
}

//================================= Number Login Respones ===================================

class LoginNumberOtpResponesM {
  LoginNumberOtpResponesM({
    this.status,
    this.token,
    this.message,
    this.error,
    this.refreshToken,
  });
  bool? error;
  bool? status;
  String? token;
  String? message;
  String? refreshToken;

  factory LoginNumberOtpResponesM.fromJson(Map<String, dynamic> json) =>
      LoginNumberOtpResponesM(
        status: json["status"],
        token: json["token"],
        message: json["message"],
        error: json["error"] ?? true,
        refreshToken: json["refreshToken"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "jwt": token,
        "message": message,
      };
}

//================================= Number Verify ===================================

class PhoneNumberVerifyM {
  PhoneNumberVerifyM({
    this.userOtp,
    this.userNumber,
    this.id,
    this.error,
    this.message,
  });

  String? message;
  bool? error;
  String? userOtp;
  int? userNumber;
  String? id;

  factory PhoneNumberVerifyM.fromJson(Map<String, dynamic> json) =>
      PhoneNumberVerifyM(
          userOtp: json["user_otp"],
          userNumber: json["user_number"],
          id: json["_id"],
          message: json["message"]);

  Map<String, dynamic> toJson() => {
        "user_otp": userOtp,
        "user_number": userNumber,
        "_id": id,
      };
}
