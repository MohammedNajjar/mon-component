import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:mon/common/widgets/base_mixin.dart';
import 'package:mon/providers/localization.dart';
import 'package:mon/web_service/constants.dart';

import 'package:mon/common/base_screen.dart';
import 'package:mon/widgets/language/language_widget.dart';

class LanguagesScreen extends StatelessWidget with BaseMixin {

  static String get id {
    const Type type = LanguagesScreen;
    return '$type';
  }

  const LanguagesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MBScaffold(
        title: localization.language,
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: ListView(
            children: Provider.of<Localization>(context,
                listen: true)
                .languages.map((item) => LanguageWidget(object: item)).toList(),
          ),
        ));
  }
}
