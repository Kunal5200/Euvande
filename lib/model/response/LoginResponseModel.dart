// To parse this JSON data, do
//
//     final loginResponseModel = loginResponseModelFromJson(jsonString);

import 'dart:convert';

LoginResponseModel loginResponseModelFromJson(String str) => LoginResponseModel.fromJson(json.decode(str));

String loginResponseModelToJson(LoginResponseModel data) => json.encode(data.toJson());

class LoginResponseModel {

  LoginResponseModel({
    required this.message,
    required this.data,
    required this.statusCode,
  });

  final String message;
  final LoginData data;
  final num statusCode;

  factory LoginResponseModel.fromJson(Map<String, dynamic> json){
    return LoginResponseModel(
      message: json["message"] ?? "",
      data: LoginData.fromJson(json["data"]),
      statusCode: json["statusCode"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": data?.toJson(),
    "statusCode": statusCode,
  };

}

class LoginData {
  LoginData({
    required this.accessToken,
    required this.refreshToken,
    required this.group,
    required this.name,
    required this.email,
    required this.referenceId,
  });

  String accessToken;
  String refreshToken;
  String group;
  String name;
  String email;
  num referenceId;

  factory LoginData.fromJson(Map<String, dynamic> json){
    return LoginData(
      accessToken: json["accessToken"] ?? "",
      refreshToken: json["refreshToken"] ?? "",
      group: json["group"] ?? "",
      name: json["name"] ?? "",
      email: json["email"] ?? "",
      referenceId: json["referenceId"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    "accessToken": accessToken,
    "refreshToken": refreshToken,
    "group": group,
    "name": name,
    "email": email,
    "referenceId": referenceId,
  };

}
