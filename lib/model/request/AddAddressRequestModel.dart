// To parse this JSON data, do
//
//     final addAddressRequestModel = addAddressRequestModelFromJson(jsonString);

import 'dart:convert';

AddAddressRequestModel addAddressRequestModelFromJson(String str) => AddAddressRequestModel.fromJson(json.decode(str));

String addAddressRequestModelToJson(AddAddressRequestModel data) => json.encode(data.toJson());

class AddAddressRequestModel {
  AddAddressRequestModel({
    required this.addressType,
    required this.city,
    required this.country,
    required this.houseNo,
    required this.isDefault,
    required this.postalCode,
    required this.street,
  });

  final String addressType;
  final String city;
  final String country;
  final String houseNo;
  final bool isDefault;
  final String postalCode;
  final String street;

  factory AddAddressRequestModel.fromJson(Map<String, dynamic> json){
    return AddAddressRequestModel(
      addressType: json["addressType"] ?? "",
      city: json["city"] ?? "",
      country: json["country"] ?? "",
      houseNo: json["houseNo"] ?? "",
      isDefault: json["isDefault"] ?? false,
      postalCode: json["postalCode"] ?? "",
      street: json["street"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
    "addressType": addressType,
    "city": city,
    "country": country,
    "houseNo": houseNo,
    "isDefault": isDefault,
    "postalCode": postalCode,
    "street": street,
  };

}
