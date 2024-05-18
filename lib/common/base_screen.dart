import 'package:mon/common/base_app_bar.dart';
import 'package:mon/utils/Logger.dart';
import 'package:flutter/material.dart';

class MBScaffold extends StatelessWidget {
  final Widget? body;
  final Widget? rawBody;
  final String? title;
  final AppBar? appBar;
  final Widget? floatingActionButton;
  final Widget? drawer;
  final List<Widget>? actions;
  final bool? scrollable;
  final bool? resizeToAvoidBottomInset;
  final bool? hideAppBar;
  final Color? backgroundColor;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final Widget? bottomNavigationBar;

  const MBScaffold(
      { required this.title,
        required this.body,
        this.appBar,
        this.floatingActionButton,
        this.actions,
        this.rawBody,
        this.drawer,
        this.hideAppBar,
        this.scrollable,
        this.bottomNavigationBar,
        this.backgroundColor,
        this.resizeToAvoidBottomInset = false,
        this.floatingActionButtonLocation,
        Key? key })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Logger.log("${title ?? runtimeType ?? 'Screen'} is rebuild;");
    return Scaffold(
      appBar: !(hideAppBar ?? false) ? (appBar ?? MBAppBar(title: title ?? "", actions: actions ?? [])) : null,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      drawer: drawer,
      floatingActionButtonLocation: floatingActionButtonLocation,
      backgroundColor: backgroundColor,
      bottomNavigationBar: bottomNavigationBar,
      body: rawBody ?? SafeArea(
        child: scrollable == true ? SingleChildScrollView(child: body ?? const Placeholder(),) : (body ?? const Placeholder()),
      ),
      floatingActionButton: floatingActionButton,
    );
  }
}
