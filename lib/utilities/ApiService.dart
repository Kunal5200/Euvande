import 'dart:convert';
import 'dart:developer';

import 'package:euvande/model/request/LoginRequestModel.dart';
import 'package:euvande/model/request/RegisterRequestModel.dart';
import 'package:euvande/model/request/VerifyRequestModel.dart';
import 'package:euvande/model/response/LoginResponseModel.dart';
import 'package:euvande/model/response/RegisterResponseModel.dart';
import 'package:euvande/model/response/UserModel.dart';
import 'package:euvande/model/response/VerifyResponseModel.dart';
import 'package:euvande/utilities/ApiConstants.dart';
import 'package:euvande/utilities/LoggerInterceptor.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

class ApiService {
  final dio = Dio()..interceptors.addAll([
    LoggerInterceptor(), //custom logger interceptor.
  ]);

  final option = Options(headers: {
    Headers.contentTypeHeader: Headers.jsonContentType,
    // "Authorization":"Bearer ${token}",
  });

  Future<RegisterResponseModel> register(
      RegisterRequestModel loginOrRegisterRequestModel) async {
    Response response = await dio
        .post(ApiConstants.baseUrl + ApiConstants.register, options: option,
        data: loginOrRegisterRequestModel);
    print(response);
    if (response.statusCode == 200) {
      return RegisterResponseModel.fromJson(response.data);
    } else {
      return Future.error(
          "{'code' : '${response.statusCode}', 'message' : '${response.statusMessage}'}"
      );
    }
  }

  Future<VerifyResponseModel> verify(
      VerifyRequestModel verifyRequestModel) async {
    Response response = await dio.post(
        ApiConstants.baseUrl + ApiConstants.verify,
        options: option,
        data: verifyRequestModel);
    if (response.statusCode == 200) {
      return VerifyResponseModel.fromJson(response.data);
    } else {
      return Future.error(
          "{'code' : '${response.statusCode}', 'message' : '${response.statusMessage}'}");
    }
  }

  Future<LoginResponseModel> login(LoginRequestModel loginRequestModel) async {
    Response response = await dio.post(
        ApiConstants.baseUrl + ApiConstants.login,
        options: option,
        data: loginRequestModel);
    if (response.statusCode == 200) {
      return LoginResponseModel.fromJson(jsonDecode(jsonEncode(response.data)));
    } else {
      return Future.error(
          "{'code' : '${response.statusCode}', 'message' : '${response.statusMessage}'}");
    }
  }

  Future<RegisterResponseModel> forgotPassword(RegisterRequestModel registerRequestModel) async {
    Response response = await dio.post(
        ApiConstants.baseUrl + ApiConstants.forgotPassword,
        options: option,
        data: registerRequestModel);

    if (response.statusCode == 200) {
      return RegisterResponseModel.fromJson(jsonDecode(jsonEncode(response.data)));
    } else {
      return Future.error(
          "{'code' : '${response.statusCode}', 'message' : '${response.statusMessage}'}");
    }
  }

}
