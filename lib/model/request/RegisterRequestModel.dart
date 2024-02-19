// To parse this JSON data, do
//
//     final registerRequestModel = registerRequestModelFromJson(jsonString);

import 'dart:convert';

RegisterRequestModel registerRequestModelFromJson(String str) => RegisterRequestModel.fromJson(json.decode(str));

String registerRequestModelToJson(RegisterRequestModel data) => json.encode(data.toJson());

class RegisterRequestModel {
  String email;
  String password;
  String name;

  RegisterRequestModel({
    required this.email,
    required this.password,
    required this.name,
  });

  factory RegisterRequestModel.fromJson(Map<String, dynamic> json) => RegisterRequestModel(
    email: json["email"],
    password: json["password"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "email": email,
    "password": password,
    "name": name,
  };
}
