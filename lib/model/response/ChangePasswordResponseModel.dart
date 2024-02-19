// To parse this JSON data, do
//
//     final changePasswordResponseModel = changePasswordResponseModelFromJson(jsonString);

import 'dart:convert';

ChangePasswordResponseModel changePasswordResponseModelFromJson(String str) => ChangePasswordResponseModel.fromJson(json.decode(str));

String changePasswordResponseModelToJson(ChangePasswordResponseModel data) => json.encode(data.toJson());

class ChangePasswordResponseModel {
  ChangePasswordResponseModel({
    required this.message,
    required this.data,
    required this.statusCode,
  });

  final String message;
  final Data? data;
  final num statusCode;

  factory ChangePasswordResponseModel.fromJson(Map<String, dynamic> json){
    return ChangePasswordResponseModel(
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
    required this.accessToken,
    required this.refreshToken,
    required this.group,
  });

  final String accessToken;
  final String refreshToken;
  final String group;

  factory Data.fromJson(Map<String, dynamic> json){
    return Data(
      accessToken: json["accessToken"] ?? "",
      refreshToken: json["refreshToken"] ?? "",
      group: json["group"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
    "accessToken": accessToken,
    "refreshToken": refreshToken,
    "group": group,
  };

}
