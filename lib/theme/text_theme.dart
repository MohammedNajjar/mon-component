import 'package:mon/theme/colors.dart';
import 'package:mon/utils/Logger.dart';
import 'package:flutter/material.dart';
import 'fonts.dart';

TextTheme createTextTheme(bool isDarkTheme, BuildContext context) {
  Logger.log('Text has been changed and isDark = ${isDarkTheme}');
  //https://www.didierboelens.com/2020/05/material-textstyle-texttheme/
  return TextTheme(
    labelLarge: TextStyle(
      fontFamily: AppFonts.fontFamily,
      // fontSize: AppFonts.labelLargeSize,
      fontSize: AppFonts.bodyMediumSize,
    ),
    bodyLarge: TextStyle(
      fontFamily: AppFonts.fontFamily,
      fontSize: AppFonts.bodyLargeSize,
      fontWeight: AppFonts.medium,
    ),
    bodyMedium: TextStyle(
      fontFamily: AppFonts.fontFamily,
      fontSize: AppFonts.bodyMediumSize,
    ),
    displayLarge: TextStyle(
      fontFamily: AppFonts.fontFamily,
      fontSize: AppFonts.displayLargeSize,
      fontWeight: AppFonts.bold,
    ),
    displayMedium: TextStyle(
      fontFamily: AppFonts.fontFamily,
      fontSize: AppFonts.displayMediumSize,
      fontWeight: AppFonts.bold,
    ),
    displaySmall: TextStyle(
      fontFamily: AppFonts.fontFamily,
      fontSize: AppFonts.displaySmallSize,
      fontWeight: AppFonts.bold,
    ),
    headlineMedium: TextStyle(
      fontFamily: AppFonts.fontFamily,
      fontSize: AppFonts.headlineMediumSize,
      fontWeight: AppFonts.bold,
      color: AppColors.primary,
    ),
    headlineSmall: TextStyle(
      fontFamily: AppFonts.fontFamily,
      fontSize: AppFonts.headlineSmallSize,
      fontWeight: AppFonts.bold,
    ),
    titleLarge: TextStyle(
      fontFamily: AppFonts.fontFamily,
      fontSize: AppFonts.titleLargeSize,
      fontWeight: AppFonts.medium,
    ),
    bodySmall: TextStyle(
      fontFamily: AppFonts.fontFamily,
      fontSize: AppFonts.bodySmallSize,
    ),
  );
}
