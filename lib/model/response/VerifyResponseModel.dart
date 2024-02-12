// To parse this JSON data, do
//
//     final verifyResponseModel = verifyResponseModelFromJson(jsonString);

import 'dart:convert';

VerifyResponseModel verifyResponseModelFromJson(String str) => VerifyResponseModel.fromJson(json.decode(str));

String verifyResponseModelToJson(VerifyResponseModel data) => json.encode(data.toJson());

class VerifyResponseModel {
  String message;
  Data? data;
  int statusCode;

  VerifyResponseModel({
    required this.message,
    required this.data,
    required this.statusCode,
});


  factory VerifyResponseModel.fromJson(Map<String, dynamic> json) => VerifyResponseModel(
    message: json["message"],
    statusCode: json["statusCode"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "statusCode": statusCode,
    "data": data?.toJson(),
  };

}

class Data {
  String? accessToken;
  String? refreshToken;
  String? group;
  String? name;
  String? email;

  Data({
    required this.accessToken,
    required this.refreshToken,
    required this.group,
    required this.name,
    required this.email,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    accessToken: json["accessToken"],
    refreshToken: json["refreshToken"],
    group: json["group"],
    name: json["name"],
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "accessToken": accessToken,
    "refreshToken": refreshToken,
    "group": group,
    "name": name,
    "email": email,
  };
}
