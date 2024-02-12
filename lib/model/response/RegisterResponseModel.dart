// To parse this JSON data, do
//
//     final registerResponseModel = registerResponseModelFromJson(jsonString);

import 'dart:convert';

RegisterResponseModel registerResponseModelFromJson(String str) => RegisterResponseModel.fromJson(json.decode(str));

String registerResponseModelToJson(RegisterResponseModel data) => json.encode(data.toJson());

class RegisterResponseModel {
  String message;
  Data data;

  RegisterResponseModel({
    required this.message,
    required this.data,
  });

  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) => RegisterResponseModel(
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": data.toJson(),
  };
}

class Data {
  int referenceId;
  String name;

  Data({
    required this.referenceId,
    required this.name,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    referenceId: json["referenceId"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "referenceId": referenceId,
    "name": name,
  };
}
