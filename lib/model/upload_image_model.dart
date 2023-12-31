import 'dart:io';

class UploadImageModel{
  File? personalImage;
  File? personalIdImage1;
  File? personalIdImage2;
  UploadImageModel({this.personalImage,this.personalIdImage1,this.personalIdImage2});
  factory UploadImageModel.fromJson(Map<String, dynamic> json) => UploadImageModel(
    personalImage: json["f"],
    personalIdImage1: json["f2"],
    personalIdImage2: json["f3"],
  );
  Map<String, dynamic> toJson() => {
    "f": personalImage,
    "f2": personalIdImage1,
    "f3": personalIdImage2,
  };
}