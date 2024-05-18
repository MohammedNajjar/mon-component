import 'package:mon/theme/fonts.dart';
import 'package:mon/utils/Logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mon/utils/extensions/extensions.dart';
import 'colors.dart';

ElevatedButtonThemeData createElevatedButtonTheme(bool isDarkTheme, BuildContext context) {
  Logger.log('Elevated Button Theme has been changed and isDark = ${isDarkTheme}');
  return ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(AppColors.primaryColor,), //button color
      foregroundColor: MaterialStateProperty.all(AppColors.white,), //text (and icon)
    ),
  );
}
