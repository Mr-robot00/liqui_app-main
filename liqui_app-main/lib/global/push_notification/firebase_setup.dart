import 'dart:convert';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:liqui_app/global/utils/helpers/print_log.dart';
import 'package:liqui_app/global/utils/helpers/my_helper.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import '../utils/storage/my_local.dart';

class FirebaseSetup {
  late FirebaseMessaging firebaseMessaging;
  late FlutterLocalNotificationsPlugin flutterLocalNotifications;

  // factory MyFirebase() => _instance;
  // static final MyFirebase _instance = MyFirebase();

  Future initialise() async {
    firebaseMessaging = FirebaseMessaging.instance;
    flutterLocalNotifications = FlutterLocalNotificationsPlugin();
    addCrashlytics();
    await requestSettings();
    setupToken();
    initSettings();
    readDataPayload();
  }

  void addCrashlytics() {
    FirebaseCrashlytics.instance.log('App mounted');
  }

  requestSettings() async {
    if (myHelper.isOS) {
      await firebaseMessaging.setForegroundNotificationPresentationOptions(
          sound: true, badge: true, alert: true);
      var result = await firebaseMessaging.requestPermission(
          alert: true, badge: true, sound: true);
      debugPrint('iOS notification permission: ${result.authorizationStatus}');
    }

    if (Platform.isAndroid && await myHelper.sdkVersion > 32) {
      flutterLocalNotifications
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.requestNotificationsPermission();
    }
  }

  void initSettings() async {
    var initializationSettingsAndroid =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
        onDidReceiveLocalNotification:
            (int id, String? title, String? body, String? payload) async {});
    var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await flutterLocalNotifications.initialize(initializationSettings,
        onDidReceiveNotificationResponse:
            (NotificationResponse notificationResponse) async {
      printLog('Notification clicked');
    });
  }

  void setupToken() async {
    if (Platform.isIOS) await firebaseMessaging.getAPNSToken();
    final token = await firebaseMessaging.getToken();
    myLocal.fcmDeviceToken = token ?? '';
    printLog("FCM token: $token");
    firebaseMessaging.onTokenRefresh.listen((token) {
      myLocal.fcmDeviceToken = token;
      printLog("FCM refresh token: $token");
    });
  }

  void readDataPayload() async {
    var channel = const AndroidNotificationChannel("default", 'Default Channel',
        importance: Importance.max);
    await flutterLocalNotifications
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    ///executes when app is in foreground state
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      printLog('Message data ${(message.data)}');
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      printLog('channel name -> ${android?.channelId ?? 'Null channel id'}');
      if (notification?.title != null &&
          notification?.android != null &&
          !kIsWeb) {
        flutterLocalNotifications.show(
            notification.hashCode,
            notification?.title,
            notification?.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channelDescription: channel.description ?? '',
                icon: android?.smallIcon,
                // other properties...
              ),
              iOS: const DarwinNotificationDetails(),
            ));
      }
    });

    ///executes when app comes from terminate state
    var msg = await FirebaseMessaging.instance.getInitialMessage();
    printLog('initialFCM,${jsonEncode(msg?.data)}');

    ///executes when app comes from background state
    FirebaseMessaging.onMessageOpenedApp.listen((msg) {
      var message = msg.data;
      printLog('onMessageOpened: $message');
    });

    FirebaseMessaging.onBackgroundMessage(_messageHandler);
  }

  static Future<void> _messageHandler(RemoteMessage msg) async {
    var message = msg.data;
    debugPrint('onBackground: $message');
  }
}

final myFirebase = FirebaseSetup();
