// To parse this JSON data, do
//
//     final addCarResponseModel = addCarResponseModelFromJson(jsonString);

import 'dart:convert';

AddCarResponseModel addCarResponseModelFromJson(String str) => AddCarResponseModel.fromJson(json.decode(str));

String addCarResponseModelToJson(AddCarResponseModel data) => json.encode(data.toJson());

class AddCarResponseModel {
  AddCarResponseModel({
    required this.message,
    required this.data,
    required this.statusCode,
  });

  final String message;
  final AddCarData? data;
  final num statusCode;

  factory AddCarResponseModel.fromJson(Map<String, dynamic> json){
    return AddCarResponseModel(
      message: json["message"] ?? "",
      data: json["data"] == null ? null : AddCarData.fromJson(json["data"]),
      statusCode: json["statusCode"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": data?.toJson(),
    "statusCode": statusCode,
  };

}

class AddCarData {
  AddCarData({
    required this.id,
    required this.ownership,
    required this.odometer,
    required this.price,
    required this.status,
    required this.vin,
    required this.createdAt,
    required this.updatedAt,
    required this.contactInfo,
    required this.location,
    required this.media,
    required this.make,
    required this.period,
    required this.model,
    required this.variant,
    required this.specification,
    required this.seller,
    required this.car,
  });

  final int id;
  final dynamic ownership;
  final dynamic odometer;
  final dynamic price;
  final String status;
  final dynamic vin;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic contactInfo;
  final dynamic location;
  final dynamic media;
  final num make;
  final num period;
  final num model;
  final num variant;
  final dynamic specification;
  final num seller;
  final dynamic car;

  factory AddCarData.fromJson(Map<String, dynamic> json){
    return AddCarData(
      id: json["id"] ?? 0,
      ownership: json["ownership"],
      odometer: json["odometer"],
      price: json["Price"],
      status: json["status"] ?? "",
      vin: json["vin"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      contactInfo: json["contactInfo"],
      location: json["location"],
      media: json["media"],
      make: json["make"] ?? 0,
      period: json["period"] ?? 0,
      model: json["model"] ?? 0,
      variant: json["variant"] ?? 0,
      specification: json["specification"],
      seller: json["seller"] ?? 0,
      car: json["car"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "ownership": ownership,
    "odometer": odometer,
    "Price": price,
    "status": status,
    "vin": vin,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "contactInfo": contactInfo,
    "location": location,
    "media": media,
    "make": make,
    "period": period,
    "model": model,
    "variant": variant,
    "specification": specification,
    "seller": seller,
    "car": car,
  };

}
