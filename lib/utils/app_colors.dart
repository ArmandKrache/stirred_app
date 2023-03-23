import 'package:flutter/material.dart';

class AppColors {
  static final MaterialColor primarySwatch =
  materialColorFromRGB(240, 223, 156);

  static const Color grad100 = Color(0xFFF0DF9C);
  static const Color grad200 = Color(0xFFD8CE94);
  static const Color grad300 = Color(0xFFBFBD8C);
  static const Color grad400 = Color(0xFFA6AC84);
  static const Color grad500 = Color(0xFF8D9A7B);
  static const Color grad600 = Color(0xFF748973);
  static const Color grad700 = Color(0xFF5B776B);
  static const Color grad800 = Color(0xFF426663);
  static const Color grad900 = Color(0xFF29545A);



  static const Color primary = grad100;
  static const Color variant = grad600;
  static const Color secondary = grad900;

  static const Color onPrimary = black;
  static const Color onSecondary = white;
  static const Color background = gray50;
  static const Color surface = white;
  static const Color lightSurface = white;

  static const Color gray50 = Color(0xFFECE8D4);
  static const Color gray100 = Color(0xFFD4D3C1);
  static const Color gray200 = Color(0xFFBDBDAE);
  static const Color gray300 = Color(0xFFA5A89B);
  static const Color gray400 = Color(0xFF8D9288);
  static const Color gray500 = Color(0xFF767D75);
  static const Color gray600 = Color(0xFF5E6762);
  static const Color gray700 = Color(0xFF46524F);
  static const Color gray800 = Color(0xFF2F3C3C);
  static const Color gray900 = Color(0xFF172729);


  static const Color disabledElement = gray700;
  static const Color disabledOnSurface = gray400;
  static const Color disabledOnBackground = gray400;
  static const Color grayBackground = gray200;

  static const Color onBackground = black;
  static const Color onSurface = black;
  static const Color onDarkSurface = black;
  static const Color onDisabled = gray800;
  static const Color shadowColor = black;

  static const Color secondaryText = gray400;
  static const Color lightShadow = gray500;

  static const Color alert = Color(0xFFFF3741);
  static const Color success = Color(0xFF44e868);
  static const Color tip = Color(0xFF0035F5);

  static const Color grad1 = Color(0xFF6372EE);
  static const Color grad2 = Color(0xFF767DEE);
  static const Color grad3 = Color(0xFF8988EE);

  static const Color light = Color(0xFFB8B8FF);

  static final List<Color> gradientChartColors = [
    variant,
    primary,
  ];

  /// Main gradient

  static const List<Color> primaryToVariantGradient = [
    primary,
    grad1,
    grad2,
    grad3,
    variant
  ];
  static const List<Color> variantToPrimaryGradient = [
    variant,
    grad3,
    grad2,
    grad1,
    primary
  ];

  static const LinearGradient customMainGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: AppColors.primaryToVariantGradient,
  );


  static const Color white = Colors.white;
  static const Color black = Color(0xFF0e101b);


  /// rarity colors

  static const Color common = gray400;
  static const Color uncommon = Color(0xFF319236);
  static const Color rare = Color(0xFF4c51f7);
  static const Color epic = Color(0xFF9d4dbb);
  static const Color legendary = Color(0xFFf3af19);

  static const List<Color> rarityList = [
    common,
    uncommon,
    rare,
    epic,
    legendary
  ];

  static const Color transparent = Colors.transparent;
}

/// Functions used to build our primarySwatch ( MaterialColor() ) from r, g, b values
MaterialColor materialColorFromRGB(int r, int g, int b) {
  Map<int, Color> swatch = {
    50: Color.fromRGBO(r, g, b, .1),
    100: Color.fromRGBO(r, g, b, .2),
    200: Color.fromRGBO(r, g, b, .3),
    300: Color.fromRGBO(r, g, b, .4),
    400: Color.fromRGBO(r, g, b, .5),
    500: Color.fromRGBO(r, g, b, .6),
    600: Color.fromRGBO(r, g, b, .7),
    700: Color.fromRGBO(r, g, b, .8),
    800: Color.fromRGBO(r, g, b, .9),
    900: Color.fromRGBO(r, g, b, 1),
  };
  return MaterialColor(hexOfRGBA(r, g, b), swatch);
}

int hexOfRGBA(int r, int g, int b, {double opacity = 1}) {
  r = (r < 0) ? -r : r;
  g = (g < 0) ? -g : g;
  b = (b < 0) ? -b : b;
  opacity = (opacity < 0) ? -opacity : opacity;
  opacity = (opacity > 1) ? 255 : opacity * 255;
  r = (r > 255) ? 255 : r;
  g = (g > 255) ? 255 : g;
  b = (b > 255) ? 255 : b;
  int a = opacity.toInt();
  return int.parse(
      '0x${a.toRadixString(16)}${r.toRadixString(16)}${g.toRadixString(16)}${b.toRadixString(16)}');
}
