import 'dart:convert';

UploadImageResponseModel uploadImageResponseModelFromJson(String str) => UploadImageResponseModel.fromJson(json.decode(str));

String uploadImageResponseModelToJson(UploadImageResponseModel data) => json.encode(data.toJson());

class UploadImageResponseModel {
  bool data;
  bool succsess;
  String message;

  UploadImageResponseModel({
    required this.data,
    required this.succsess,
    required this.message,
  });

  factory UploadImageResponseModel.fromJson(Map<String, dynamic> json) => UploadImageResponseModel(
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
