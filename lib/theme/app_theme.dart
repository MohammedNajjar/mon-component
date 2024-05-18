import 'package:mon/utils/Logger.dart';
import 'package:flutter/material.dart';
import 'bottom_navigation_bar_theme.dart';
import 'elevated_button_theme.dart';
import 'app_bar_theme.dart';
import 'button_theme.dart';
import 'input_theme.dart';
import 'text_theme.dart';
import 'colors.dart';
import 'fonts.dart';
// Other solutions https://rydmike.com/flexcolorscheme/themesplayground-v6/#/

ThemeData createAppTheme(bool isDarkTheme, BuildContext context) {
  Logger.log('Theme has been changed and isDark = $isDarkTheme');
  return ThemeData(
    colorScheme: ColorScheme.fromSwatch(primarySwatch: AppColors.primary)
        .copyWith(secondary: AppColors.secondary),
    fontFamily: AppFonts.fontFamily,
    textTheme: createTextTheme(isDarkTheme,  context),
    appBarTheme: createAppBarTheme(isDarkTheme, context),
    scaffoldBackgroundColor: AppColors.scaffoldBackground,
    elevatedButtonTheme: createElevatedButtonTheme(isDarkTheme, context),
    buttonTheme: createButtonTheme(isDarkTheme, context),
    bottomNavigationBarTheme: createBottomNavigationBarTheme(isDarkTheme, context),
    inputDecorationTheme: createInputDecorationTheme(isDarkTheme, context),
  );
}
