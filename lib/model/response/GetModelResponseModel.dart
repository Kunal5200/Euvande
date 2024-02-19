// To parse this JSON data, do
//
//     final getModelResponseModel = getModelResponseModelFromJson(jsonString);

import 'dart:convert';

GetModelResponseModel getModelResponseModelFromJson(String str) => GetModelResponseModel.fromJson(json.decode(str));

String getModelResponseModelToJson(GetModelResponseModel data) => json.encode(data.toJson());
class GetModelResponseModel {

  GetModelResponseModel({
    required this.message,
    required this.data,
    required this.statusCode,
  });

  final String message;
  final List<ModelData> data;
  final num statusCode;

  factory GetModelResponseModel.fromJson(Map<String, dynamic> json){
    return GetModelResponseModel(
      message: json["message"] ?? "",
      data: json["data"] == null ? [] : List<ModelData>.from(json["data"]!.map((x) => ModelData.fromJson(x))),
      statusCode: json["statusCode"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": data.map((x) => x?.toJson()).toList(),
    "statusCode": statusCode,
  };

}

class ModelData {
  ModelData({
    required this.id,
    required this.modelName,
  });

  final int id;
  final String modelName;

  factory ModelData.fromJson(Map<String, dynamic> json){
    return ModelData(
      id: json["id"] ?? 0,
      modelName: json["modelName"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "modelName": modelName,
  };

}
