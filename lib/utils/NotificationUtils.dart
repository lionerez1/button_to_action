import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationUtils {
  static final FlutterLocalNotificationsPlugin notificationsHandler =
      FlutterLocalNotificationsPlugin();

  static InitializationSettings factorInitializationSettings() {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('ic_launcher');

    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
      requestAlertPermission: true,
    );

    return InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
  }

  static NotificationDetails factorNotificationDetails() {
    const specs = AndroidNotificationDetails(
        'channelId', 'channelName', 'channelDescription',
        importance: Importance.max, priority: Priority.high);
    return NotificationDetails(android: specs);
  }

  static void showNotification() {
    notificationsHandler.show(0, 'Notification Title', 'Hello!!!',
        NotificationUtils.factorNotificationDetails(),
        payload: 'contacts');
  }
}
