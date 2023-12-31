import 'dart:convert';

AddPassportResponseModel addPassportResponseModelFromJson(String str) => AddPassportResponseModel.fromJson(json.decode(str));

String addPassportResponseModelToJson(AddPassportResponseModel data) => json.encode(data.toJson());

class AddPassportResponseModel {
  String? data;
  bool succsess;
  String message;

  AddPassportResponseModel({
     this.data,
    required this.succsess,
    required this.message,
  });

  factory AddPassportResponseModel.fromJson(Map<String, dynamic> json) => AddPassportResponseModel(
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
