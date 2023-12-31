// To parse this JSON data, do
//
//     final addPassportModel = addPassportModelFromJson(jsonString);

import 'dart:convert';
import 'dart:io';

AddPassportModel addPassportModelFromJson(String str) => AddPassportModel.fromJson(json.decode(str));

String addPassportModelToJson(AddPassportModel data) => json.encode(data.toJson());

class AddPassportModel {
  int requestType;
  String city;
  DateTime requestDate;
  int requestState;
  String notes;
  String firstName;
  String lastName;
  String motherName;
  String englishFirstName;
  String englishLastName;
  String englishMotherName;
  DateTime birthDate;
  String birthPlace;
  String englishBirthPlace;
  String oldPassPortNumber;
  String oldPassportPlaceissuance;
  DateTime oldPassportIssuingDate;
  DateTime oldPassportFinishDate;
  String town;
  String neighborhood;
  String phoneNumber;
  File? personalImage;
  File? personalIdImage1;
  File? personalIdImage2;

  AddPassportModel({
    required this.requestType,
    required this.city,
    required this.requestDate,
    required this.requestState,
    required this.notes,
    required this.firstName,
    required this.lastName,
    required this.motherName,
    required this.englishFirstName,
    required this.englishLastName,
    required this.englishMotherName,
    required this.birthDate,
    required this.birthPlace,
    required this.englishBirthPlace,
    required this.oldPassPortNumber,
    required this.oldPassportPlaceissuance,
    required this.oldPassportIssuingDate,
    required this.oldPassportFinishDate,
    required this.town,
    required this.neighborhood,
    required this.phoneNumber,
      this.personalImage,
      this.personalIdImage1,
      this.personalIdImage2,
  });

  factory AddPassportModel.fromJson(Map<String, dynamic> json) => AddPassportModel(
    requestType: json["requestType"],
    city: json["city"],
    requestDate: DateTime.parse(json["requestDate"]),
    requestState: json["requestState"],
    notes: json["notes"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    motherName: json["motherName"],
    englishFirstName: json["englishFirstName"],
    englishLastName: json["englishLastName"],
    englishMotherName: json["englishMotherName"],
    birthDate: DateTime.parse(json["birthDate"]),
    birthPlace: json["birthPlace"],
    englishBirthPlace: json["englishBirthPlace"],
    oldPassPortNumber: json["oldPassPortNumber"],
    oldPassportPlaceissuance: json["oldPassportPlaceissuance"],
    oldPassportIssuingDate: DateTime.parse(json["oldPassportIssuingDate"]),
    oldPassportFinishDate: DateTime.parse(json["oldPassportFinishDate"]),
    town: json["town"],
    neighborhood: json["neighborhood"],
    phoneNumber: json["phoneNumber"],
    personalImage: json["personal_Image"],
    personalIdImage1: json["personal_Id_Image1"],
    personalIdImage2: json["personal_Id_Image2"],
  );

  Map<String, dynamic> toJson() => {
    "requestType": requestType,
    "city": city,
    "requestDate": requestDate.toIso8601String(),
    "requestState": requestState,
    "notes": notes,
    "firstName": firstName,
    "lastName": lastName,
    "motherName": motherName,
    "englishFirstName": englishFirstName,
    "englishLastName": englishLastName,
    "englishMotherName": englishMotherName,
    "birthDate": birthDate.toIso8601String(),
    "birthPlace": birthPlace,
    "englishBirthPlace": englishBirthPlace,
    "oldPassPortNumber": oldPassPortNumber,
    "oldPassportPlaceissuance": oldPassportPlaceissuance,
    "oldPassportIssuingDate": oldPassportIssuingDate.toIso8601String(),
    "oldPassportFinishDate": oldPassportFinishDate.toIso8601String(),
    "town": town,
    "neighborhood": neighborhood,
    "phoneNumber": phoneNumber,
    "personal_Image": personalImage,
    "personal_Id_Image1": personalIdImage1,
    "personal_Id_Image2": personalIdImage2,
  };
}
