// To parse this JSON data, do
//
//     final getVariantByModelResponseModel = getVariantByModelResponseModelFromJson(jsonString);

import 'dart:convert';

GetVariantByModelResponseModel getVariantByModelResponseModelFromJson(String str) => GetVariantByModelResponseModel.fromJson(json.decode(str));

String getVariantByModelResponseModelToJson(GetVariantByModelResponseModel data) => json.encode(data.toJson());
class GetVariantByModelResponseModel {
  GetVariantByModelResponseModel({
    required this.message,
    required this.data,
    required this.statusCode,
  });

  final String message;
  final List<GetVariantByModelData> data;
  final num statusCode;

  factory GetVariantByModelResponseModel.fromJson(Map<String, dynamic> json){
    return GetVariantByModelResponseModel(
      message: json["message"] ?? "",
      data: json["data"] == null ? [] : List<GetVariantByModelData>.from(json["data"]!.map((x) => GetVariantByModelData.fromJson(x))),
      statusCode: json["statusCode"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": data.map((x) => x?.toJson()).toList(),
    "statusCode": statusCode,
  };

}

class GetVariantByModelData {
  GetVariantByModelData({
    required this.id,
    required this.variantName,
    required this.fuelType,
  });

  final int id;
  final String variantName;
  final String fuelType;

  factory GetVariantByModelData.fromJson(Map<String, dynamic> json){
    return GetVariantByModelData(
      id: json["id"] ?? 0,
      variantName: json["variantName"] ?? "",
      fuelType: json["fuelType"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "variantName": variantName,
    "fuelType": fuelType,
  };

}
