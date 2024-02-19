// To parse this JSON data, do
//
//     final addAddressResponseModel = addAddressResponseModelFromJson(jsonString);

import 'dart:convert';

AddAddressResponseModel addAddressResponseModelFromJson(String str) => AddAddressResponseModel.fromJson(json.decode(str));

String addAddressResponseModelToJson(AddAddressResponseModel data) => json.encode(data.toJson());

class AddAddressResponseModel {
  AddAddressResponseModel({
    required this.message,
    required this.data,
    required this.statusCode,
  });

  final String message;
  final dynamic data;
  final num statusCode;

  factory AddAddressResponseModel.fromJson(Map<String, dynamic> json){
    return AddAddressResponseModel(
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
