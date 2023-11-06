import 'package:flutter/material.dart';
import 'package:stirred_app/src/utils/constants/colors.dart';

abstract class AppTheme {
  static ThemeData get light {
    return ThemeData(
      appBarTheme: AppBarTheme (
        elevation: 0, color: Colors.white, iconTheme: IconThemeData(color: Colors.black.withOpacity(0.7))
      ),
      scaffoldBackgroundColor: Colors.white,
      primaryColor: Colors.black,
      splashColor: Colors.transparent,
      fontFamily: 'IBM',
      colorScheme: ColorScheme.fromSwatch().copyWith(primary: Colors.deepOrangeAccent, secondary: Colors.black),
    );
  }
}