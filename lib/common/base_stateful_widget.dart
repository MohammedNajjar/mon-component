import 'package:mon/common/base_app_bar.dart';
import 'package:mon/common/widgets/base_mixin.dart';
import 'package:mon/utils/Logger.dart';
import 'package:mon/web_service/request_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class MBStatefulWidget extends StatefulWidget {
  final bool? hideAppBar;
   const MBStatefulWidget({this.hideAppBar, super.key});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}

abstract class MBState<T extends MBStatefulWidget> extends State<T>  with BaseMixin {
  RequestBuilder? requestBuilder = RequestBuilder();
  bool? hideAppBar;

  @override
  void initState() {
    hideAppBar = widget.hideAppBar;
    super.initState();
  }

  @override
  void dispose() {
    requestBuilder = null;
    super.dispose();
  }
}