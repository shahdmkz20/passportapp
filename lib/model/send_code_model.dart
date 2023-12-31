import 'dart:convert';

SendCodeModel sendCodeModelFromJson(String str) => SendCodeModel.fromJson(json.decode(str));

String sendCodeModelToJson(SendCodeModel data) => json.encode(data.toJson());

class SendCodeModel {
  String email;
  String code;

  SendCodeModel({
    required this.email,
    required this.code,
  });

  factory SendCodeModel.fromJson(Map<String, dynamic> json) => SendCodeModel(
    email: json["email"],
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "email": email,
    "code": code,
  };
}
