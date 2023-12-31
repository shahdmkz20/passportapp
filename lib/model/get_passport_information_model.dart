import 'dart:convert';

GetPassportInformationModel getPassportInformationModelFromJson(String str) => GetPassportInformationModel.fromJson(json.decode(str));

String getPassportInformationModelToJson(GetPassportInformationModel data) => json.encode(data.toJson());

class GetPassportInformationModel {
  List<Datum>? data;
  bool? succsess;
  String? message;

  GetPassportInformationModel({
     this.data,
     this.succsess,
     this.message,
  });

  factory GetPassportInformationModel.fromJson(Map<String, dynamic> json) => GetPassportInformationModel(
    data:json["data"]!=[] ?List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))):[],
    succsess: json["succsess"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    "succsess": succsess,
    "message": message,
  };
}

class Datum {
  int id;
  int requestType;
  DateTime requestDate;
  int requestState;
  String notes;

  Datum({
    required this.id,
    required this.requestType,
    required this.requestDate,
    required this.requestState,
    required this.notes,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    requestType: json["requestType"],
    requestDate: DateTime.parse(json["requestDate"]),
    requestState: json["requestState"],
    notes: json["notes"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "requestType": requestType,
    "requestDate": requestDate.toIso8601String(),
    "requestState": requestState,
    "notes": notes,
  };
}
