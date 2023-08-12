import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:healthier2/utils/color_schemes.g.dart';

class LocalNotification {
  static Future initialize(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var androidInitialize =
        const AndroidInitializationSettings('@drawable/icons8pill50');
    // Initialize iOS settings
    var iOSInitialize = DarwinInitializationSettings();
    var initializationsSettings =
        InitializationSettings(android: androidInitialize, iOS: iOSInitialize);
    await flutterLocalNotificationsPlugin.initialize(initializationsSettings);
  }

  static Future showNotification(
      {var id = 0,
      required String title,
      required String body,
      var payload,
      required FlutterLocalNotificationsPlugin fln}) async {
    AndroidNotificationDetails androidChannelSpecifics =
        AndroidNotificationDetails("Pill_Reminder", "channel_name",
            playSound: true,
            //sound: RawResourceAndroidNotificationSound('notification'), TODO: works on real device only
            importance: Importance.max,
            priority: Priority.high,
            color: lightColorScheme.secondaryContainer);

    var notification = NotificationDetails(
        android: androidChannelSpecifics, iOS: DarwinNotificationDetails());
    await fln.show(0, title, body, notification);
  }
}
