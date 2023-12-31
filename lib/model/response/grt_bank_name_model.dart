import 'dart:convert';

GetBankNameModel getBankNameModelFromJson(String str) => GetBankNameModel.fromJson(json.decode(str));

String getBankNameModelToJson(GetBankNameModel data) => json.encode(data.toJson());

class GetBankNameModel {
  List<String> data;
  bool succsess;
  String message;

  GetBankNameModel({
    required this.data,
    required this.succsess,
    required this.message,
  });

  factory GetBankNameModel.fromJson(Map<String, dynamic> json) => GetBankNameModel(
    data: List<String>.from(json["data"].map((x) => x)),
    succsess: json["succsess"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x)),
    "succsess": succsess,
    "message": message,
  };
}
