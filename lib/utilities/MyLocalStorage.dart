import 'dart:convert';

import 'package:euvande/model/response/LoginResponseModel.dart';
import 'package:euvande/utilities/KeyConstants.dart';
import 'package:localstorage/localstorage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefManager {

  static String? accessToken = "";

  static void setLoginData(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(LOCAL_STORAGE_LOGIN_DATA, value);
  }

  static Future<LoginResponseModel?> getLoginData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var result = prefs.getString(LOCAL_STORAGE_LOGIN_DATA);
    var data =  result == null
        ? null
        : LoginResponseModel.fromJson(json.decode(result));

    accessToken = data == null ? "" : data.data.accessToken;
    return data;
  }

  static void updateAccessToken(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var result = prefs.getString(LOCAL_STORAGE_LOGIN_DATA);
    var data =  result == null
        ? null
        : LoginResponseModel.fromJson(json.decode(result));
    
    if(data != null){
      data.data.accessToken = value;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString(LOCAL_STORAGE_LOGIN_DATA, jsonEncode(data));
    }

    accessToken = value;
  }

  static void logout() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(LOCAL_STORAGE_LOGIN_DATA);
  }
}
