import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class IosLocalNotificationsUtil {
  IosLocalNotificationsUtil() {
    initialize();
  }

  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    DarwinInitializationSettings initializationSettingsDarwin =
    const DarwinInitializationSettings(
      //make any of them true for request notification permission
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
    );

    InitializationSettings settings =
    InitializationSettings(iOS: initializationSettingsDarwin);

    await flutterLocalNotificationsPlugin.initialize(settings: settings,
        onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
        onDidReceiveBackgroundNotificationResponse:
        onDidReceiveBackgroundNotificationResponse);
  }

  Future<void> showNotification(
      {required int id, String? title, required String body}) async {
    if (await requestNotificationsPermission()) {
      flutterLocalNotificationsPlugin.show(
        id: id,
        title: title,
        body: body,
        notificationDetails: const NotificationDetails(
            iOS: DarwinNotificationDetails(
                presentAlert: false, //disable foreground
                presentBanner: false //disable foreground
            )),
      );
    }
  }

  void cancelNotification(int id) {
    flutterLocalNotificationsPlugin.cancel( id: id);
  }

  void cancelAllNotifications() {
    flutterLocalNotificationsPlugin.cancelAll();
  }

  static void onDidReceiveNotificationResponse(NotificationResponse details) {}

  static void onDidReceiveBackgroundNotificationResponse(
      NotificationResponse details) {}

  Future<bool> requestNotificationsPermission() async {
    return await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(sound: true, alert: true, badge: true) ??
        false;
  }
}
