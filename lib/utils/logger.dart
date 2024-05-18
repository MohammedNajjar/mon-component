import 'package:mon/web_service/constants.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'dart:developer' as developer;

class Logger {

  static void log(dynamic data) {
    if(Constants.showLog == false) return;
    if(data == null)  {
      developer.log('null', name: 'MBLogger');
      return;
    }
    developer.log('${data}', name: 'MBLogger');
  }

  static void json(dynamic json) {
    if(Constants.showLog == false) return;
    Logger.log(Logger.beautify(json));
  }

  static String beautify(dynamic json) {
    try {
      if (json == null) {
        return "";
      }
      var spaces = ' ' * 4;
      var encoder = JsonEncoder.withIndent(spaces);
      return encoder.convert(json);
    } catch(e) {
      return "";
    }
  }
}