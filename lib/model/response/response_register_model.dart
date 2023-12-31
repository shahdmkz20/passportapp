import 'dart:convert';

RegisterResponseModel RegisterResbonseModelFromJson(String str) => RegisterResponseModel.fromJson(json.decode(str));

String RegisterResbonseModelToJson(RegisterResponseModel data) => json.encode(data.toJson());

class RegisterResponseModel {
  bool data;
  bool succsess;
  String message;

  RegisterResponseModel({
    required this.data,
    required this.succsess,
    required this.message,
  });

  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) => RegisterResponseModel(
    data: json["data"],
    succsess: json["succsess"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "data": data,
    "succsess": succsess,
    "message": message,
  };
}


