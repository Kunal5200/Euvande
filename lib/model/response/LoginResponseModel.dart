// To parse this JSON data, do
//
//     final loginResponseModel = loginResponseModelFromJson(jsonString);

import 'dart:convert';

LoginResponseModel loginResponseModelFromJson(String str) => LoginResponseModel.fromJson(json.decode(str));

String loginResponseModelToJson(LoginResponseModel data) => json.encode(data.toJson());

class LoginResponseModel {
  String message;
  Data data;

  LoginResponseModel({
    required this.message,
    required this.data,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) => LoginResponseModel(
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
