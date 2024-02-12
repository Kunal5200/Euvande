// To parse this JSON data, do
//
//     final getVariantByModelRequestModel = getVariantByModelRequestModelFromJson(jsonString);

import 'dart:convert';

GetVariantByModelRequestModel getVariantByModelRequestModelFromJson(String str) => GetVariantByModelRequestModel.fromJson(json.decode(str));

String getVariantByModelRequestModelToJson(GetVariantByModelRequestModel data) => json.encode(data.toJson());

class GetVariantByModelRequestModel {

  GetVariantByModelRequestModel({
    required this.fuelType,
    required this.modelId,
  });

  final String fuelType;
  final int modelId;

  factory GetVariantByModelRequestModel.fromJson(Map<String, dynamic> json){
    return GetVariantByModelRequestModel(
      fuelType: json["fuelType"] ?? "",
      modelId: json["modelId"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
    "fuelType": fuelType,
    "modelId": modelId,
  };

}
