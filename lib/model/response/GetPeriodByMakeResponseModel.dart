// To parse this JSON data, do
//
//     final getPeriodByMakeResponseModel = getPeriodByMakeResponseModelFromJson(jsonString);

import 'dart:convert';

GetPeriodByMakeResponseModel getPeriodByMakeResponseModelFromJson(String str) => GetPeriodByMakeResponseModel.fromJson(json.decode(str));

String getPeriodByMakeResponseModelToJson(GetPeriodByMakeResponseModel data) => json.encode(data.toJson());
class GetPeriodByMakeResponseModel {

  GetPeriodByMakeResponseModel({
    required this.message,
    required this.data,
    required this.statusCode,
  });

  final String message;
  final List<GetPeriodByMakeData> data;
  final num statusCode;

  factory GetPeriodByMakeResponseModel.fromJson(Map<String, dynamic> json){
    return GetPeriodByMakeResponseModel(
      message: json["message"] ?? "",
      data: json["data"] == null ? [] : List<GetPeriodByMakeData>.from(json["data"]!.map((x) => GetPeriodByMakeData.fromJson(x))),
      statusCode: json["statusCode"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": data.map((x) => x?.toJson()).toList(),
    "statusCode": statusCode,
  };

}

class GetPeriodByMakeData {
  GetPeriodByMakeData({
    required this.id,
    required this.year,
  });

  final int id;
  final num year;

  factory GetPeriodByMakeData.fromJson(Map<String, dynamic> json){
    return GetPeriodByMakeData(
      id: json["id"] ?? 0,
      year: json["year"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "year": year,
  };

}
