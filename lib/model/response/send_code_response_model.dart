import 'dart:convert';

SendCodeResponseModel SendCodeResbonseModelFromJson(String str) => SendCodeResponseModel.fromJson(json.decode(str));

String SendCodeResbonseModelToJson(SendCodeResponseModel data) => json.encode(data.toJson());

class SendCodeResponseModel {
  int data;
  bool succsess;
  String message;

  SendCodeResponseModel({
    required this.data,
    required this.succsess,
    required this.message,
  });

  factory SendCodeResponseModel.fromJson(Map<String, dynamic> json) => SendCodeResponseModel(
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


