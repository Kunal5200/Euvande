// To parse this JSON data, do
//
//     final addCarRequestModel = addCarRequestModelFromJson(jsonString);

import 'dart:convert';

AddCarRequestModel addCarRequestModelFromJson(String str) => AddCarRequestModel.fromJson(json.decode(str));

String addCarRequestModelToJson(AddCarRequestModel data) => json.encode(data.toJson());

class AddCarRequestModel {
  AddCarRequestModel({
     this.id,
     this.modelId,
     this.makeId,
     this.periodId,
     this.variantId,
     this.odometer,
     this.ownership,
     this.contactInfo,
     this.location,
     this.price,
  });

  num? id;
  num? modelId;
  num? makeId;
  num? periodId;
  num? variantId;
  String? odometer;
  num? year;
  String? ownership;
  ContactInfo? contactInfo;
  Location? location;
  num? price;

  factory AddCarRequestModel.fromJson(Map<String, dynamic> json){
    return AddCarRequestModel(
      id: json["id"] ?? 0,
      modelId: json["modelId"] ?? 0,
      makeId: json["makeId"] ?? 0,
      periodId: json["periodId"] ?? 0,
      variantId: json["variantId"] ?? 0,
      odometer: json["odometer"] ?? "",
      ownership: json["ownership"] ?? "",
      price: json["price"] ?? 0,
      contactInfo: json["contactInfo"] == null ? null : ContactInfo.fromJson(json["contactInfo"]),
      location: json["location"] == null ? null : Location.fromJson(json["location"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "modelId": modelId,
    "makeId": makeId,
    "periodId": periodId,
    "variantId": variantId,
    "odometer": odometer,
    "ownership": ownership,
    "price": price,
    "contactInfo": contactInfo?.toJson(),
    "location": location?.toJson(),
  };

}

class ContactInfo {
  ContactInfo({
    required this.name,
    required this.phoneNo,
    required this.zipCode,
  });

  final String name;
  final String phoneNo;
  final String zipCode;

  factory ContactInfo.fromJson(Map<String, dynamic> json){
    return ContactInfo(
      name: json["name"] ?? 0,
      phoneNo: json["phoneNO"] ?? "",
      zipCode: json["zipCode"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
    "name": name,
    "phoneNO": phoneNo,
    "zipCode": zipCode,
  };

}

class Location {
  Location({
    required this.city,
    required this.latitude,
    required this.longitude,
  });

  final String city;
  final num latitude;
  final num longitude;

  factory Location.fromJson(Map<String, dynamic> json){
    return Location(
      city: json["city"] ?? "",
      latitude: json["latitude"] ?? 0,
      longitude: json["longitude"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    "city": city,
    "latitude": latitude,
    "longitude": longitude,
  };

}