class EmailLoginM {
  String? email;
  String? passwrd;
  EmailLoginM({required this.email, required this.passwrd});
  Map<String, dynamic> toJson() =>
      {"user_mail": email, "user_password": passwrd};
}




class EmailLoginRespones {
  EmailLoginRespones({
    this.id,
    this.status,
    this.message,
    this.token,
    this.error,
    this.refreshToken,
  });
  bool? error;
  bool? status;
  String? message;
  String? token;
  String? refreshToken;
    String? id;


  factory EmailLoginRespones.fromJson(Map<String, dynamic> json) =>
      EmailLoginRespones(
        status: json["status"],
        message: json["message"],
        token: json["token"],
        error: json["error"] ?? true,
        refreshToken: json["refreshToken"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "token": token,
      };
}
