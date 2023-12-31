import 'dart:convert';

PymentModel pymentModelFromJson(String str) => PymentModel.fromJson(json.decode(str));

String pymentModelToJson(PymentModel data) => json.encode(data.toJson());

class PymentModel {
  String bankName;
  String accountNumber;
  int cvv;
  DateTime epiryDate;
  int passPortRequestId;

  PymentModel({
    required this.bankName,
    required this.accountNumber,
    required this.cvv,
    required this.epiryDate,
    required this.passPortRequestId,
  });

  factory PymentModel.fromJson(Map<String, dynamic> json) => PymentModel(
    bankName: json["bankName"],
    accountNumber: json["accountNumber"],
    cvv: json["cvv"],
    epiryDate: DateTime.parse(json["epiryDate"]),
    passPortRequestId: json["passPortRequestId"],
  );

  Map<String, dynamic> toJson() => {
    "bankName": bankName,
    "accountNumber": accountNumber,
    "cvv": cvv,
    "epiryDate": epiryDate.toIso8601String(),
    "passPortRequestId": passPortRequestId,
  };
}
