import 'package:mon/common/base_app_bar.dart';
import 'package:mon/common/widgets/base_mixin.dart';
import 'package:mon/utils/Logger.dart';
import 'package:mon/web_service/request_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class MBStatelessWidget extends StatelessWidget with BaseMixin {
  final bool? hideAppBar;
  const MBStatelessWidget({this.hideAppBar, super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
