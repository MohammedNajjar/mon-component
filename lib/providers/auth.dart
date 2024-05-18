import 'package:mon/app/app_manager.dart';
import 'package:mon/common/widgets/base_mixin.dart';
import 'package:mon/model/user.dart';
import 'package:mon/utils/Logger.dart';
import 'package:mon/utils/user_profile.dart';
import 'package:mon/web_service/base_request.dart';
import 'package:mon/web_service/request_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Auth with ChangeNotifier, BaseMixin {
  RequestBuilder? requestBuilder = RequestBuilder();

  bool get isAuth {
    return UserProfile.shared.accessToken.isEmpty == false;
  }

  @override
  void dispose() {
    requestBuilder = null;
    super.dispose();
  }

  Future<void> login(BaseRequest request) async {
    requestBuilder
        ?.setRequest(request)
        .setOptions(showLoader: true, showErrorMessage: true)
        .send()
        .success((response) async {
      final data =
          await TUser.fromJsonToLocalDatabaseList(response.data?['user']);
      UserProfile.shared.removeCachedCurrentUser();
      UserProfile.shared.currentUserID = data.first.id;
      UserProfile.shared.accessToken = response.data?['access_token'];
      await UserProfile.shared.getCurrentUser();
      Logger.log(UserProfile.shared.currentUser);
      Logger.log(response.data?['access_token']);
      notifyListeners();
    });
  }

  Future<void> updateProfile(BaseRequest request) async {
    requestBuilder
        ?.setRequest(request)
        .setOptions(showLoader: true, showErrorMessage: true)
        .send()
        .success((response) async {
      final data = await TUser.fromJsonToLocalDatabaseList(response.data?['user']);
      UserProfile.shared.removeCachedCurrentUser();
      await UserProfile.shared.getCurrentUser();
      Logger.log(UserProfile.shared.currentUser);
      notifyListeners();
    });
  }


  Future<void> logout(BaseRequest request) async {
    if (AppManager.navState.currentContext == null) return;
    await showConfirmationDialog(AppManager.navState.currentContext!,
        localization.logout, localization.logoutConfirmation, () {
      requestBuilder
          ?.setRequest(request)
          .setOptions(showLoader: true, showErrorMessage: true)
          .send()
          .response((response) async {
        UserProfile.shared.logout();
        notifyListeners();
      }, (response, json, error) async {
        UserProfile.shared.logout();
        notifyListeners();
      });
    });
  }
}
