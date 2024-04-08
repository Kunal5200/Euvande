// To parse this JSON data, do
//
//     final GetCarDetailsResponseModel = GetCarDetailsResponseModelFromJson(jsonString);

import 'dart:convert';

GetCarDetailsResponseModel GetCarDetailsResponseModelFromJson(String str) => GetCarDetailsResponseModel.fromJson(json.decode(str));

String GetCarDetailsResponseModelToJson(GetCarDetailsResponseModel data) => json.encode(data.toJson());

class GetCarDetailsResponseModel {
  GetCarDetailsResponseModel({
    required this.message,
    required this.data,
    required this.statusCode,
  });

  final String message;
  final Data? data;
  final num statusCode;

  factory GetCarDetailsResponseModel.fromJson(Map<String, dynamic> json){
    return GetCarDetailsResponseModel(
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
    required this.ownership,
    required this.odometer,
    required this.price,
    required this.status,
    required this.vin,
    required this.createdAt,
    required this.updatedAt,
    required this.guestUserId,
    required this.contactInfo,
    required this.location,
    required this.make,
    required this.model,
    required this.variant,
    required this.specification,
    required this.period,
    required this.media,
    required this.carImages,
  });

  final int id;
  final dynamic ownership;
  final dynamic odometer;
  final dynamic price;
  final String status;
  final String vin;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String guestUserId;
  final dynamic contactInfo;
  final dynamic location;
  final Make? make;
  final Model? model;
  final Variant? variant;
  final Specification? specification;
  final Period? period;
  final dynamic media;
  final List<dynamic> carImages;

  factory Data.fromJson(Map<String, dynamic> json){
    return Data(
      id: json["id"] ?? 0,
      ownership: json["ownership"],
      odometer: json["odometer"],
      price: json["price"],
      status: json["status"] ?? "",
      vin: json["vin"] ?? "",
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      guestUserId: json["guestUserId"] ?? "",
      contactInfo: json["contactInfo"],
      location: json["location"],
      make: json["make"] == null ? null : Make.fromJson(json["make"]),
      model: json["model"] == null ? null : Model.fromJson(json["model"]),
      variant: json["variant"] == null ? null : Variant.fromJson(json["variant"]),
      specification: json["specification"] == null ? null : Specification.fromJson(json["specification"]),
      period: json["period"] == null ? null : Period.fromJson(json["period"]),
      media: json["media"],
      carImages: json["carImages"] == null ? [] : List<dynamic>.from(json["carImages"]!.map((x) => x)),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "ownership": ownership,
    "odometer": odometer,
    "price": price,
    "status": status,
    "vin": vin,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "guestUserId": guestUserId,
    "contactInfo": contactInfo,
    "location": location,
    "make": make?.toJson(),
    "model": model?.toJson(),
    "variant": variant?.toJson(),
    "specification": specification?.toJson(),
    "period": period?.toJson(),
    "media": media,
    "carImages": carImages.map((x) => x).toList(),
  };

}

class Make {
  Make({
    required this.id,
    required this.makeName,
    required this.logo,
  });

  final int id;
  final String makeName;
  final String logo;

  factory Make.fromJson(Map<String, dynamic> json){
    return Make(
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

class Model {
  Model({
    required this.id,
    required this.modelName,
  });

  final int id;
  final String modelName;

  factory Model.fromJson(Map<String, dynamic> json){
    return Model(
      id: json["id"] ?? 0,
      modelName: json["modelName"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "modelName": modelName,
  };

}

class Period {
  Period({
    required this.id,
    required this.year,
  });

  final int id;
  final num year;

  factory Period.fromJson(Map<String, dynamic> json){
    return Period(
      id: json["id"] ?? 0,
      year: json["year"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "year": year,
  };

}

class Specification {
  Specification({
    required this.id,
    required this.transmission,
    required this.vehicleType,
    required this.driveType4Wd,
    required this.doors,
    required this.seats,
    required this.interiorMaterial,
    required this.vatDeduction,
    required this.equipments,
    required this.power,
    required this.color,
    required this.specificationDetails,
  });

  final int id;
  final String transmission;
  final dynamic vehicleType;
  final String driveType4Wd;
  final String doors;
  final num seats;
  final dynamic interiorMaterial;
  final dynamic vatDeduction;
  final dynamic equipments;
  final dynamic power;
  final dynamic color;
  final SpecificationDetails? specificationDetails;

  factory Specification.fromJson(Map<String, dynamic> json){
    return Specification(
      id: json["id"] ?? 0,
      transmission: json["transmission"] ?? "",
      vehicleType: json["vehicleType"],
      driveType4Wd: json["driveType4WD"] ?? "",
      doors: json["doors"] ?? "",
      seats: json["seats"] ?? 0,
      interiorMaterial: json["interiorMaterial"],
      vatDeduction: json["vatDeduction"],
      equipments: json["equipments"],
      power: json["power"],
      color: json["color"],
      specificationDetails: json["specificationDetails"] == null ? null : SpecificationDetails.fromJson(json["specificationDetails"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "transmission": transmission,
    "vehicleType": vehicleType,
    "driveType4WD": driveType4Wd,
    "doors": doors,
    "seats": seats,
    "interiorMaterial": interiorMaterial,
    "vatDeduction": vatDeduction,
    "equipments": equipments,
    "power": power,
    "color": color,
    "specificationDetails": specificationDetails?.toJson(),
  };

}

class SpecificationDetails {
  SpecificationDetails({
    required this.vin,
    required this.tpms,
    required this.make,
    required this.doors,
    required this.model,
    required this.region,
    required this.series,
    required this.country,
    required this.fuelType,
    required this.bodyClass,
    required this.bodyStyle,
    required this.driveType,
    required this.modelYear,
    required this.plantCity,
    required this.trimLevel,
    required this.engineType,
    required this.plantstate,
    required this.cityMileage,
    required this.manufacturer,
    required this.plantCountry,
    required this.steeringType,
    required this.transmission,
    required this.displacementL,
    required this.otherAllWidth,
    required this.overAllHeight,
    required this.overAllLength,
    required this.displacementCc,
    required this.highwayMileage,
    required this.manufacturedIn,
    required this.otherEnginInfo,
    required this.yearIdentifier,
    required this.antiBrakeSystem,
    required this.brakeSystemType,
    required this.fuelTypePrimary,
    required this.standardSeating,
    required this.manufacturerName,
    required this.vehicleDescriptor,
    required this.engineNumberOfClinders,
    required this.grossVehicleWeightRatingFrom,
  });

  final String vin;
  final String tpms;
  final String make;
  final String doors;
  final String model;
  final String region;
  final String series;
  final String country;
  final String fuelType;
  final String bodyClass;
  final String bodyStyle;
  final String driveType;
  final String modelYear;
  final String plantCity;
  final String trimLevel;
  final String engineType;
  final String plantstate;
  final String cityMileage;
  final String manufacturer;
  final String plantCountry;
  final String steeringType;
  final String transmission;
  final String displacementL;
  final String otherAllWidth;
  final String overAllHeight;
  final String overAllLength;
  final String displacementCc;
  final String highwayMileage;
  final String manufacturedIn;
  final String otherEnginInfo;
  final String yearIdentifier;
  final String antiBrakeSystem;
  final String brakeSystemType;
  final String fuelTypePrimary;
  final String standardSeating;
  final String manufacturerName;
  final String vehicleDescriptor;
  final String engineNumberOfClinders;
  final String grossVehicleWeightRatingFrom;

  factory SpecificationDetails.fromJson(Map<String, dynamic> json){
    return SpecificationDetails(
      vin: json["vin"] ?? "",
      tpms: json["TPMS"] ?? "",
      make: json["make"] ?? "",
      doors: json["doors"] ?? "",
      model: json["model"] ?? "",
      region: json["region"] ?? "",
      series: json["series"] ?? "",
      country: json["country"] ?? "",
      fuelType: json["fuelType"] ?? "",
      bodyClass: json["bodyClass"] ?? "",
      bodyStyle: json["bodyStyle"] ?? "",
      driveType: json["driveType"] ?? "",
      modelYear: json["modelYear"] ?? "",
      plantCity: json["plantCity"] ?? "",
      trimLevel: json["trimLevel"] ?? "",
      engineType: json["engineType"] ?? "",
      plantstate: json["plantstate"] ?? "",
      cityMileage: json["cityMileage"] ?? "",
      manufacturer: json["manufacturer"] ?? "",
      plantCountry: json["plantCountry"] ?? "",
      steeringType: json["steeringType"] ?? "",
      transmission: json["transmission"] ?? "",
      displacementL: json["displacementL"] ?? "",
      otherAllWidth: json["otherAllWidth"] ?? "",
      overAllHeight: json["overAllHeight"] ?? "",
      overAllLength: json["overAllLength"] ?? "",
      displacementCc: json["displacementCC"] ?? "",
      highwayMileage: json["highwayMileage"] ?? "",
      manufacturedIn: json["manufacturedIn"] ?? "",
      otherEnginInfo: json["otherEnginInfo"] ?? "",
      yearIdentifier: json["yearIdentifier"] ?? "",
      antiBrakeSystem: json["antiBrakeSystem"] ?? "",
      brakeSystemType: json["brakeSystemType"] ?? "",
      fuelTypePrimary: json["fuelTypePrimary"] ?? "",
      standardSeating: json["standardSeating"] ?? "",
      manufacturerName: json["manufacturerName"] ?? "",
      vehicleDescriptor: json["vehicleDescriptor"] ?? "",
      engineNumberOfClinders: json["engineNumberOfClinders"] ?? "",
      grossVehicleWeightRatingFrom: json["grossVehicleWeightRatingFrom"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
    "vin": vin,
    "TPMS": tpms,
    "make": make,
    "doors": doors,
    "model": model,
    "region": region,
    "series": series,
    "country": country,
    "fuelType": fuelType,
    "bodyClass": bodyClass,
    "bodyStyle": bodyStyle,
    "driveType": driveType,
    "modelYear": modelYear,
    "plantCity": plantCity,
    "trimLevel": trimLevel,
    "engineType": engineType,
    "plantstate": plantstate,
    "cityMileage": cityMileage,
    "manufacturer": manufacturer,
    "plantCountry": plantCountry,
    "steeringType": steeringType,
    "transmission": transmission,
    "displacementL": displacementL,
    "otherAllWidth": otherAllWidth,
    "overAllHeight": overAllHeight,
    "overAllLength": overAllLength,
    "displacementCC": displacementCc,
    "highwayMileage": highwayMileage,
    "manufacturedIn": manufacturedIn,
    "otherEnginInfo": otherEnginInfo,
    "yearIdentifier": yearIdentifier,
    "antiBrakeSystem": antiBrakeSystem,
    "brakeSystemType": brakeSystemType,
    "fuelTypePrimary": fuelTypePrimary,
    "standardSeating": standardSeating,
    "manufacturerName": manufacturerName,
    "vehicleDescriptor": vehicleDescriptor,
    "engineNumberOfClinders": engineNumberOfClinders,
    "grossVehicleWeightRatingFrom": grossVehicleWeightRatingFrom,
  };

}

class Variant {
  Variant({
    required this.id,
    required this.variantName,
    required this.fuelType,
  });

  final int id;
  final String variantName;
  final String fuelType;

  factory Variant.fromJson(Map<String, dynamic> json){
    return Variant(
      id: json["id"] ?? 0,
      variantName: json["variantName"] ?? "",
      fuelType: json["fuelType"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "variantName": variantName,
    "fuelType": fuelType,
  };

}
