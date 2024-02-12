// To parse this JSON data, do
//
//     final editAddressRequestModel = editAddressRequestModelFromJson(jsonString);

import 'dart:convert';

EditAddressRequestModel editAddressRequestModelFromJson(String str) => EditAddressRequestModel.fromJson(json.decode(str));

String editAddressRequestModelToJson(EditAddressRequestModel data) => json.encode(data.toJson());

class EditAddressRequestModel {
  EditAddressRequestModel({
    required this.id,
    required this.addressType,
    required this.city,
    required this.country,
    required this.houseNo,
    required this.isDefault,
    required this.postalCode,
    required this.street,
  });

  final int id;
  final String addressType;
  final String city;
  final String country;
  final String houseNo;
  bool isDefault;
  final String postalCode;
  final String street;

  factory EditAddressRequestModel.fromJson(Map<String, dynamic> json){
    return EditAddressRequestModel(
      id: json["id"] ?? 0,
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
    "id": id,
    "addressType": addressType,
    "city": city,
    "country": country,
    "houseNo": houseNo,
    "isDefault": isDefault,
    "postalCode": postalCode,
    "street": street,
  };

}
