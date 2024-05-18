import 'package:mon/theme/fonts.dart';
import 'package:mon/utils/Logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mon/utils/extensions/extensions.dart';
import 'colors.dart';

AppBarTheme createAppBarTheme(bool isDarkTheme, BuildContext context) {
  Logger.log('App Bar Theme has been changed and isDark = ${isDarkTheme}');
  return AppBarTheme(
      backgroundColor: AppColors.appBarBackground,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: AppColors.appBarBackground.tintColor(0.2), // <-- SEE HERE
        // statusBarIconBrightness: Brightness.dark, //<-- For Android SEE HERE (dark icons)
        // statusBarBrightness: Brightness.light, //<-- For iOS SEE HERE (dark icons)
      ),
      iconTheme: IconThemeData(color: AppColors.appBarIcon),
      titleTextStyle: TextStyle(color: AppColors.appBarTitle,  fontFamily: AppFonts.fontFamily, fontWeight: FontWeight.bold,
  fontSize: AppFonts.smallTextSize));
}
