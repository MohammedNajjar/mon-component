import 'package:flutter/material.dart';

class BaseImageViewerData {

  dynamic object;

  String? url;

  Image? image;

  int id = DateTime.now().millisecond;

  BaseImageViewerData({this.object, this.url});

  @override
  String toString() {
    return 'BaseImageViewerData(object: $object, url: $url)';
  }
}
