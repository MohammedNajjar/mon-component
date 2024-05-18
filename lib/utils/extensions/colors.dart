import 'package:flutter/material.dart';
import 'dart:math';

extension ColorEx on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';

  MaterialColor generateMaterialColor() {
    //http://mcg.mbitson.com/#!?mcgpalette0=%2303dac6&mcgpalette1=%2303dac6&themename=03DAC6
    return MaterialColor(value, {
      50: tintColor(0.9),
      100: tintColor(0.8),
      200: tintColor(0.6),
      300: tintColor(0.4),
      400: tintColor(0.2),
      500: this,
      600: shadeColor(0.1),
      700: shadeColor(0.2),
      800: shadeColor(0.3),
      900: shadeColor(0.4),
    });
  }

  Color tintColor(double factor) => Color.fromRGBO(tintValue(red, factor),
      tintValue(green, factor), tintValue(blue, factor), 1);

  Color shadeColor(double factor) => Color.fromRGBO(shadeValue(red, factor),
      shadeValue(green, factor), shadeValue(blue, factor), 1);
}

int tintValue(int value, double factor) =>
    max(0, min((value + ((255 - value) * factor)).round(), 255));

int shadeValue(int value, double factor) =>
    max(0, min(value - (value * factor).round(), 255));
