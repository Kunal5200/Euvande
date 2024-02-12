// To parse this JSON data, do
//
//     final getPeriodByMakeRequestModel = getPeriodByMakeRequestModelFromJson(jsonString);

import 'dart:convert';

GetPeriodByMakeRequestModel getPeriodByMakeRequestModelFromJson(String str) => GetPeriodByMakeRequestModel.fromJson(json.decode(str));

String getPeriodByMakeRequestModelToJson(GetPeriodByMakeRequestModel data) => json.encode(data.toJson());

class GetPeriodByMakeRequestModel {

  GetPeriodByMakeRequestModel({
    required this.makeId,
  });

  final int makeId;

  factory GetPeriodByMakeRequestModel.fromJson(Map<String, dynamic> json){
    return GetPeriodByMakeRequestModel(
      makeId: json["makeId"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
    "makeId": makeId,
  };

}
