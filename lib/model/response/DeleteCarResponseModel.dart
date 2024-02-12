// To parse this JSON data, do
//
//     final deleteCarResponseModel = deleteCarResponseModelFromJson(jsonString);

import 'dart:convert';

DeleteCarResponseModel deleteCarResponseModelFromJson(String str) => DeleteCarResponseModel.fromJson(json.decode(str));

String deleteCarResponseModelToJson(DeleteCarResponseModel data) => json.encode(data.toJson());

class DeleteCarResponseModel {
  DeleteCarResponseModel({
    required this.message,
    required this.data,
    required this.statusCode,
  });

  final String message;
  final dynamic data;
  final num statusCode;

  factory DeleteCarResponseModel.fromJson(Map<String, dynamic> json){
    return DeleteCarResponseModel(
      message: json["message"] ?? "",
      data: json["data"],
      statusCode: json["statusCode"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": data,
    "statusCode": statusCode,
  };

}
