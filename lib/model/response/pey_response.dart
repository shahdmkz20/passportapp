import 'dart:convert';

PeyResponseModel peyResponseModelFromJson(String str) => PeyResponseModel.fromJson(json.decode(str));

String peyResponseModelToJson(PeyResponseModel data) => json.encode(data.toJson());

class PeyResponseModel {
  int data;
  bool succsess;
  String message;

  PeyResponseModel({
    required this.data,
    required this.succsess,
    required this.message,
  });

  factory PeyResponseModel.fromJson(Map<String, dynamic> json) => PeyResponseModel(
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
