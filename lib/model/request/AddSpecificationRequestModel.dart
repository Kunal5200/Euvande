// To parse this JSON data, do
//
//     final addSpecificationRequestModel = addSpecificationRequestModelFromJson(jsonString);

import 'dart:convert';

AddSpecificationRequestModel addSpecificationRequestModelFromJson(String str) => AddSpecificationRequestModel.fromJson(json.decode(str));

String addSpecificationRequestModelToJson(AddSpecificationRequestModel data) => json.encode(data.toJson());

class AddSpecificationRequestModel {
  AddSpecificationRequestModel({
     this.carId,
     this.driveType4Wd,
     this.doors,
     this.interiorMaterial,
     this.seats,
     this.transmission,
     this.variantId,
     this.vatDeduction,
     this.vehicleType,
     this.power,
     this.color,
     this.equipments,
  });

  num?  carId;
  String?  driveType4Wd;
  String?  doors;
  String?  interiorMaterial;
  num?  seats;
  String?  transmission;
  num?  variantId;
  String?  vatDeduction;
  String?  vehicleType;
  String?  power;
  String?  color;
  List<dynamic>? equipments;

  factory AddSpecificationRequestModel.fromJson(Map<String, dynamic> json){
    return AddSpecificationRequestModel(
      carId: json["carId"] ?? 0,
      driveType4Wd: json["driveType4WD"] ?? "",
      doors: json["doors"] ?? "",
      interiorMaterial: json["interiorMaterial"] ?? "",
      seats: json["seats"] ?? 0,
      transmission: json["transmission"] ?? "",
      variantId: json["variantId"] ?? 0,
      vatDeduction: json["vatDeduction"] ?? "",
      vehicleType: json["vehicleType"] ?? "",
      power: json["power"] ?? "",
      color: json["color"] ?? "",
      equipments: json["equipments"] == null ? [] : List<dynamic>.from(json["equipments"]!.map((x) => x)),
    );
  }

  Map<String, dynamic> toJson() => {
    "carId": carId,
    "driveType4WD": driveType4Wd,
    "doors": doors,
    "interiorMaterial": interiorMaterial,
    "seats": seats,
    "transmission": transmission,
    "variantId": variantId,
    "vatDeduction": vatDeduction,
    "vehicleType": vehicleType,
    "power": power,
    "color": color,
    "equipments": equipments?.map((x) => x).toList(),
  };

}
