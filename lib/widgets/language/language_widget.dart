import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:mon/common/base_image.dart';
import 'package:mon/utils/extensions/extensions.dart';
import 'package:mon/web_service/constants.dart';

import 'package:mon/common/base_text.dart';
import 'package:mon/providers/localization.dart';
import 'package:mon/theme/colors.dart';
import 'package:mon/theme/fonts.dart';
import 'package:mon/utils/user_profile.dart';

class LanguageWidget extends StatelessWidget {
  final LanguagesOptions object;

  static String get id {
    const Type type = LanguageWidget;
    return '$type';
  }

  const LanguageWidget({required this.object, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        UserProfile.shared.currentLanguage = object.key;
        UserProfile.shared.setLanguage(UserProfile.shared.currentLanguage);
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Wrap(
          runSpacing: 8,
          children: [
            Row(
              children: [
                Provider.of<Localization>(context, listen: false)
                        .isSelectedLanguage(object.key)
                    ? const Icon(Icons.check_circle)
                    : const Icon(Icons.circle_outlined),
                16.ws,
                Expanded(
                    child: MBText(
                  object.title,
                  fontWeight: AppFonts.bold,
                  textAlign: TextAlign.justify,
                  color: AppColors.black,
                  fontSize: 16,
                ))
              ],
            ),
            Divider()
          ],
        ),
      ),
    );
  }
}
