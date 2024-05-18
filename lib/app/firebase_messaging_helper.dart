import 'dart:convert';

import 'package:mon/utils/Logger.dart';
import 'package:mon/utils/user_profile.dart';
import 'package:mon/web_service/constants.dart';
import 'package:mon/web_service/request_builder.dart';
import 'package:mon/web_service/requests/auth_request.dart';
import 'package:mon/web_service/base_request.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'firebase_messaging_helper_actions.dart';

class FirebaseMessagingHelper {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
  final RequestBuilder _requestBuilder = RequestBuilder();

  Future<void> initializeFirebaseMessaging() async {
    await _firebaseMessaging.requestPermission();
    const initializationSettingsAndroid =   AndroidInitializationSettings('@drawable/logo');
    const DarwinInitializationSettings initializationSettingsIOS =
    DarwinInitializationSettings(
      requestSoundPermission: true,
      requestBadgePermission: true,
      requestAlertPermission: true,
    );
    const InitializationSettings initializationSettings =  InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: handleOnTap);
    // Store or send the token to your server for sending push notifications
    _configureFirebaseMessaging();
    Future.delayed(const Duration(seconds: 1), () async {
      NotificationAppLaunchDetails? details =
      await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
      if (details != null) {
        if (details?.didNotificationLaunchApp == true) {
          if (details?.notificationResponse?.payload != null) {
            Map<String, dynamic> data = json.decode(details!.notificationResponse!.payload!);
            onInitializeAppAfterClickingOnNotification(data);
          }
        }
      }
    });
    final token = await _firebaseMessaging.getToken();
    // Logger.log('Firebase Messaging Token: ${FirebaseMessaging.instance}');
    Logger.log('Firebase Messaging Token: $token');
    UserProfile.shared.fcmToken = token ?? "";
    if(UserProfile.shared.isUserLoggedIn) {
      AuthRequest request = AuthRequest(route: AuthRoutes.updateFCM);
       _requestBuilder.setRequest(request).setOptions(showErrorMessage: false, showLoader: false).sendAsync();
       subscribeToTopic("TopicName");
       if(kDebugMode) {
         subscribeToTopic("TestTopicName");
       }
    }
  }

  Future<void> showNotification(RemoteMessage message) async {
    Logger.log("New notification has been received \n title: ${message.notification?.title} \n body: ${message.notification?.body} \n data: ${Logger.beautify(message.data)}");
    var androidDetails = const AndroidNotificationDetails(
      'channelId',
      'channelName',
      channelDescription: 'channelDescription',
      importance: Importance.high,
      priority: Priority.high,
    );
    var platformDetails = NotificationDetails(android: androidDetails);

    await flutterLocalNotificationsPlugin.show(
      0,
      message.notification?.title ?? Constants.appName, // Notification title
      message.notification?.body ?? Constants.appName, // Notification body
      platformDetails,
      payload: jsonEncode(message.data) ?? 'notification',
    );
  }

  void _configureFirebaseMessaging() {
    FirebaseMessaging.onMessage.listen(handleMessage);
    // FirebaseMessaging.onMessageOpenedApp.listen(handleMessageOpenedApp);
    // FirebaseMessaging?.onBackgroundMessage(handleBackgroundMessage);
  }

  Future<void> subscribeToTopic(String topic) async {
    await _firebaseMessaging.subscribeToTopic(topic);
    Logger.log('Subscribed to topic: $topic');
  }

  Future<void> unsubscribeFromTopic(String topic) async {
    await _firebaseMessaging.unsubscribeFromTopic(topic);
    Logger.log('Unsubscribed from topic: $topic');
  }

  Future<void> sendPushNotification({
    required String title,
    required String body,
    required Map<String, dynamic> data,
    List<String>? tokens,
    String? topic,
  }) async {
    final serverKey = 'YOUR_SERVER_KEY'; // Replace with your FCM server key

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'key=$serverKey',
    };

    FCMNotificationRequest request = FCMNotificationRequest(route: FCMNotificationRoutes.fCMNotification);
    request.title = title;
    request.body = body;
    request.data = data;
    if (tokens != null && tokens.isNotEmpty) {
      request.registrationIds = tokens;
    } else if (topic != null) {
      request.to = '/topics/$topic';
    }
    final response = await _requestBuilder.setRequest(request).setOptions(showErrorMessage: true, showLoader: true).sendAsync();

    if (response.code == 200) {
      Logger.log('Push notification sent successfully');
    } else {
      Logger.log('Failed to send push notification. Error:');
    }
  }
}

enum FCMNotificationRoutes {  fCMNotification  }

class FCMNotificationRequest extends BaseRequest {

  String? to;
  String? title;
  String? body;
  String? notification;
  String? sound;
  List<String>? registrationIds;
  Map<String, dynamic>? data;

  final String _paramKey_to = "to";
  final String _paramKey_notification = "notification";
  final String _paramKey_data = "data";
  final String _paramKey_priority = "priority";
  final String _paramKey_mutableContent = "mutable-content";
  final String _paramKey_registrationIds = "registration_ids";

  final FCMNotificationRoutes route;

  FCMNotificationRequest({ required this.route });


  @override
  // TODO: implement url
  String get url {
    switch (route) {
      case FCMNotificationRoutes.fCMNotification:
        return "/fcm/send";
    }
  }

  @override
  // TODO: implement params
  Map<String, dynamic> get params {
    Map<String, dynamic> parameters = {};
    switch (route) {
      case FCMNotificationRoutes.fCMNotification:
        parameters[_paramKey_to] = to;
        parameters[_paramKey_registrationIds] = registrationIds;
        parameters[_paramKey_notification] = {
          'title': title,
          'body': data,
          'sound': "default",
          "mutable_content": true
        };
        parameters[_paramKey_data] = data;
        parameters[_paramKey_priority] = "high";
        parameters[_paramKey_mutableContent] = 1;
        break;
    }
    return parameters;
  }

  @override
  // TODO: implement type
  HttpMethods get type {
    switch (route) {
      case FCMNotificationRoutes.fCMNotification:
        return HttpMethods.post;
    }
  }

  @override
  // TODO: implement files
  List<BaseRequestFile> get files {
    final List<BaseRequestFile> list = [];
    switch (route) {
      case FCMNotificationRoutes.fCMNotification:
        break;
    }
    return list;
  }
}