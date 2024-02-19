// To parse this JSON data, do
//
//     final verifyRequestModel = verifyRequestModelFromJson(jsonString);

import 'dart:convert';

VerifyRequestModel verifyRequestModelFromJson(String str) => VerifyRequestModel.fromJson(json.decode(str));

String verifyRequestModelToJson(VerifyRequestModel data) => json.encode(data.toJson());

class VerifyRequestModel {
  int referenceId;
  String otp;
  String? password;

  VerifyRequestModel({
    required this.referenceId,
    required this.otp,
    required this.password,
  });

  factory VerifyRequestModel.fromJson(Map<String, dynamic> json) => VerifyRequestModel(
    referenceId: json["referenceId"],
    otp: json["otp"],
    password: json["password"],
  );

  Map<String, dynamic> toJson() => {
    "referenceId": referenceId,
    "otp": otp,
    "password": password,
  };
}
