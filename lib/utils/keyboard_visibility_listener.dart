import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'package:mon/app/app_manager.dart';
import 'Logger.dart';

class KeyboardVisibilityListener extends StatefulWidget {
  final Widget child;
  final void Function(
      bool isKeyboardVisible,
      double keyboardHeight
      ) listener;

  const KeyboardVisibilityListener({
    Key? key,
    required this.child,
    required this.listener,
  }) : super(key: key);

  @override
  _KeyboardVisibilityListenerState createState() =>
      _KeyboardVisibilityListenerState();
}

class _KeyboardVisibilityListenerState extends State<KeyboardVisibilityListener> with WidgetsBindingObserver {
  var _isKeyboardVisible = false;
  double _keyboardHeight = 0.0;
  final debouncer = Debouncer(delay: const Duration(milliseconds: 50));

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    debouncer.dispose();
    super.dispose();
  }

  // @override
  // void didChangeMetrics() {
  //   final bottomInset = WidgetsBinding.instance!.window.viewInsets.bottom;
  //   final newValue = bottomInset > 0.0;
  //   if (newValue != _isKeyboardVisible) {
  //     _isKeyboardVisible = newValue;
  //     widget.listener(_isKeyboardVisible);
  //   }
  // }

  @override
  void didChangeMetrics() {
    debouncer(() {
      var viewInsets = EdgeInsets.fromWindowPadding(
          WidgetsBinding.instance.window.viewInsets,
          WidgetsBinding.instance.window.devicePixelRatio);
      // Logger.log("viewInsets.bottom ${viewInsets.bottom} ");
      // Logger.log("MediaQuery.of(AppManager.navState.currentContext!).viewPadding.bottom ${MediaQuery.of(AppManager.navState.currentContext!).viewPadding.bottom} ");
      // Logger.log("keyboardHeight ${WidgetsBinding.instance.window.devicePixelRatio} ");
      if((viewInsets.bottom > 230 || viewInsets.bottom < 20 ) && ((viewInsets.bottom - _keyboardHeight).abs() > 10) && _keyboardHeight != 0 && _isKeyboardVisible != viewInsets.bottom > 200) {
        // Logger.log("if");
        var newValue = viewInsets.bottom ;
        if(newValue > 0) {
          newValue = newValue - (Platform.isIOS ? WidgetsBinding.instance.window.padding.bottom : 0);
          if( AppManager.navState.currentContext != null) {
            newValue =  newValue - MediaQuery.of(AppManager.navState.currentContext!).viewPadding.bottom;
          }
        }
        if(newValue.toStringAsFixed(2) != _keyboardHeight.toStringAsFixed(2) && _isKeyboardVisible != viewInsets.bottom > 200) {
          _keyboardHeight = newValue;
          _isKeyboardVisible = viewInsets.bottom > 200;
          widget.listener(_isKeyboardVisible, _keyboardHeight);
        }
      } else {
        // Logger.log("else");
        var newValue = viewInsets.bottom ;
        if(newValue > 0) {
          newValue = newValue - (Platform.isIOS ? WidgetsBinding.instance.window.padding.bottom : 0);
          if( AppManager.navState.currentContext != null) {
            newValue =  newValue - MediaQuery.of(AppManager.navState.currentContext!).viewPadding.bottom;
          }
        }
        // Logger.log("newValue $newValue");
        // Logger.log("_keyboardHeight $_keyboardHeight");
        if(newValue.toStringAsFixed(2) != _keyboardHeight.toStringAsFixed(2) && _keyboardHeight < viewInsets.bottom && _isKeyboardVisible != viewInsets.bottom > 200) {
          _keyboardHeight = newValue;
          _isKeyboardVisible = viewInsets.bottom > 200;
          widget.listener(_isKeyboardVisible, _keyboardHeight);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) => widget.child;
}


class Debouncer {
  final Duration delay;
  Timer? _timer;

  Debouncer({required this.delay});

  void dispose() {
    _timer?.cancel();
    _timer = null;
  }

  void call(void Function() callback) {
    _timer?.cancel();
    _timer = Timer(delay, callback);
  }
}