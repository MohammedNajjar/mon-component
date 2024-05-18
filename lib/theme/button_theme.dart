import 'package:mon/theme/fonts.dart';
import 'package:mon/utils/Logger.dart';
import 'package:flutter/material.dart';
import 'package:mon/utils/extensions/extensions.dart';
import 'colors.dart';

ButtonThemeData createButtonTheme(bool isDarkTheme, BuildContext context) {
  Logger.log('Button Theme has been changed and isDark = ${isDarkTheme}');
  return ButtonThemeData(
    buttonColor: AppColors.primary,     //  <-- dark color
    textTheme: ButtonTextTheme.primary,
    colorScheme:
    Theme.of(context).colorScheme.copyWith(secondary: Colors.white), //  <-- this auto selects the right color
  );
}
