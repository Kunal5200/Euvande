// To parse this JSON data, do
//
//     final getPendingCarsResponseModel = getPendingCarsResponseModelFromJson(jsonString);

import 'dart:convert';

GetPendingCarsResponseModel getPendingCarsResponseModelFromJson(String str) => GetPendingCarsResponseModel.fromJson(json.decode(str));

String getPendingCarsResponseModelToJson(GetPendingCarsResponseModel data) => json.encode(data.toJson());

class GetPendingCarsResponseModel {
  GetPendingCarsResponseModel({
    required this.message,
    required this.data,
    required this.statusCode,
  });

  final String message;
  final List<GetPendingCarsData> data;
  final num statusCode;

  factory GetPendingCarsResponseModel.fromJson(Map<String, dynamic> json){
    return GetPendingCarsResponseModel(
      message: json["message"] ?? "",
      data: json["data"] == null ? [] : List<GetPendingCarsData>.from(json["data"]!.map((x) => GetPendingCarsData.fromJson(x))),
      statusCode: json["statusCode"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": data.map((x) => x?.toJson()).toList(),
    "statusCode": statusCode,
  };

}

class GetPendingCarsData {
  GetPendingCarsData({
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
    required this.make,
    required this.seller,
    required this.model,
    required this.variant,
    required this.specification,
    required this.period,
    required this.media,
    required this.carImages,
  });

  final int id;
  final String ownership;
  final String odometer;
  final num price;
  final String status;
  final dynamic vin;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final ContactInfo? contactInfo;
  final Location? location;
  final Make? make;
  final Seller? seller;
  final Model? model;
  final Variant? variant;
  final Specification? specification;
  final Period? period;
  final Media? media;
  final List<String> carImages;

  factory GetPendingCarsData.fromJson(Map<String, dynamic> json){
    return GetPendingCarsData(
      id: json["id"] ?? 0,
      ownership: json["ownership"] ?? "",
      odometer: json["odometer"] ?? "",
      price: json["price"] ?? 0,
      status: json["status"] ?? "",
      vin: json["vin"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      contactInfo: json["contactInfo"] == null ? null : ContactInfo.fromJson(json["contactInfo"]),
      location: json["location"] == null ? null : Location.fromJson(json["location"]),
      make: json["make"] == null ? null : Make.fromJson(json["make"]),
      seller: json["seller"] == null ? null : Seller.fromJson(json["seller"]),
      model: json["model"] == null ? null : Model.fromJson(json["model"]),
      variant: json["variant"] == null ? null : Variant.fromJson(json["variant"]),
      specification: json["specification"] == null ? null : Specification.fromJson(json["specification"]),
      period: json["period"] == null ? null : Period.fromJson(json["period"]),
      media: json["media"] == null ? null : Media.fromJson(json["media"]),
      carImages: json["carImages"] == null ? [] : List<String>.from(json["carImages"]!.map((x) => x)),
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
    "contactInfo": contactInfo?.toJson(),
    "location": location?.toJson(),
    "make": make?.toJson(),
    "seller": seller?.toJson(),
    "model": model?.toJson(),
    "variant": variant?.toJson(),
    "specification": specification?.toJson(),
    "period": period?.toJson(),
    "media": media?.toJson(),
    "carImages": carImages.map((x) => x).toList(),
  };

}

class ContactInfo {
  ContactInfo({
    required this.name,
    required this.phoneNo,
    required this.zipCode,
    required this.contactInfoPhoneNo,
    required this.countryCode,
    required this.countryName,
  });

  final dynamic name;
  final String phoneNo;
  final String zipCode;
  final String contactInfoPhoneNo;
  final String countryCode;
  final String countryName;

  factory ContactInfo.fromJson(Map<String, dynamic> json){
    return ContactInfo(
      name: json["name"],
      phoneNo: json["phoneNO"] ?? "",
      zipCode: json["zipCode"] ?? "",
      contactInfoPhoneNo: json["phoneNo"] ?? "",
      countryCode: json["countryCode"] ?? "",
      countryName: json["countryName"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
    "name": name,
    "phoneNO": phoneNo,
    "zipCode": zipCode,
    "phoneNo": contactInfoPhoneNo,
    "countryCode": countryCode,
    "countryName": countryName,
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

class Media {
  Media({
    required this.id,
    required this.images,
    required this.videos,
  });

  final int id;
  final Images? images;
  final dynamic videos;

  factory Media.fromJson(Map<String, dynamic> json){
    return Media(
      id: json["id"] ?? 0,
      images: json["images"] == null ? null : Images.fromJson(json["images"]),
      videos: json["videos"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "images": images?.toJson(),
    "videos": videos,
  };

}

class Images {
  Images({
    required this.frontView,
    required this.frontLeft,
    required this.frontRight,
    required this.rearView,
    required this.rearLeft,
    required this.headlamp,
    required this.engine,
    required this.driverDoor,
    required this.driverSeat,
    required this.passengerSeat,
    required this.instrumentPanel,
    required this.dashboard,
    required this.rearPanelOfCenterConsole,
    required this.rearSeat,
    required this.headlining,
    required this.rearRight,
  });

  final String frontView;
  final String frontLeft;
  final String frontRight;
  final String rearView;
  final String rearLeft;
  final String headlamp;
  final String engine;
  final String driverDoor;
  final String driverSeat;
  final String passengerSeat;
  final String instrumentPanel;
  final String dashboard;
  final String rearPanelOfCenterConsole;
  final String rearSeat;
  final String headlining;
  final String rearRight;

  factory Images.fromJson(Map<String, dynamic> json){
    return Images(
      frontView: json["frontView"] ?? "",
      frontLeft: json["frontLeft"] ?? "",
      frontRight: json["frontRight"] ?? "",
      rearView: json["rearView"] ?? "",
      rearLeft: json["rearLeft"] ?? "",
      headlamp: json["headlamp"] ?? "",
      engine: json["engine"] ?? "",
      driverDoor: json["driverDoor"] ?? "",
      driverSeat: json["driverSeat"] ?? "",
      passengerSeat: json["passengerSeat"] ?? "",
      instrumentPanel: json["instrumentPanel"] ?? "",
      dashboard: json["dashboard"] ?? "",
      rearPanelOfCenterConsole: json["rearPanelOfCenterConsole"] ?? "",
      rearSeat: json["rearSeat"] ?? "",
      headlining: json["Headlining"] ?? "",
      rearRight: json["rearRight"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
    "frontView": frontView,
    "frontLeft": frontLeft,
    "frontRight": frontRight,
    "rearView": rearView,
    "rearLeft": rearLeft,
    "headlamp": headlamp,
    "engine": engine,
    "driverDoor": driverDoor,
    "driverSeat": driverSeat,
    "passengerSeat": passengerSeat,
    "instrumentPanel": instrumentPanel,
    "dashboard": dashboard,
    "rearPanelOfCenterConsole": rearPanelOfCenterConsole,
    "rearSeat": rearSeat,
    "Headlining": headlining,
    "rearRight": rearRight,
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

class Seller {
  Seller({
    required this.name,
    required this.email,
    required this.phoneNo,
    required this.countryCode,
  });

  final String name;
  final String email;
  final String phoneNo;
  final String countryCode;

  factory Seller.fromJson(Map<String, dynamic> json){
    return Seller(
      name: json["name"] ?? "",
      email: json["email"] ?? "",
      phoneNo: json["phoneNo"] ?? "",
      countryCode: json["countryCode"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
    "name": name,
    "email": email,
    "phoneNo": phoneNo,
    "countryCode": countryCode,
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
  });

  final int id;
  final String transmission;
  final String vehicleType;
  final String driveType4Wd;
  final String doors;
  final num seats;
  final String interiorMaterial;
  final String vatDeduction;
  final List<String> equipments;
  final String power;
  final String color;

  factory Specification.fromJson(Map<String, dynamic> json){
    return Specification(
      id: json["id"] ?? 0,
      transmission: json["transmission"] ?? "",
      vehicleType: json["vehicleType"] ?? "",
      driveType4Wd: json["driveType4WD"] ?? "",
      doors: json["doors"] ?? "",
      seats: json["seats"] ?? 0,
      interiorMaterial: json["interiorMaterial"] ?? "",
      vatDeduction: json["vatDeduction"] ?? "",
      equipments: json["equipments"] == null ? [] : List<String>.from(json["equipments"]!.map((x) => x)),
      power: json["power"] ?? "",
      color: json["color"] ?? "",
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
    "equipments": equipments.map((x) => x).toList(),
    "power": power,
    "color": color,
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
