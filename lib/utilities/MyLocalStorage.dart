import 'dart:convert';

import 'package:euvande/model/response/LoginResponseModel.dart';
import 'package:euvande/utilities/KeyConstants.dart';
import 'package:localstorage/localstorage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefManager {
  static void setLoginData(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(LOCAL_STORAGE_LOGIN_DATA, value);
  }

  static Future<LoginResponseModel?> getLoginData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var result = prefs.getString(LOCAL_STORAGE_LOGIN_DATA);
    return result == null
        ? null
        : LoginResponseModel.fromJson(json.decode(result));
  }

  static void logout() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(LOCAL_STORAGE_LOGIN_DATA);
  }
}
