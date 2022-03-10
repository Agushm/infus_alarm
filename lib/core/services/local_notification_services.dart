// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'dart:io' show Platform;

import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import 'package:rxdart/rxdart.dart';

class LocalNotifyManager {
  static late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  var initSetting;

  BehaviorSubject<ReceivedNotification>
      get didReceiveLocalNotificationSubject =>
          BehaviorSubject<ReceivedNotification>();

  final BehaviorSubject<String?> selectNotificationSubject =
      BehaviorSubject<String?>();

  MethodChannel platform =
      MethodChannel('dexterx.dev/flutter_local_notifications_example');

  LocalNotifyManager.init() {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    if (Platform.isIOS) {
      requestIOSPermission();
    }
    _configureLocalTimeZone();

    initializePlatform();
  }

  requestIOSPermission() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()!
        .requestPermissions(alert: true, badge: true, sound: true);
  }

  initializePlatform() {
    var initSettingAndroid = AndroidInitializationSettings('app_icon');
    var initSettingIOS = IOSInitializationSettings(
      requestSoundPermission: true,
      requestAlertPermission: true,
      requestBadgePermission: true,
      onDidReceiveLocalNotification: (id, title, body, payload) {
        ReceivedNotification notification = ReceivedNotification(
            id: id, title: title, body: body, payload: payload);
        didReceiveLocalNotificationSubject.add(notification);

        return;
      },
    );

    initSetting = InitializationSettings(
        android: initSettingAndroid, iOS: initSettingIOS);
  }

  setOnNotificationReceived(Function onNotificationReceived) {
    didReceiveLocalNotificationSubject.listen((notification) {
      onNotificationReceived(notification);
    });
  }

  setOnNotificationClick(Function onNotificationClick) async {
    await flutterLocalNotificationsPlugin.initialize(initSetting,
        onSelectNotification: (String? payload) async {
      onNotificationClick(payload);
      selectNotificationSubject.add(payload);
    });
  }

  Future<void> showNotification() async {
    var androidChannel = AndroidNotificationDetails(
      'CHANNEL_ID',
      'CHANNEL_NAME',
      channelDescription: 'CHANNEL_DESCRIPTION',
      importance: Importance.max,
      priority: Priority.high,
      largeIcon: const DrawableResourceAndroidBitmap('large_app_icon'),
      playSound: true,
      sound: RawResourceAndroidNotificationSound('sound_notif'),
      styleInformation: BigTextStyleInformation(''),
    );
    var iosChannel = IOSNotificationDetails();
    var platformChannel =
        NotificationDetails(android: androidChannel, iOS: iosChannel);
    await flutterLocalNotificationsPlugin.show(
        0,
        'Alarm Infus alarm',
        'Saat yang tepat untuk Infus alarm Saat yang tepat untuk Infus alarm Saat yang tepat untuk Infus alarm',
        platformChannel,
        payload: 'sedekah-subuh-close');
  }

  Future<void> showFromFCM(Map<String, dynamic> message) async {
    var androidChannel = AndroidNotificationDetails(
      'CHANNEL_FCM_ID',
      'CHANNEL_FCM',
      channelDescription: 'CHANNEL_FCM_DESCRIPTION',
      importance: Importance.max,
      priority: Priority.high,
      largeIcon: const DrawableResourceAndroidBitmap('large_app_icon'),
      playSound: true,
      sound: RawResourceAndroidNotificationSound('sound_notif'),
      styleInformation: BigTextStyleInformation(''),
    );
    var iosChannel = IOSNotificationDetails();
    var platformChannel =
        NotificationDetails(android: androidChannel, iOS: iosChannel);
    await flutterLocalNotificationsPlugin.show(
        0,
        message["notification"]["title"],
        message["notification"]["body"],
        platformChannel,
        payload: 'fcm');
  }

  _configureLocalTimeZone() async {
    tz.initializeTimeZones();
    final String timeZoneName = await platform.invokeMethod('getTimeZoneName');
    tz.setLocalLocation(tz.getLocation(timeZoneName));
  }

  Future<void> zonedScheduleNotification() async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        'scheduled title',
        'scheduled body',
        tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
        const NotificationDetails(
            android: AndroidNotificationDetails(
          'your channel id',
          'your channel name',
          channelDescription: 'your channel description',
        )),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }

  Future<void> scheduleDailySubuh(int id, tz.TZDateTime tzDate,
      {String? title, String? body, String? payload = 'sedekah-subuh'}) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
        id,
        title,
        body,
        tzDate,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'Infus alarm channel id',
            'Infus alarm channel name',
            channelDescription: 'Infus alarm description',
            importance: Importance.max,
            priority: Priority.high,
            largeIcon: const DrawableResourceAndroidBitmap('large_app_icon'),
            playSound: true,
            sound: RawResourceAndroidNotificationSound('sound_notif'),
            styleInformation: BigTextStyleInformation(''),
          ),
        ),
        payload: payload,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time);
    print('Alarm : berhasil set $tzDate');
  }

  Future<void> scheduleDailyMagrib() async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
        2,
        'Alarm Magrib 17.45',
        'Saat yang tepat untuk sholat magrib',
        _nextInstanceOfMagrib(),
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'Infus Alarm channel id',
            'Infus Alarm channel name',
            channelDescription: 'Infus Alarm description',
            importance: Importance.max,
            priority: Priority.high,
            largeIcon: const DrawableResourceAndroidBitmap('large_app_icon'),
            playSound: true,
            sound: RawResourceAndroidNotificationSound('sound_notif'),
          ),
        ),
        payload: 'sedekah-subuh',
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time);
  }

  tz.TZDateTime nextInstanceOfSubuh() {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, 4, 15);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }

  tz.TZDateTime nextInstanceOfJam14() {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, 7, 0);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }

  tz.TZDateTime nextInstanceOfJam8() {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, 6, 30);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }

  tz.TZDateTime _nextInstanceOfMagrib() {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, 17, 45);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }

  Future<List<PendingNotificationRequest>>
      checkPendingNotificationRequests() async {
    final List<PendingNotificationRequest> pendingNotificationRequests =
        await flutterLocalNotificationsPlugin.pendingNotificationRequests();
    return pendingNotificationRequests;
  }

  Future<void> cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
    print('Cancel all scheduled notification');
  }
}

LocalNotifyManager localNotifyManager = LocalNotifyManager.init();

class ReceivedNotification {
  final int? id;
  final String? title;
  final String? body;
  final String? payload;
  ReceivedNotification(
      {@required this.id,
      @required this.title,
      @required this.body,
      @required this.payload});
}
