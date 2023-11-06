import 'package:flutter/material.dart';

const commonColor = Color(0xff319236);
const unusualColor = Color(0xff4c51f7);
const rareColor = Color(0xff9d4dbb);
const epicColor = Color(0xfff3af19);
const legendaryColor = Color(0xffff033e);

final MaterialColor primarySwatch = materialColorFromRGB(80, 103, 238);

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
      '0x${a.toRadixString(16)}${r.toRadixString(16)}${g.toRadixString(16)}${b
          .toRadixString(16)}');
}