import 'package:mon/app/app.dart';
import 'package:mon/app/firebase_messaging_helper.dart';
import 'package:mon/model/database_manager.dart';
import 'package:mon/utils/Logger.dart';
import 'package:mon/utils/extensions/easyloading.dart';
import 'package:mon/utils/user_profile.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

main() async {
  await init();
  runApp(const App());
  configLoading();
  
}

Future<void> init() async {
  WidgetsFlutterBinding.ensureInitialized();
  await UserProfile.shared.init();
  await DatabaseManager.shared.initDatabase();
  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp(
      //options: Platform.isIOS? DefaultFirebaseOptions.currentPlatform:null
    );
  }else {
    Firebase.app(); // if already initialized, use that one
  }
  final FirebaseMessagingHelper firebaseMessagingHelper = FirebaseMessagingHelper();
  await firebaseMessagingHelper.initializeFirebaseMessaging();
}