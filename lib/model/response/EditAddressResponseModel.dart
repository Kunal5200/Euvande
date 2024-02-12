// To parse this JSON data, do
//
//     final editAddressResponseModel = editAddressResponseModelFromJson(jsonString);

import 'dart:convert';

EditAddressResponseModel editAddressResponseModelFromJson(String str) => EditAddressResponseModel.fromJson(json.decode(str));

String editAddressResponseModelToJson(EditAddressResponseModel data) => json.encode(data.toJson());

class EditAddressResponseModel {
  EditAddressResponseModel({
    required this.message,
    required this.data,
    required this.statusCode,
  });

  final String message;
  final dynamic data;
  final num statusCode;

  factory EditAddressResponseModel.fromJson(Map<String, dynamic> json){
    return EditAddressResponseModel(
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
