import 'package:flutter/material.dart';
import 'package:mon/common/widgets/base_mixin.dart';

class AppManager with BaseMixin {
  static final AppManager shared = AppManager._internal();
  AppManager._internal();
  static final GlobalKey<NavigatorState> navState = GlobalKey<NavigatorState>();
}