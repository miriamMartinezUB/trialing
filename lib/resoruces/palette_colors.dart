import 'package:flutter/material.dart';

class PaletteColors {
  Color primary = const Color(0xff242767);
  Color secondary = const Color(0xffE9F3FE);
  Color active = const Color(0xff3066A9);
  late Color shadow;
  late Color textButton;
  late Color icons;
  late Color textAppBar;
  late Color background;
  late Color text;
  late Color textSubtitle;
  late Color card;
}

class PaletteColorsLight extends PaletteColors {
  PaletteColorsLight() {
    textButton = const Color(0xffffffff);
    icons = const Color(0xffffffff);
    textAppBar = const Color(0xffffffff);
    background = const Color(0xfffbf7ee);
    text = const Color(0xff242e37);
    textSubtitle = const Color(0xff3f484f);
    card = const Color(0xffffffff);
    shadow = Colors.grey.shade300;
  }
}

class PaletteColorsDark extends PaletteColors {
  PaletteColorsDark() {
    textButton = const Color(0xff242e37);
    icons = const Color(0xff242e37);
    textAppBar = const Color(0xff242e37);
    background = const Color(0xff242e37);
    text = const Color(0xfff3edf5);
    textSubtitle = const Color.fromRGBO(243, 237, 245, .6);
    card = const Color(0xff3f484f);
    shadow = const Color(0xff3f484f).withOpacity(0.4);
  }
}

class PaletteMaterialColors {
  static const MaterialColor primary = MaterialColor(0xff242767, {
    50: Color.fromRGBO(36, 39, 103, .1),
    100: Color.fromRGBO(36, 39, 103, .2),
    200: Color.fromRGBO(36, 39, 103, .3),
    300: Color.fromRGBO(36, 39, 103, .4),
    400: Color.fromRGBO(36, 39, 103, .5),
    500: Color.fromRGBO(36, 39, 103, .6),
    600: Color.fromRGBO(36, 39, 103, .7),
    700: Color.fromRGBO(36, 39, 103, .8),
  });
}
