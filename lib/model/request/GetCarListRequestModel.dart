// To parse this JSON data, do
//
//     final getCarListRequestModel = getCarListRequestModelFromJson(jsonString);

import 'dart:convert';

GetCarListRequestModel getCarListRequestModelFromJson(String str) => GetCarListRequestModel.fromJson(json.decode(str));

String getCarListRequestModelToJson(GetCarListRequestModel data) => json.encode(data.toJson());

class GetCarListRequestModel {
  GetCarListRequestModel({
      this.search,
      this.userId,
  });

  final String? search;
  final num? userId;

  factory GetCarListRequestModel.fromJson(Map<String, dynamic> json){
    return GetCarListRequestModel(
      search: json["search"] ?? "",
      userId: json["userId"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    "search": search,
    "userId": userId,
  };

}
