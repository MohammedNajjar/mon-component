import 'package:device_info_plus/device_info_plus.dart';
import 'dart:io';
import 'package:flutter/services.dart';

class DeviceSpecifications {
  static final DeviceSpecifications shared = DeviceSpecifications._internal();

  DeviceSpecifications._internal();

  static final deviceInfo = DeviceInfoPlugin();

  static String? deviceId;
  static String? deviceName;
  static String? deviceModel;
  static String? platformName;
  static String? platformVersion;
  static String? deviceBrand;
  static String? manufacturerName;

  static init() async {
    try {
      if (Platform.isIOS) {
        final IosDeviceInfo iosDeviceInfo = await deviceInfo.iosInfo;
        deviceId = iosDeviceInfo.identifierForVendor;
        deviceName = iosDeviceInfo.name;
        deviceModel = iosDeviceInfo.model;
        platformName = iosDeviceInfo.systemName;
        platformVersion = iosDeviceInfo.systemVersion;
      } else if (Platform.isAndroid) {
        final AndroidDeviceInfo androidDeviceInfo = await deviceInfo.androidInfo;
        deviceId = androidDeviceInfo.id;
        deviceName = androidDeviceInfo.model;
        deviceModel = androidDeviceInfo.device;
        platformVersion = androidDeviceInfo.version.release;
        deviceBrand = androidDeviceInfo.brand;
        manufacturerName = androidDeviceInfo.manufacturer;
        platformName = (androidDeviceInfo.version.baseOS == null ||  androidDeviceInfo.version.baseOS == "") ?  "Android" : androidDeviceInfo.version.baseOS;
      } else if (Platform.isLinux) {
      } else if (Platform.isMacOS) {
      } else if (Platform.isWindows) {}
    } finally {}
  }
}
