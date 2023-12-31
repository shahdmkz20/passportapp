import 'dart:convert';

LogInModel logInModelFromJson(String str) => LogInModel.fromJson(json.decode(str));

String logInModelToJson(LogInModel data) => json.encode(data.toJson());

class LogInModel {
  String email;
  String password;

  LogInModel({
    required this.email,
    required this.password,
  });

  factory LogInModel.fromJson(Map<String, dynamic> json) => LogInModel(
    email: json["email"],
    password: json["password"],
  );

  Map<String, dynamic> toJson() => {
    "email": email,
    "password": password,
  };
}
