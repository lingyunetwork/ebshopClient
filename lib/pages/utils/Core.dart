import 'dart:io';

import 'package:dio/dio.dart';
import 'package:ebshop/foundation/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Core {
  static BuildContext mainContext;
  static SharedPreferences sharedPreferences;


  static logout(){
    RECT.setToken("");
    sharedPreferences.remove(Constant.KEY_LOGGED);
    sharedPreferences.remove(Constant.KEY_TOKEN);
    sharedPreferences.reload();
  }
  static void login(dynamic value) {
    var token=value["token"];
    RECT.setToken(token);
    sharedPreferences.setBool(Constant.KEY_LOGGED, true);
    sharedPreferences.setString(Constant.KEY_TOKEN, token);
  }
}

class RECT {
  static String gateAPI = "http://127.0.0.1:8360/api";
  static String _token = "";

  static setToken(String value){
    _token=value;
  }

  static Future<HttpJsonResult> post(String uri, dynamic data) async {
    Response response = await getDio().post("$gateAPI/$uri", data: data);

    return _getHttpJsonResult(response);
  }

  static Dio getDio() {
    var dio = Dio();
    dio.options.headers = {
      HttpHeaders.userAgentHeader: 'dio',
      'Content-Type': 'application/json',
      'Lingyu-Token': _token
    };
    return dio;
  }

  static Future<HttpJsonResult> get(String uri, [String id]) async {
    var query;
    if (id != null) {
      query = {"id": id};
    }
    Response response =
        await getDio().get("$gateAPI/$uri", queryParameters: query);
    return _getHttpJsonResult(response);
  }

  static Future<HttpJsonResult> put(String uri, String id, dynamic data) async {
    Response response = await getDio()
        .put("$gateAPI/$uri", data: {id: id}, queryParameters: data);
    return _getHttpJsonResult(response);
  }

  static Future<HttpJsonResult> delete(String uri, String id) async {
    Response response =
        await getDio().delete("$gateAPI/$uri", data: {"id": id});
    return _getHttpJsonResult(response);
  }

  static HttpJsonResult _getHttpJsonResult(Response response) {
    var result = HttpJsonResult();
    if (response.statusCode == 200) {
      var code = response.data["errno"];
      result.success = code == 0;
      result.code = code;

      if (result.success) {
        result.data = response.data["data"];
      } else {
        var message = response.data["errmsg"];
        result.data = message;
      }
    } else {}
    return result;
  }
}

class Constant {
  static final String KEY_GUIDE = "guide";
  static final String KEY_AD = "ad";
  static final String KEY_LOGGED = "logged";

  static String KEY_TOKEN;
}
