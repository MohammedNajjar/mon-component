import 'package:mon/common/base_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Home extends StatelessWidget {
  static String get id {
    const Type type = Home;
    return '$type';
  }

  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MBScaffold(
        title: "mon",
        body: Center(
          child: Text("mon"),
        ));
  }
}
