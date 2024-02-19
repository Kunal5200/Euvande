// To parse this JSON data, do
//
//     final favoriteResponseModel = favoriteResponseModelFromJson(jsonString);

import 'dart:convert';

FavoriteResponseModel favoriteResponseModelFromJson(String str) => FavoriteResponseModel.fromJson(json.decode(str));

String favoriteResponseModelToJson(FavoriteResponseModel data) => json.encode(data.toJson());

class FavoriteResponseModel {
  FavoriteResponseModel({
    required this.message,
    required this.data,
    required this.statusCode,
  });

  final String message;
  final dynamic data;
  final num statusCode;

  factory FavoriteResponseModel.fromJson(Map<String, dynamic> json){
    return FavoriteResponseModel(
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
