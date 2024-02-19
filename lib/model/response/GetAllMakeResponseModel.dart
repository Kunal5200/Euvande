// To parse this JSON data, do
//
//     final getAllMakeResponseModel = getAllMakeResponseModelFromJson(jsonString);

import 'dart:convert';

GetAllMakeResponseModel getAllMakeResponseModelFromJson(String str) => GetAllMakeResponseModel.fromJson(json.decode(str));

String getAllMakeResponseModelToJson(GetAllMakeResponseModel data) => json.encode(data.toJson());
class GetAllMakeResponseModel {
  GetAllMakeResponseModel({
    required this.message,
    required this.data,
    required this.statusCode,
  });

  final String message;
  final List<GetAllMakeData> data;
  final num statusCode;

  factory GetAllMakeResponseModel.fromJson(Map<String, dynamic> json){
    return GetAllMakeResponseModel(
      message: json["message"] ?? "",
      data: json["data"] == null ? [] : List<GetAllMakeData>.from(json["data"]!.map((x) => GetAllMakeData.fromJson(x))),
      statusCode: json["statusCode"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": data.map((x) => x?.toJson()).toList(),
    "statusCode": statusCode,
  };

}

class GetAllMakeData {
  GetAllMakeData({
    required this.id,
    required this.makeName,
    required this.logo,
  });

  final int id;
  final String makeName;
  final String logo;

  factory GetAllMakeData.fromJson(Map<String, dynamic> json){
    return GetAllMakeData(
      id: json["id"] ?? 0,
      makeName: json["makeName"] ?? "",
      logo: json["logo"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "makeName": makeName,
    "logo": logo,
  };

}
