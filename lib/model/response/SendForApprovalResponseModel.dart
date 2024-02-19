// To parse this JSON data, do
//
//     final sendForApprovalResponseModel = sendForApprovalResponseModelFromJson(jsonString);

import 'dart:convert';

SendForApprovalResponseModel sendForApprovalResponseModelFromJson(String str) => SendForApprovalResponseModel.fromJson(json.decode(str));

String sendForApprovalResponseModelToJson(SendForApprovalResponseModel data) => json.encode(data.toJson());

class SendForApprovalResponseModel {
  SendForApprovalResponseModel({
    required this.message,
    required this.data,
    required this.statusCode,
  });

  final String message;
  final dynamic data;
  final num statusCode;

  factory SendForApprovalResponseModel.fromJson(Map<String, dynamic> json){
    return SendForApprovalResponseModel(
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
