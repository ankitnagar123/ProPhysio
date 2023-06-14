import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static Future<void> initialize(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    AndroidInitializationSettings androidInitialize =
        const AndroidInitializationSettings("@mipmap/ic_launcher");

    DarwinInitializationSettings iOSInitialize =
        const DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );
    InitializationSettings initializationsSettings =
        InitializationSettings(android: androidInitialize, iOS: iOSInitialize);

    /*   bool? init = await flutterLocalNotificationsPlugin.initialize(
        initializationsSettings, onSelectNotification: (String? payload) async {
      if (payload != null) {
        print('notification payload: ' + payload);
      }
    });*/
    bool? init = await flutterLocalNotificationsPlugin
        .initialize(initializationsSettings);
    print("local notification init=>$init");
    NotificationSettings settings =
        await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    print("device id>===> ${await FirebaseMessaging.instance.getToken()}");
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print("Notification Initialize");

      FirebaseMessaging.onBackgroundMessage(BackgroundMessageHandler);

      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        print(message.data);
        print("on message received ==> ${message.notification!.title}");
        print("on message received ==> ${message.notification!.body}");
        print("on message received ==> ${message.data}");

        var iosNotificationDetails = const DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        );

        var androidNotificationDetails = const AndroidNotificationDetails(
            "notifications", "medica",
            enableLights: true,
            priority: Priority.max,
            importance: Importance.max);

        NotificationDetails notificationDetails = NotificationDetails(
          android: androidNotificationDetails,
          iOS: iosNotificationDetails,
        );

        flutterLocalNotificationsPlugin.show(0, message.notification!.title,
            message.notification!.body, notificationDetails,
            payload: message.notification!.title);

        FirebaseMessaging.onMessageOpenedApp.listen((message) {
          print("on message recived ==> ${message.notification!.title}");
        });
      });
    }
  }
}

Future<void> BackgroundMessageHandler(RemoteMessage message) async {
  print("Remote message Handler==>$message");
}
