
import 'dart:convert';

RegisterModel RegisterModelFromJson(String str) => RegisterModel.fromJson(json.decode(str));

String RegisterModelToJson(RegisterModel data) => json.encode(data.toJson());

class RegisterModel {
  String nationalId;
  String email;
  String password;

  RegisterModel({
    required this.nationalId,
    required this.email,
    required this.password,
  });

  factory RegisterModel.fromJson(Map<String, dynamic> json) => RegisterModel(
    nationalId: json["nationalId"],
    email: json["email"],
    password: json["password"],
  );

  Map<String, dynamic> toJson() => {
    "nationalId": nationalId,
    "email": email,
    "password": password,
  };
}