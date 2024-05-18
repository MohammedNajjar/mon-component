import 'dart:convert';

import 'package:mon/utils/Logger.dart';
import 'package:mon/utils/user_profile.dart';
import 'package:mon/web_service/constants.dart';
import 'package:mon/web_service/request_builder.dart';
import 'package:mon/web_service/requests/auth_request.dart';
import 'package:mon/web_service/base_request.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'firebase_messaging_helper.dart';

extension FirebaseMessagingHelperEx on FirebaseMessagingHelper {

  Future<void> handleMessage(RemoteMessage message) async {
    showNotification(message);
    // Logger.log('Received message: ${message.notification?.title}');
    // Handle the received message while the app is in the foreground
    // Display a custom in-app notification or perform any desired actions
    // You can access the message data with `message.data`
  }

  Future<void> onInitializeAppAfterClickingOnNotification(Map<String, dynamic> data) async {
  }

  Future<void> handleBackgroundMessage(RemoteMessage message) async {
    Logger.log('Received background message: ${message.notification?.title}');
    // Handle the received message while the app is in the background or terminated
    // You can access the message data with `message.data`
  }

  Future<void> handleMessageOpenedApp(RemoteMessage message) async {
    Logger.log('User clicked on notification: ${message.notification?.title}');
    // Handle user interaction when a notification is clicked
    // Navigate to a specific screen, fetch additional data, or perform any other necessary operations
    // You can access the message data with `message.data`
  }

  Future<void> handleOnTap(NotificationResponse details) async {
    Logger.log('User clicked on notification: ${details.payload}');
    // if (details!.didNotificationLaunchApp) {
    //   if (details.payload != null) {
    //     Map<String, dynamic> data = json.decode(details.payload!);
    //     initialScreen = getWidget(data,true);
    //   }
    // }
    // Handle user interaction when a notification is clicked
    // Navigate to a specific screen, fetch additional data, or perform any other necessary operations
    // You can access the message data with `message.data`
  }
}
