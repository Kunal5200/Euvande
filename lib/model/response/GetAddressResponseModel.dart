// To parse this JSON data, do
//
//     final getAddressResponseModel = getAddressResponseModelFromJson(jsonString);

import 'dart:convert';

GetAddressResponseModel getAddressResponseModelFromJson(String str) => GetAddressResponseModel.fromJson(json.decode(str));

String getAddressResponseModelToJson(GetAddressResponseModel data) => json.encode(data.toJson());

class GetAddressResponseModel {
  GetAddressResponseModel({
    required this.message,
    required this.data,
    required this.statusCode,
  });

  final String message;
  final List<GetAddressData> data;
  final num statusCode;

  factory GetAddressResponseModel.fromJson(Map<String, dynamic> json){
    return GetAddressResponseModel(
      message: json["message"] ?? "",
      data: json["data"] == null ? [] : List<GetAddressData>.from(json["data"]!.map((x) => GetAddressData.fromJson(x))),
      statusCode: json["statusCode"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": data.map((x) => x?.toJson()).toList(),
    "statusCode": statusCode,
  };

}

class GetAddressData {
  GetAddressData({
    required this.id,
    required this.createdAt,
    required this.isDefault,
    required this.street,
    required this.houseNo,
    required this.postalCode,
    required this.city,
    required this.country,
    required this.addressType,
  });

  final int id;
  final DateTime? createdAt;
  final bool isDefault;
  final String street;
  final String houseNo;
  final String postalCode;
  final String city;
  final String country;
  final String addressType;

  factory GetAddressData.fromJson(Map<String, dynamic> json){
    return GetAddressData(
      id: json["id"] ?? 0,
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      isDefault: json["isDefault"] ?? false,
      street: json["street"] ?? "",
      houseNo: json["houseNo"] ?? "",
      postalCode: json["postalCode"] ?? "",
      city: json["city"] ?? "",
      country: json["country"] ?? "",
      addressType: json["addressType"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "createdAt": createdAt?.toIso8601String(),
    "isDefault": isDefault,
    "street": street,
    "houseNo": houseNo,
    "postalCode": postalCode,
    "city": city,
    "country": country,
    "addressType": addressType,
  };

}

