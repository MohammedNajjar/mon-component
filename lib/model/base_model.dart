import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'dart:io';

import '../utils/user_profile.dart';
import '../web_service/device_information.dart';

class BaseModel {
  static final BaseModel shared = BaseModel._internal();

  BaseModel._internal();

  factory BaseModel() {
    return shared;
  }

  Map<String, dynamic> get headers {
    return {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptHeader: 'application/json',
      'X-Client-Language': UserProfile.shared.currentLanguage,
      'authorization': UserProfile.shared.accessToken,
      "Access-Control-Allow-Credentials": true,
      "Access-Control-Allow-Origin": "*",
      "Access-Control-Allow-Headers": "*",
      "Access-Control-Allow-Methods": "*",
      'X-Client-FCM-Token': UserProfile.shared.fcmToken,
      'X-Client-Device-UDID': DeviceSpecifications.deviceId,
      'X-Client-Device-Name': DeviceSpecifications.deviceName,
      'X-Client-Device-Type': DeviceSpecifications.manufacturerName,
      'X-Client-Platform-Name': Platform.isAndroid ? 'android' : "ios",
      'X-Client-Platform-Version': DeviceSpecifications.platformVersion,
    };
  }

}
