import 'package:mon/utils/user_profile.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';


class ThemeProvider extends ChangeNotifier {
  late bool _isDark;

  bool get isDark => _isDark;

  ThemeProvider() {
    _isDark = UserProfile.shared.isDark;
    notifyListeners();
  }

  set isDark(bool value) {
    UserProfile.shared.isDark = value;
    _isDark = value;
    notifyListeners();
  }
}