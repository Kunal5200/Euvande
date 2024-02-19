// To parse this JSON data, do
//
//     final registerResponseModel = registerResponseModelFromJson(jsonString);

import 'dart:convert';

RegisterResponseModel registerResponseModelFromJson(String str) => RegisterResponseModel.fromJson(json.decode(str));

String registerResponseModelToJson(RegisterResponseModel data) => json.encode(data.toJson());

class RegisterResponseModel {
  RegisterResponseModel({
    required this.message,
    required this.data,
    required this.statusCode,
  });

  final String message;
  final Data? data;
  final num statusCode;

  factory RegisterResponseModel.fromJson(Map<String, dynamic> json){
    return RegisterResponseModel(
      message: json["message"] ?? "",
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
      statusCode: json["statusCode"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": data?.toJson(),
    "statusCode": statusCode,
  };

}

class Data {
  Data({
    required this.referenceId,
    required this.otp,
  });

  final num referenceId;
  final String otp;

  factory Data.fromJson(Map<String, dynamic> json){
    return Data(
      referenceId: json["referenceId"] ?? 0,
      otp: json["OTP"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
    "referenceId": referenceId,
    "OTP": otp,
  };

}

