// To parse this JSON data, do
//
//     final getModelRequestModel = getModelRequestModelFromJson(jsonString);

import 'dart:convert';

GetModelRequestModel getModelRequestModelFromJson(String str) => GetModelRequestModel.fromJson(json.decode(str));

String getModelRequestModelToJson(GetModelRequestModel data) => json.encode(data.toJson());

class GetModelRequestModel {

  GetModelRequestModel({
    required this.makeId,
    required this.periodYear,
  });

  final int makeId;
  final int periodYear;

  factory GetModelRequestModel.fromJson(Map<String, dynamic> json){
    return GetModelRequestModel(
      makeId: json["makeId"] ?? "",
      periodYear: json["periodYear"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
    "makeId": makeId,
    "periodYear": periodYear,
  };

}
