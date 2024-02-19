// To parse this JSON data, do
//
//     final getUserDetailResponseModel = getUserDetailResponseModelFromJson(jsonString);

import 'dart:convert';

GetUserDetailResponseModel getUserDetailResponseModelFromJson(String str) => GetUserDetailResponseModel.fromJson(json.decode(str));

String getUserDetailResponseModelToJson(GetUserDetailResponseModel data) => json.encode(data.toJson());

class GetUserDetailResponseModel {
  GetUserDetailResponseModel({
    required this.message,
    required this.data,
    required this.statusCode,
  });

  final String message;
  final GetUserDetailData? data;
  final num statusCode;

  factory GetUserDetailResponseModel.fromJson(Map<String, dynamic> json){
    return GetUserDetailResponseModel(
      message: json["message"] ?? "",
      data: json["data"] == null ? null : GetUserDetailData.fromJson(json["data"]),
      statusCode: json["statusCode"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": data?.toJson(),
    "statusCode": statusCode,
  };

}

class GetUserDetailData {
  GetUserDetailData({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNo,
    required this.isPhoneNoVerified,
    required this.countryCode,
    required this.avatar,
    required this.roleName,
    required this.group,
    required this.designation,
    required this.countryName,
  });

  final int id;
   String name;
   String email;
  final String phoneNo;
  final bool isPhoneNoVerified;
  final String countryCode;
  final dynamic avatar;
  final String roleName;
  final String group;
  final dynamic designation;
  final String countryName;

  factory GetUserDetailData.fromJson(Map<String, dynamic> json){
    return GetUserDetailData(
      id: json["id"] ?? 0,
      name: json["name"] ?? "",
      email: json["email"] ?? "",
      phoneNo: json["phoneNo"] ?? "",
      isPhoneNoVerified: json["isPhoneNoVerified"] ?? false,
      countryCode: json["countryCode"] ?? "",
      avatar: json["avatar"],
      roleName: json["roleName"] ?? "",
      group: json["group"] ?? "",
      designation: json["designation"],
      countryName: json["countryName"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "phoneNo": phoneNo,
    "isPhoneNoVerified": isPhoneNoVerified,
    "countryCode": countryCode,
    "avatar": avatar,
    "roleName": roleName,
    "group": group,
    "designation": designation,
    "countryName": countryName,
  };

}
