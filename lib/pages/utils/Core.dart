import 'package:dio/dio.dart';
import 'package:ebshop/foundation/foundation.dart';

class Core {
  

}

class RECT{
  static String gateAPI = "http://127.0.0.1:8360/api";
  
  static Future<HttpJsonResult> post(
      String uri,dynamic data) async {
    Response response = await Dio().post("$gateAPI/$uri", data: data);

    return _getHttpJsonResult(response);
  }

  static Future<HttpJsonResult> get(String uri,
      [String id]) async {

    var query;
    if(id!=null){
      query={"id":id};
    }    
    Response response = await Dio().get("$gateAPI/$uri", queryParameters:query);
    return _getHttpJsonResult(response);
  }

  static Future<HttpJsonResult> put(String uri, String id,dynamic data) async {
    Response response = await Dio().put("$gateAPI/$uri", data: {id: id},queryParameters: data);
    return _getHttpJsonResult(response);
  }

  static Future<HttpJsonResult> delete(String uri, String id) async {
    Response response = await Dio().delete("$gateAPI/$uri", data: {"id": id});
    return _getHttpJsonResult(response);
  }

  static HttpJsonResult _getHttpJsonResult(Response response) {
    var result = HttpJsonResult();
    if (response.statusCode == 200) {
    } else {}
    return result;
  }
}

class Constant {
  static final String KEY_GUIDE = "guide";
  static final String KEY_AD = "ad";
  static final String KEY_LOGGED = "logged";
}
