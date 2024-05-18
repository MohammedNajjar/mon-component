import 'package:mon/utils/user_profile.dart';
import 'dart:core';
import 'package:flutter/foundation.dart';

import 'package:mon/app/app_manager.dart';

class Constants {
  static bool get isDevelopmentServer {
    return Constants.apiUrl.contains(Constants.apiUrlProduction) == false;
  }
  static bool get isDebug {
    return kDebugMode;
  }

  static String get apiUrl {
    return UserProfile.shared.baseURL;
  }

  static String get mediaURL {
    return Constants.isDevelopmentServer ? Constants.apiUrlMediaUrlDevelopment : Constants.apiUrlMediaUrlProduction;
  }

  static List<String> get usersCanSwitchToDevelopment {
    return [
      "admin@bcc.com",
      "mmbelbeisi@gmail.com",
      "+971505438797",
    ];
  }

  static const String appName = "BaseProject";

  static const String dataBaseName = "AppDataBase";

  static const String apiUrlDevelopment = "https://staging.app.com";

  static const String apiUrlProduction = "https://app.com";

  static const String apiUrlMediaUrlDevelopment = "https://staging.app.com/";

  static const String apiUrlMediaUrlProduction = "https://app.com/";

  static const String apiVersion = "/api/v1/admin";

  static const String mobileCodeCountry = "+971";

  // Date Api configuration
  static const String apiDateFormatter = "yyyy-MM-dd'T'HH:mm:ss.SSSZ";
  static const String pageSizeKey = "limit";
  static const String pageKey = "page";
  static const int pageSize = 10;

  // static const TimeZone apiTimeZone = "UTC";
  // static const Locale local = "en-us";

  // Requests configuration
  static const int receiveTimeout = 15;
  static const int connectTimeout = 15;
  static const int sendTimeout = 15;
  static const bool showRequestLog = false;
  static const bool showLog = true;

  // MARK:- Alphabetic
  static const String alphabeticRegex = "[A-Za-zء-ي\\s]+";
  static const String numberRegex = "[0-9]+";

  // Mark:- alphabetic
  // static const RegExp alphabeticRegex = RegExp(r"[a-zA-Z]+|\s");

  // Mark:- Requests
  static const String API_Auth_login_Controller = Constants.apiVersion + "/auth/login";
  static const String API_Auth_logout_Controller = Constants.apiVersion + "/auth/logout";
  static const String API_Auth_profile_Controller = Constants.apiVersion + "/auth/profile";
  static const String API_Auth_updateProfile_Controller = Constants.apiVersion + "/auth/updateProfile";
  static const String API_Auth_updateFCM_Controller = Constants.apiVersion + "/auth/updateFCM";
}


enum MenuOptions { notifications, languages, aboutUs, privacyPolicy, termsAndConditions, login }

extension MenuOptionsEx on MenuOptions {
  String get title {
    switch (this) {
      case MenuOptions.notifications:
        return AppManager.shared.localization.notifications;
      case MenuOptions.languages:
        return AppManager.shared.localization.language;
      case MenuOptions.aboutUs:
        return AppManager.shared.localization.aboutUS;
      case MenuOptions.privacyPolicy:
        return AppManager.shared.localization.privacyPolicy;
      case MenuOptions.termsAndConditions:
        return AppManager.shared.localization.termsAndConditions;
      case MenuOptions.login:
        return UserProfile.shared.isUserLoggedIn ? AppManager.shared.localization.logout : AppManager.shared.localization.login;
    }
  }

  // String get image {
  //   switch (this) {
  //     case MenuOptions.notifications:
  //       return "home/ic_notification.svg".image_;
  //     case MenuOptions.languages:
  //       return "home/ic_languages2.svg".image_;
  //     case MenuOptions.aboutUs:
  //       return "home/ic_about_us.svg".image_;
  //     case MenuOptions.privacyPolicy:
  //       return "home/ic_privacy_policy.svg".image_;
  //     case MenuOptions.termsAndConditions:
  //       return "home/ic_static_pages.svg".image_;
  //     case MenuOptions.login:
  //       return UserProfile.shared.isUserLoggedIn ? "home/ic_logout.svg".image_ : "home/ic_login.svg".image_;
  //   }
  // }
}


enum LanguagesOptions { english, arabic, french, german, spanish }

extension LanguagesOptionsEx on LanguagesOptions {
  String get title {
    switch (this) {
      case LanguagesOptions.english:
        return AppManager.shared.localization.english;
      case LanguagesOptions.arabic:
        return AppManager.shared.localization.arabic;
      case LanguagesOptions.french:
        return "French";
      case LanguagesOptions.german:
        return "German";
      case LanguagesOptions.spanish:
        return "Spanish";
    }
  }
  String get key {
    switch (this) {
      case LanguagesOptions.english:
        return 'en';
      case LanguagesOptions.arabic:
        return 'ar';
      case LanguagesOptions.french:
        return "fr";
      case LanguagesOptions.german:
        return "de";
      case LanguagesOptions.spanish:
        return "es";
    }
  }
}
