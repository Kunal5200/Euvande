// To parse this JSON data, do
//
//     final getDefaultSpecificationResponseModel = getDefaultSpecificationResponseModelFromJson(jsonString);

import 'dart:convert';

GetDefaultSpecificationResponseModel getDefaultSpecificationResponseModelFromJson(String str) => GetDefaultSpecificationResponseModel.fromJson(json.decode(str));

String getDefaultSpecificationResponseModelToJson(GetDefaultSpecificationResponseModel data) => json.encode(data.toJson());

class GetDefaultSpecificationResponseModel {
  GetDefaultSpecificationResponseModel({
    required this.message,
    required this.data,
    required this.statusCode,
  });

  final String message;
  final Data? data;
  final num statusCode;

  factory GetDefaultSpecificationResponseModel.fromJson(Map<String, dynamic> json){
    return GetDefaultSpecificationResponseModel(
      message: json["message"] ?? "",
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
      statusCode: json["statusCode"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": data?.toJson(),
    "statusCode": statusCode,
  };

}

class Data {
  Data({
    required this.id,
    required this.transmission,
    required this.doors,
    required this.driveType4Wd,
    required this.vehicleType,
    required this.seats,
    required this.interiorMaterial,
    required this.vatDeduction,
    required this.features,
    required this.fuel,
    required this.equipments,
  });

  final int id;
  final List<String> transmission;
  final List<String> doors;
  final List<String> driveType4Wd;
  final List<String> vehicleType;
  final List<num> seats;
  final List<String> interiorMaterial;
  final List<String> vatDeduction;
  final dynamic features;
  final List<String> fuel;
  final List<String> equipments;

  factory Data.fromJson(Map<String, dynamic> json){
    return Data(
      id: json["id"] ?? 0,
      transmission: json["transmission"] == null ? [] : List<String>.from(json["transmission"]!.map((x) => x)),
      doors: json["doors"] == null ? [] : List<String>.from(json["doors"]!.map((x) => x)),
      driveType4Wd: json["driveType4WD"] == null ? [] : List<String>.from(json["driveType4WD"]!.map((x) => x)),
      vehicleType: json["vehicleType"] == null ? [] : List<String>.from(json["vehicleType"]!.map((x) => x)),
      seats: json["seats"] == null ? [] : List<num>.from(json["seats"]!.map((x) => x)),
      interiorMaterial: json["interiorMaterial"] == null ? [] : List<String>.from(json["interiorMaterial"]!.map((x) => x)),
      vatDeduction: json["vatDeduction"] == null ? [] : List<String>.from(json["vatDeduction"]!.map((x) => x)),
      features: json["features"],
      fuel: json["fuel"] == null ? [] : List<String>.from(json["fuel"]!.map((x) => x)),
      equipments: json["equipments"] == null ? [] : List<String>.from(json["equipments"]!.map((x) => x)),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "transmission": transmission.map((x) => x).toList(),
    "doors": doors.map((x) => x).toList(),
    "driveType4WD": driveType4Wd.map((x) => x).toList(),
    "vehicleType": vehicleType.map((x) => x).toList(),
    "seats": seats.map((x) => x).toList(),
    "interiorMaterial": interiorMaterial.map((x) => x).toList(),
    "vatDeduction": vatDeduction.map((x) => x).toList(),
    "features": features,
    "fuel": fuel.map((x) => x).toList(),
    "equipments": equipments.map((x) => x).toList(),
  };

}
