// To parse this JSON data, do
//
//     final favoriteRequestModel = favoriteRequestModelFromJson(jsonString);

import 'dart:convert';

FavoriteRequestModel favoriteRequestModelFromJson(String str) => FavoriteRequestModel.fromJson(json.decode(str));

String favoriteRequestModelToJson(FavoriteRequestModel data) => json.encode(data.toJson());

class FavoriteRequestModel {
  FavoriteRequestModel({
    required this.carId,
    required this.favourite,
  });

  final num carId;
  final bool favourite;

  factory FavoriteRequestModel.fromJson(Map<String, dynamic> json){
    return FavoriteRequestModel(
      carId: json["carId"] ?? 0,
      favourite: json["favourite"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    "carId": carId,
    "favourite": favourite,
  };

}
