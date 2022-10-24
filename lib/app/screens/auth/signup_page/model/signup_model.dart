class EmailSignupM {
  String? email;
  String? passwrd;
  EmailSignupM({required this.email, required this.passwrd});
  Map<String, dynamic> toJson() => {
        "user_mail": email,
        "user_password": passwrd,
      };
}

//========================Email Responce Model======================

class EmailSignupResponceM {
  String? message;
  String? id;
  bool? error;
  bool? status;
  EmailSignupResponceM({this.message, this.status, this.id, this.error});
  factory EmailSignupResponceM.fromJson(Map<String, dynamic> json) =>
      EmailSignupResponceM(
        message: json["message"],
        status: json["status"],
        id: json["id"],
        error: json["error"] ?? true,
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "id": id,
        "message": message,
      };
}

//======================Email OTP Model========================

class EmailOtpM {
  String? otp;
  String? id;
  EmailOtpM({required this.id, required this.otp});
  Map<String, dynamic> toJson() => {"user_otp": otp, "_id": id};
}

class EmailOtpResponceM {
  bool? status;
  bool? error;
  String? message;
  String? token;
  String? refreshTocken;
  String? id;

  EmailOtpResponceM({
    this.message,
    this.refreshTocken,
    this.status,
    this.error,
    this.token,
    this.id,
  });
  factory EmailOtpResponceM.fromJson(Map<String, dynamic> json) =>
      EmailOtpResponceM(
        message: json["message"],
        refreshTocken: json["refreshToken"],
        status: json["status"],
        token: json["token"],
        id: json["_id"],
        error: json["error"] ?? true,
      );
  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "token": token,
      };
}
