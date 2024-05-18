import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:mon/app/app_manager.dart';
import 'package:flutter/material.dart';
import 'package:mon/theme/fonts.dart';
import 'package:mon/utils/Logger.dart';
import '../user_profile.dart';
import 'colors.dart';
import 'package:intl/intl.dart';
import 'package:mon/web_service/constants.dart';

extension NumExtension on num {
  String get formatLongNumber => NumberFormat('#,##0').format(toInt());
}

extension ImagePathExtension on String {
  String get image_ => 'assets/images/$this';

  Color get color_ => ColorEx.fromHex(this);

  String get withHash => "#$this";

  String get withCurrency =>
      "$this ${AppManager.shared.localization.current_currency}";

  String get formatLongNumber => NumberFormat('#,##0').format(this);

  String get withMediaUrl => "${Constants.mediaURL}$this";

  bool get isUrl {
    try {
      Uri.parse(this);
      return true;
    } on FormatException {
      return false;
    }
  }

  String dateFormat(String? format) {
    return DateFormat(format ?? 'yyyy-MM-dd hh:mm')
        .format(DateTime.parse(this));
  }

  String getFontUri(ByteData data, String mime) {
    final buffer = data.buffer;
    return Uri.dataFromBytes(
        buffer.asUint8List(data.offsetInBytes, data.lengthInBytes),
        mimeType: mime)
        .toString();
  }

  Future<String> addFontToHtml(
      String htmlContent, String fontAssetPath, String fontMime) async {
    final fontData = await rootBundle.load(fontAssetPath);
    final fontUri = getFontUri(fontData, fontMime).toString();
    final fontCss = ''' 
         @font-face {
          font-family: '${AppFonts.fontFamily}-Regular';
          font-weight: normal;
          src: url($fontUri);
        }
        body {
          font-family: '${AppFonts.fontFamily}-Regular' !important;
          font-size: 30pt !important;
          text-align: justify !important; 
          direction: ${UserProfile.shared.isRTL ? "rtl" : "ltr"};
        }
        html { 
          margin: 20pt; 
        }
        ''';
    return '<style>$fontCss</style>$htmlContent';
  }

  Future<Uri> html() async {
    String completeHtml = await addFontToHtml(
        this,
        "${"assets/fonts/${UserProfile.shared.isRTL ? "Arabic" : "English"}"}/${AppFonts.fontFamily}-Regular.ttf",
        "font/opentype");

    Uri htmlUri = Uri.dataFromString(completeHtml,
        mimeType: 'text/html', encoding: Encoding.getByName('utf-8'));
    return htmlUri;
  }
}
