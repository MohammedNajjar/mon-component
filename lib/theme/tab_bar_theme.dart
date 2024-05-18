import 'package:mon/theme/fonts.dart';
import 'package:mon/utils/Logger.dart';
import 'package:flutter/material.dart';
import 'package:mon/utils/extensions/extensions.dart';
import 'colors.dart';

TabBarTheme createTabBarTheme(bool isDarkTheme, BuildContext context) {
  Logger.log('TabBar Theme has been changed and isDark = ${isDarkTheme}');
  return TabBarTheme(
    labelColor: AppColors.white,
    unselectedLabelColor: AppColors.white,
    // labelStyle: textTheme().headline6,
    // color for text
    // indicator: const UnderlineTabIndicator(
    //   borderSide: BorderSide(color: AppColors.primary),
    // ),
  );
}
