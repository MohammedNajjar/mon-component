import 'package:mon/utils/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:mon/utils/extensions/extensions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppFonts {
  static String get fontFamily {
   return UserProfile.shared.isRTL ? 'Vazirmatn' : 'Nunito';
  }

  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight bold = FontWeight.w700;
  static const FontWeight black = FontWeight.w900;

  // static const double appBarHeight = 70.0;
  // static const double appBarTextSize = 30.0;
  // static const double formHeadingTextSize = 18.0;
  static const double formTextSize = 16.0;
  // static const double buttonTextSize = 18.0;
  // static const double headingTextSize = 24.0;
  // static const double mediumHeadingTextSize = 21.0;
  // static const double smallHeadingTextSize = 18.0;
  // static const double smallerHeadingTextSize = 15.0;
  // static const double tileTitleTextSize = 18.0;
  // static const double floatingActionButtonIconSize = 27.0;

  static double size(double size) {
    return size.sp;
  }

  static double get appBarTitleSize => 24.sp;
  static double get bodyLargeSize => 17.sp;
  static double get bodyMediumSize => 16.sp;
  static double get displayLargeSize => 54.sp;
  static double get displayMediumSize => 44.sp;
  static double get displaySmallSize => 34.sp;
  static double get headlineMediumSize => 30.sp;
  static double get headlineSmallSize => 24.sp;
  static double get titleLargeSize => 20.sp;
  static double get headline7TextSize => 19.sp;
  static double get headline8TextSize => 21.sp;
  static double get labelLargeSize => 20.sp;
  static double get bodySmallSize => 17.sp;
  static double get chipTextSize => 16.sp;
  static double get xSmallTextSize => 16.sp;
  static double get xxSmallTextSize => 15.sp;
  static double get xxxSmallTextSize => 14.sp;
  static double get xxxxSmallTextSize => 12.sp;
  static double get smallTextSize => 18.sp;
  static double get mediumTextSize => 20.sp;
  static double get largeTextSize => 22.sp;
  static double get xLargeTextSize => 24.sp;
  static double get xxxLargeTextSize => 28.sp;
  static double get circleImageRadius => 35.r;

}