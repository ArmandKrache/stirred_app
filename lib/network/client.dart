import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ttfa/utils/app_config.dart';

Dio createApiClient([BaseOptions? options]) {
  Dio client = Dio();
  client.options.baseUrl = AppConfig.api;
  client.options.headers = {
    // "content-type": "application/json"
    // 'x-speed-string': 'New_spped_string',
    // 'x-api-version': AppConfig.apiVersion,
  };
  return client;
}

class CustomerApi {
  static final Dio _client = createApiClient();

  static Future<bool?> exampleGet(BuildContext context) async {
    try {
      /// SharedPreferences prefs = await SharedPreferences.getInstance();
      /// await verifyAndRefreshToken(prefs, context);
      var res = await _client.get('api/',
          options: Options(headers: {
            /// 'Authorization': "JWT " + prefs.getString("access_token")!
          }));
      if (res.statusCode == 200) {
      /// return ExampleModel.fromJson(res.data['parent']);
      }
    } catch (e) {
      print(e);
      // throw e;
    }
    return false;
  }

  static Future<bool> examplePost(BuildContext context, String data) async {
    /// SharedPreferences prefs = await SharedPreferences.getInstance();
    /// await verifyAndRefreshToken(prefs, context);

    var res = await _client.post('api/post-example/',
        data: {"data": data},
        options: Options(headers: {
          /// 'Authorization': "JWT " + prefs.getString("access_token")!
        }));
    if (res.statusCode == 200) {
      return true;
    }
    return false;
  }

}
