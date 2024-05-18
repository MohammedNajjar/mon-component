import 'package:mon/theme/fonts.dart';
import 'package:mon/utils/Logger.dart';
import 'package:flutter/material.dart';
import 'package:mon/utils/extensions/extensions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'colors.dart';

BottomNavigationBarThemeData createBottomNavigationBarTheme(bool isDarkTheme, BuildContext context) {
  Logger.log('BottomNavigationBar Theme has been changed and isDark = ${isDarkTheme}');
  return const BottomNavigationBarThemeData(
    backgroundColor: AppColors.white,
    elevation: 0,
    selectedIconTheme: IconThemeData(color: AppColors.secondary),
    selectedLabelStyle: TextStyle(color: AppColors.secondary),
    unselectedIconTheme: IconThemeData(color: AppColors.darkGrey),
    showSelectedLabels: true,
    showUnselectedLabels: true,
  );
}
