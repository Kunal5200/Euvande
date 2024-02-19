// To parse this JSON data, do
//
//     final addMediaResponseModel = addMediaResponseModelFromJson(jsonString);

import 'dart:convert';

AddMediaResponseModel addMediaResponseModelFromJson(String str) => AddMediaResponseModel.fromJson(json.decode(str));

String addMediaResponseModelToJson(AddMediaResponseModel data) => json.encode(data.toJson());

class AddMediaResponseModel {
  AddMediaResponseModel({
    required this.message,
    required this.data,
    required this.statusCode,
  });

  final String message;
  final dynamic data;
  final num statusCode;

  factory AddMediaResponseModel.fromJson(Map<String, dynamic> json){
    return AddMediaResponseModel(
      message: json["message"] ?? "",
      data: json["data"],
      statusCode: json["statusCode"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": data?.toJson(),
    "statusCode": statusCode,
  };

}
