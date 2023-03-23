import 'dart:convert';
import 'package:flutter/services.dart';

class AppConfig {
  static late String api;

  static Future<void> load() async {
    final contents = await rootBundle.loadString(
      "config.json",
    );

    final json = jsonDecode(contents);
    api = json["api"];
  }
}
