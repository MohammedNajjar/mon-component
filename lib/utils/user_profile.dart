import 'package:mon/providers/localization.dart';
import 'package:mon/utils/Logger.dart';
import 'package:mon/web_service/constants.dart';
import 'package:mon/app/app_manager.dart';
import 'package:mon/model/user.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'dart:io' show Platform;
import 'dart:ui';


class UserProfile {
  static final UserProfile shared = UserProfile._internal();

  TUser? _currentUser;

  UserProfile._internal();

  factory UserProfile() {
    return shared;
  }

  void dispose() {}

  GetStorage? _storage;

  final String _currentUserIDKey = 'currentUserID';
  final String _accessTokenKey = 'accessToken';
  final String _currentUserKey = 'currentUser';
  final String _fcmToken = 'fcmToken';
  final String _baseURL = 'baseURL';
  final String _isDark = 'isDark';
  final String _currentLanguage = 'currentLanguage';

  Future<void> init() async {
    await GetStorage.init();
    _storage = GetStorage();
    getCurrentUser();
  }

  void setLanguage(String newValue) {
    Provider.of<Localization>(AppManager.navState.currentContext!,
            listen: false)
        .locale = Locale(newValue);
  }

  TUser? get currentUser {
    return _currentUser;
  }

  Future<TUser?>  getCurrentUser() async {
    if(_currentUser != null) {
      return _currentUser;
    }
    final data = await TUser.getAll(query: "WHERE ${TUser.primaryKey} = '$currentUserID'");
    final list = TUser.fromJsonList(data);
    if(list.isNotEmpty) {
      _currentUser = list.first;
    }
    return _currentUser;
  }

  String get systemLanguage {
    String languageCode = Platform.localeName.split('_')[0];

    return languageCode;
  }

  bool get isRTL {
    return currentLanguage == "ar";
  }

  String get currentLanguage {
    return (read(_currentLanguage) ?? systemLanguage ?? "en") as String;
  }

  bool get isDark {
    return (read(_isDark) ?? false) as bool;
  }

  String get fcmToken {
    return (read(_fcmToken) ?? "") as String;
  }

  bool get isUserLoggedIn {
    return currentUserID.isNotEmpty;
  }
  String get currentUserID {
    return (read(_currentUserIDKey) ?? "") as String;
  }

  String get baseURL {
    final url = read(_baseURL);
    return (url ?? Constants.apiUrlProduction) as String;
  }

  set isDark(bool newValue) {
    write(_isDark, newValue);
  }

  set baseURL(String newValue) {
    write(_baseURL, newValue);
  }

  set currentLanguage(String newValue) {
    write(_currentLanguage, newValue);
  }

  set fcmToken(String newValue) {
    write(_fcmToken, newValue);
  }

  set currentUserID(String? newValue) {
    write(_currentUserIDKey, newValue);
  }

  String get accessToken {
    return (read(_accessTokenKey) ?? '') as String;
  }

  set accessToken(String newValue) {
    write(_accessTokenKey, newValue);
  }

  void removeCachedCurrentUser() {
    _currentUser = null;
  }
  void logout() {
    removeCachedCurrentUser();
    remove(_currentUserIDKey);
    remove(_accessTokenKey);
  }

  void remove(String key) {
    if (key.isEmpty) return;
    _storage ??= GetStorage();
    if (_storage != null) _storage?.remove(key);
  }

  void write(String key, dynamic value) {
    if (key.isEmpty) return;
    _storage ??= GetStorage();
    if (_storage != null) _storage?.write(key, value);
  }

  dynamic read(String key) {
    if (key.isEmpty) return '';
    _storage ??= GetStorage();
    return _storage != null ? _storage?.read(key) : '';
  }
}
