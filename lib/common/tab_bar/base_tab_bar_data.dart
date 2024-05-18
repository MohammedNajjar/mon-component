import 'package:flutter/material.dart';

class BaseTabBarData {

  final Widget body;

  final Widget? icon;

  final String? title;

  final int? index;

  BaseTabBarData({required this.body, this.icon, this.title, this.index});

  @override
  String toString() {
    return 'BaseListData(screen: $body, icon: $icon title: $title, index: $index)';
  }
}
