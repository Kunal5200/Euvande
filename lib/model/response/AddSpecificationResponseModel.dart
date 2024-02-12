// To parse this JSON data, do
//
//     final addSpecificationResponseModel = addSpecificationResponseModelFromJson(jsonString);

import 'dart:convert';

AddSpecificationResponseModel addSpecificationResponseModelFromJson(String str) => AddSpecificationResponseModel.fromJson(json.decode(str));

String addSpecificationResponseModelToJson(AddSpecificationResponseModel data) => json.encode(data.toJson());

class AddSpecificationResponseModel {
  AddSpecificationResponseModel({
    required this.message,
    required this.data,
    required this.statusCode,
  });

  final String message;
  final dynamic data;
  final num statusCode;

  factory AddSpecificationResponseModel.fromJson(Map<String, dynamic> json){
    return AddSpecificationResponseModel(
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
