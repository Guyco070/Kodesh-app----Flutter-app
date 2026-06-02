import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:kodesh_app/helpers/app_logger.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/data/latest.dart'; // for showScheduledNotification function
import 'package:timezone/timezone.dart'; // for showScheduledNotification function

class NotificationApi {
  static final _notifications = FlutterLocalNotificationsPlugin();
  static final onNotifications = BehaviorSubject<String?>();
  static bool isFirstInit = true;

  static initialize() async {
    initializeTimeZones();
    final timeZone = await FlutterTimezone.getLocalTimezone();
    setLocalLocation(getLocation(timeZone.identifier));

    // when the app is closed
    final details = await _notifications.getNotificationAppLaunchDetails();
    if (details != null &&
        details.didNotificationLaunchApp &&
        details.notificationResponse != null) {
      onNotifications.add(details.notificationResponse!.payload);
    }

    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('mipmap/ic_launcher');
    const DarwinInitializationSettings iosinitializationSetting =
        DarwinInitializationSettings(
            requestAlertPermission: true,
            requestBadgePermission: true,
            requestSoundPermission: true);
    final InitializationSettings settings = InitializationSettings(
      android: androidInitializationSettings,
      iOS: iosinitializationSetting,
    );

    await _notifications.initialize(
      settings: settings,
      onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
      onDidReceiveBackgroundNotificationResponse:
          onDidReceiveBackgroundNotificationResponse,
    );

    await _requestPermissions();
  }

  static Future<void> _requestPermissions() async {
    final android = _notifications.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    final ios = _notifications.resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin>();

    if (android != null) {
      final granted = await android.requestNotificationsPermission();
      final exactAlarmGranted = await android.requestExactAlarmsPermission();
      logger.i('Android notification permission: $granted, exact alarm: $exactAlarmGranted');
    }
    if (ios != null) {
      final granted = await ios.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
      logger.i('iOS notification permission: $granted');
    }
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

  static void cancel(int id) => _notifications.cancel(id: id);
  static void cancelAll() => _notifications.cancelAll();

  // instant notifications
  static Future<void> showNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
  }) async {
    return _notifications.show(
        id: id,
        title: title,
        body: body,
        notificationDetails: _notificationDetails(),
        payload: payload);
  }

  static Future<void> showScheduledNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
    required DateTime date,
  }) async {
    return _notifications.zonedSchedule(
      id: id,
      title: title,
      body: body,
      scheduledDate: TZDateTime.from(date, local),
      notificationDetails: _notificationDetails(),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      payload: payload,
    );
  }

  static Future<void> showScheduledWeeklyNotification(
      {int id = 0,
      String? title,
      String? body,
      String? payload,
      int weekday = DateTime.friday}) async {
    return _notifications.zonedSchedule(
      id: id,
      title: title,
      body: body,
      scheduledDate: TZDateTime.from(_nextTimeWeekday(weekday), local),
      notificationDetails: _notificationDetails(),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
      payload: payload,
    );
  }

  static Future<void> showScheduleDailyNotification(
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
      id: id,
      title: title,
      body: body,
      scheduledDate: scheduleDaily(hour, minute),
      notificationDetails: _notificationDetails(),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
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

  static TZDateTime scheduleDaily(int hour, int minute) {
    final now = TZDateTime.now(local);
    final scheduledDate = TZDateTime(local, now.year, now.month, now.day,
        hour, minute, 0);

    return scheduledDate.isBefore(now)
        ? scheduledDate.add(const Duration(days: 1))
        : scheduledDate;
  }

  static DateTime scheduleDailyDateTime(int hour, int minute) {
    final now = DateTime.now();
    final scheduledDate = DateTime(
        now.year, now.month, now.day, hour, minute, 0);

    return scheduledDate.isBefore(now)
        ? scheduledDate.add(const Duration(days: 1))
        : scheduledDate;
  }

  // actions
  static void onDidReceiveLocalNotification(
    int id,
    String? title,
    String? body,
    String? payload,
  ) {
    logger.d('onDidReceiveLocalNotification: id=$id');
  }

  static void onDidReceiveNotificationResponse(NotificationResponse details) {
    logger.d('onDidReceiveNotificationResponse: id=${details.id}');
    if (details.payload != null) {
      onNotifications.add(details.payload);
    }
  }

  static void onDidReceiveBackgroundNotificationResponse(
      NotificationResponse details) {
    logger.d('onDidReceiveBackgroundNotificationResponse: id=${details.id}');
    if (details.payload != null) {
      onNotifications.add(details.payload);
    }
  }
}
