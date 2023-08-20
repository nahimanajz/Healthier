import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:healthier2/utils/color_schemes.g.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    //bool? hasNofitification = prefs.getBool("hasToNotify");
    AndroidNotificationDetails androidChannelSpecifics =
        AndroidNotificationDetails("Pill_Reminder", "channel_name",
            playSound: true,
            importance: Importance.max,
            priority: Priority.high,
            color: lightColorScheme.secondaryContainer);

    var notification = NotificationDetails(
        android: androidChannelSpecifics, iOS: DarwinNotificationDetails());

    //if (hasNofitification != null) {
    await fln.show(0, title, body, notification);
    //}
  }
}
