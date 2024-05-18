import 'package:mon/theme/fonts.dart';
import 'package:mon/utils/Logger.dart';
import 'package:flutter/material.dart';
import 'package:mon/utils/extensions/extensions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'colors.dart';

InputDecorationTheme createInputDecorationTheme(bool isDarkTheme, BuildContext context) {
  Logger.log('InputDecoration Theme has been changed and isDark = ${isDarkTheme}');
  const double fontSize = AppFonts.formTextSize;
  const FontWeight fontWeight = AppFonts.black;
  return InputDecorationTheme(
    prefixIconColor: AppColors.indigo_500,
    suffixIconColor: AppColors.indigo_500,
    fillColor: AppColors.white,
    helperStyle: const TextStyle(color: AppColors.indigo_500, fontWeight: fontWeight, fontSize: fontSize),
    suffixStyle: const TextStyle(color: AppColors.indigo_500, fontWeight: fontWeight, fontSize: fontSize),
    floatingLabelStyle: const TextStyle(color: AppColors.indigo_500, fontWeight: fontWeight, fontSize: fontSize),
    errorStyle: TextStyle(
      fontSize:  14.0,
      fontWeight: FontWeight.normal,
      fontFamily: AppFonts.fontFamily,
    ),
    hintStyle: const TextStyle(color: AppColors.grey, fontSize: fontSize),
    labelStyle: const TextStyle(color: AppColors.grey, fontSize: fontSize),
    isDense: true,
    // contentPadding: EdgeInsets.symmetric(vertical: 18.h,horizontal: 5.w),
    // floatingLabelStyle: const TextStyle(color: AppColors.primary),
    focusedBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.indigo2_300),
    ),
    enabledBorder: const OutlineInputBorder(
      borderSide: BorderSide(
        color: AppColors.grey,
      ),
    ),
    disabledBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.grey),
    ),
    focusedErrorBorder: const OutlineInputBorder(
      // borderRadius: BorderRadius.circular(5.r),
      borderSide: BorderSide(
        color: AppColors.red,
        width: 1,
      ),
    ),
    border: const OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.grey),
    ),
    errorBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.red),
    ),
  );
}
