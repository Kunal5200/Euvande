// To parse this JSON data, do
//
//     final verifyResponseModel = verifyResponseModelFromJson(jsonString);

import 'dart:convert';

VerifyResponseModel verifyResponseModelFromJson(String str) => VerifyResponseModel.fromJson(json.decode(str));

String verifyResponseModelToJson(VerifyResponseModel data) => json.encode(data.toJson());

class VerifyResponseModel {
  String message;
  Data data;

  VerifyResponseModel({
    required this.message,
    required this.data,
  });

  factory VerifyResponseModel.fromJson(Map<String, dynamic> json) => VerifyResponseModel(
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": data.toJson(),
  };
}

class Data {
  String accessToken;
  String refreshToken;
  String group;

  Data({
    required this.accessToken,
    required this.refreshToken,
    required this.group,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    accessToken: json["accessToken"],
    refreshToken: json["refreshToken"],
    group: json["group"],
  );

  Map<String, dynamic> toJson() => {
    "accessToken": accessToken,
    "refreshToken": refreshToken,
    "group": group,
  };
}
