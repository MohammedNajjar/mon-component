import 'dart:io';

import 'package:mon/web_service/constants.dart';

enum HttpMethods { get, post, put, delete, patch }

extension HttpMethodsEx on HttpMethods {
  String get value {
    switch (this) {
      case HttpMethods.get:
        return 'GET';
      case HttpMethods.post:
        return 'POST';
      case HttpMethods.delete:
        return 'DELETE';
      case HttpMethods.put:
        return 'PUT';
      case HttpMethods.patch:
        return 'PATCH';
    }
  }
}

abstract class BaseRequest {

  String? baseUrl;

  String get url;

  Map<String, dynamic> get params;

  Map<String, dynamic> additionalHeaders = {};

  HttpMethods get type;

  List<BaseRequestFile> get files;

  bool isSendRequestInMultipart = false;

  int timeoutInterval = 15000;
}

class BaseRequestFile {
  File? data;
  String parameterName = "";
  String fileName = "";
  String mimiType = "";

  BaseRequestFile({
    required data,
    required parameterName,
    required fileName,
    required mimiType,
  });
}
