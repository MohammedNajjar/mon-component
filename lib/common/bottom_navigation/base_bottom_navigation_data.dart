import 'package:flutter/material.dart';

class BaseBottomNavigationData {

  final Widget screen;

  final Widget? icon;

  final String? title;

  final int? index;

  BaseBottomNavigationData({required this.screen, this.icon, this.title, this.index});

  @override
  String toString() {
    return 'BaseListData(screen: $screen, icon: $icon title: $title, index: $index)';
  }
}
