import 'package:mon/utils/user_profile.dart';
import 'package:flutter/foundation.dart';
import 'dart:ui';
import 'package:mon/web_service/constants.dart';

class Localization extends ChangeNotifier {
  Locale _locale = Locale(UserProfile.shared.currentLanguage);

  List languages = [
    LanguagesOptions.english,
    LanguagesOptions.arabic,
    LanguagesOptions.french,
    LanguagesOptions.german,
    LanguagesOptions.spanish,
  ];

  Locale get locale => _locale;

  set locale(Locale newLocale) {
    _locale = newLocale;
    notifyListeners();
  }

  bool isSelectedLanguage(String languageCode) {
    return UserProfile.shared.currentLanguage == languageCode;
  }
}
