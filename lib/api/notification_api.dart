import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/data/latest.dart'; // for showSchedualedNotification function
import 'package:timezone/timezone.dart'; // for showSchedualedNotification function

class NotificationApi {
  static final _notifications = FlutterLocalNotificationsPlugin();
  static final onNotifications = BehaviorSubject<String?>();
  static bool isFirstInit = true;

  static initialize() async {
    initializeTimeZones(); // for showSchedualedNotification function
    String timeZone = await FlutterTimezone.getLocalTimezone();
    setLocalLocation(getLocation(timeZone));

    // when the app is closed
    final details = await _notifications.getNotificationAppLaunchDetails();
    if (details != null &&
        details.didNotificationLaunchApp &&
        details.notificationResponse != null) {
      onNotifications.add(details.notificationResponse!.payload);
    }

    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('mipmap/ic_launcher');
    DarwinInitializationSettings iosinitializationSetting =
        const DarwinInitializationSettings(
            requestAlertPermission: true,
            requestBadgePermission: true,
            requestSoundPermission: true);
    final InitializationSettings settings = InitializationSettings(
      android: androidInitializationSettings,
      iOS: iosinitializationSetting,
    );

    await _notifications.initialize(
      settings,
      onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
      onDidReceiveBackgroundNotificationResponse:
          onDidReceiveBackgroundNotificationResponse,
    );
  }

  static NotificationDetails _notificationDetails() {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'channel_id',
        'channel_name',
        channelDescription: 'channel_description',
        importance: Importance.max,
        // priority: Priority.max,
        playSound: true,
        styleInformation: BigTextStyleInformation(''),
      ),
      iOS: DarwinNotificationDetails(),
    );
  }

  static void cancel(int id) => _notifications.cancel(id);
  static void cancelAll() => _notifications.cancelAll();

  // instant notifications
  static Future<void> showNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
  }) async {
    return _notifications.show(id, title, body, _notificationDetails(),
        payload: payload);
  }

  static Future<void> showSchedualedNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
    required DateTime date,
  }) async {
    return _notifications.zonedSchedule(
      id,
      title,
      body,
      TZDateTime.from(date, local),
      _notificationDetails(),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      payload: payload,
    );
  }

  static Future<void> showSchedualedWeeklyNotification(
      {int id = 0,
      String? title,
      String? body,
      String? payload,
      int weekday = DateTime.friday}) async {
    return _notifications.zonedSchedule(
      id,
      title,
      body,
      TZDateTime.from(_nextTimeWeekday(weekday), local),
      _notificationDetails(),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
      payload: payload,
    );
  }

  static Future<void> showSchedualeDailyNotification(
      // set reminders evry day including sutterdays and holidays
      {
      //including shabat...
      int id = 0,
      String? title,
      String? body,
      String? payload,
      required int hour,
      required int minute}) async {
    return _notifications.zonedSchedule(
      id,
      title,
      body,
      schedualeDaily(hour, minute),
      _notificationDetails(),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
      payload: payload,
    );
  }

  static Future<List<PendingNotificationRequest>>
      get getPendingNotificationRequests async {
    return (await _notifications.pendingNotificationRequests());
  }

  static DateTime _nextTimeWeekday(int wantedDayweek) {
    var y = DateTime.now();
    var x = y.weekday;

    if (x < 5) {
      return y.add(Duration(days: (wantedDayweek - x)));
    } else if (x > 5) {
      return y.add(Duration(days: -(x - 7) + wantedDayweek));
    }

    return y; // if today is weekday
  }

  static TZDateTime schedualeDaily(int hour, int minute) {
    final now = TZDateTime.now(local);
    final schedualedDate = TZDateTime(local, now.year, now.month, now.day,
        hour, minute, 0);

    return schedualedDate.isBefore(now)
        ? schedualedDate.add(const Duration(days: 1))
        : schedualedDate;
  }

  static DateTime schedualeDailyDateTime(int hour, int minute) {
    final now = DateTime.now();
    final schedualedDate = DateTime(
        now.year, now.month, now.day, hour, minute, 0);

    return schedualedDate.isBefore(now)
        ? schedualedDate.add(const Duration(days: 1))
        : schedualedDate;
  }

  // actions
  static void onDidReceiveLocalNotification(
    int id,
    String? title,
    String? body,
    String? payload,
  ) {
    print('id $id');
  }

  static void onDidReceiveNotificationResponse(NotificationResponse details) {
    print('onDidReceiveNotificationResponse');
    print('id ${details.id}'); // Preserving functionality from deprecated onDidReceiveLocalNotification
    if (details.payload != null) {
      onNotifications.add(details.payload);
    }
  }

  static void onDidReceiveBackgroundNotificationResponse(
      NotificationResponse details) {
    print('onDidReceiveBackgroundNotificationResponse');
  }
}
