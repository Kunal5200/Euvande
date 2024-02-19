// To parse this JSON data, do
//
//     final getFavouriteCarsResponseModel = getFavouriteCarsResponseModelFromJson(jsonString);

import 'dart:convert';

GetFavouriteCarsResponseModel getFavouriteCarsResponseModelFromJson(String str) => GetFavouriteCarsResponseModel.fromJson(json.decode(str));

String getFavouriteCarsResponseModelToJson(GetFavouriteCarsResponseModel data) => json.encode(data.toJson());

class GetFavouriteCarsResponseModel {
  GetFavouriteCarsResponseModel({
    required this.message,
    required this.data,
    required this.statusCode,
  });

  final String message;
  final Data? data;
  final num statusCode;

  factory GetFavouriteCarsResponseModel.fromJson(Map<String, dynamic> json){
    return GetFavouriteCarsResponseModel(
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
    required this.docs,
    required this.hasNextPage,
    required this.hasPrevPage,
    required this.limit,
    required this.page,
    required this.totalDocs,
    required this.totalPages,
  });

  final List<Doc> docs;
  final bool hasNextPage;
  final bool hasPrevPage;
  final num limit;
  final num page;
  final num totalDocs;
  final num totalPages;

  factory Data.fromJson(Map<String, dynamic> json){
    return Data(
      docs: json["docs"] == null ? [] : List<Doc>.from(json["docs"]!.map((x) => Doc.fromJson(x))),
      hasNextPage: json["hasNextPage"] ?? false,
      hasPrevPage: json["hasPrevPage"] ?? false,
      limit: json["limit"] ?? 0,
      page: json["page"] ?? 0,
      totalDocs: json["totalDocs"] ?? 0,
      totalPages: json["totalPages"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    "docs": docs.map((x) => x?.toJson()).toList(),
    "hasNextPage": hasNextPage,
    "hasPrevPage": hasPrevPage,
    "limit": limit,
    "page": page,
    "totalDocs": totalDocs,
    "totalPages": totalPages,
  };

}

class Doc {
  Doc({
    required this.id,
    required this.ownership,
    required this.odometer,
    required this.price,
    required this.status,
    required this.vin,
    required this.createdAt,
    required this.updatedAt,
    required this.make,
    required this.seller,
    required this.model,
    required this.variant,
    required this.specification,
    required this.period,
    required this.media,
    required this.favoriteCars,
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
  final Make? make;
  final Seller? seller;
  final Model? model;
  final Variant? variant;
  final Specification? specification;
  final Period? period;
  final Media? media;
  final List<FavoriteCar> favoriteCars;
  final List<String> carImages;

  factory Doc.fromJson(Map<String, dynamic> json){
    return Doc(
      id: json["id"] ?? 0,
      ownership: json["ownership"] ?? "",
      odometer: json["odometer"] ?? "",
      price: json["price"] ?? 0,
      status: json["status"] ?? "",
      vin: json["vin"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      make: json["make"] == null ? null : Make.fromJson(json["make"]),
      seller: json["seller"] == null ? null : Seller.fromJson(json["seller"]),
      model: json["model"] == null ? null : Model.fromJson(json["model"]),
      variant: json["variant"] == null ? null : Variant.fromJson(json["variant"]),
      specification: json["specification"] == null ? null : Specification.fromJson(json["specification"]),
      period: json["period"] == null ? null : Period.fromJson(json["period"]),
      media: json["media"] == null ? null : Media.fromJson(json["media"]),
      favoriteCars: json["favoriteCars"] == null ? [] : List<FavoriteCar>.from(json["favoriteCars"]!.map((x) => FavoriteCar.fromJson(x))),
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
    "make": make?.toJson(),
    "seller": seller?.toJson(),
    "model": model?.toJson(),
    "variant": variant?.toJson(),
    "specification": specification?.toJson(),
    "period": period?.toJson(),
    "media": media?.toJson(),
    "favoriteCars": favoriteCars.map((x) => x?.toJson()).toList(),
    "carImages": carImages.map((x) => x).toList(),
  };

}

class FavoriteCar {
  FavoriteCar({
    required this.id,
  });

  final int id;

  factory FavoriteCar.fromJson(Map<String, dynamic> json){
    return FavoriteCar(
      id: json["id"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
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
  });

  final String frontView;
  final String frontLeft;
  final String frontRight;

  factory Images.fromJson(Map<String, dynamic> json){
    return Images(
      frontView: json["frontView"] ?? "",
      frontLeft: json["frontLeft"] ?? "",
      frontRight: json["frontRight"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
    "frontView": frontView,
    "frontLeft": frontLeft,
    "frontRight": frontRight,
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
  final dynamic phoneNo;
  final dynamic countryCode;

  factory Seller.fromJson(Map<String, dynamic> json){
    return Seller(
      name: json["name"] ?? "",
      email: json["email"] ?? "",
      phoneNo: json["phoneNo"],
      countryCode: json["countryCode"],
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
  final dynamic equipments;
  final String power;
  final dynamic color;

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
      equipments: json["equipments"],
      power: json["power"] ?? "",
      color: json["color"],
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
