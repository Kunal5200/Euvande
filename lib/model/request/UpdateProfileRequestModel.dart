// To parse this JSON data, do
//
//     final updateProfileRequestModel = updateProfileRequestModelFromJson(jsonString);

import 'dart:convert';

UpdateProfileRequestModel updateProfileRequestModelFromJson(String str) => UpdateProfileRequestModel.fromJson(json.decode(str));

String updateProfileRequestModelToJson(UpdateProfileRequestModel data) => json.encode(data.toJson());

class UpdateProfileRequestModel {
  UpdateProfileRequestModel({
    required this.name,
    required this.countryName,
    required this.zipCode,
    required this.phoneNo,
    required this.countryCode,
    required this.email,
  });

  final String? name;
  final String? countryName;
  final String? zipCode;
  final String? phoneNo;
  final String? countryCode;
  final dynamic email;

  factory UpdateProfileRequestModel.fromJson(Map<String, dynamic> json){
    return UpdateProfileRequestModel(
      name: json["name"] ?? "",
      countryName: json["countryName"] ?? "",
      zipCode: json["zipCode"] ?? "",
      phoneNo: json["phoneNo"] ?? "",
      countryCode: json["countryCode"] ?? "",
      email: json["email"],
    );
  }

  Map<String, dynamic> toJson() => {
    "name": name,
    "countryName": countryName,
    "zipCode": zipCode,
    "phoneNo": phoneNo,
    "countryCode": countryCode,
    "email": email,
  };

}

