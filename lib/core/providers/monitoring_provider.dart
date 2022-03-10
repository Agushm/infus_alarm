// ignore_for_file: prefer_const_constructors

part of "providers.dart";

class MonitoringProvider extends ChangeNotifier {
  MonitoringProvider() {
    init();
  }

  List<AlarmInfo> _pasien = [];
  List<AlarmInfo> get pasien => _pasien;

  AlarmInfo? lastPasien() {
    List<AlarmInfo> _load = [];
    _pasien.forEach((e) async {
      var isBefore = e.release.isBefore(DateTime.now());
      if (isBefore) {
        _load.add(e);
      }
    });
    if (_load.isEmpty) {
      return null;
    }
    _load.sort((a, b) => a.release.compareTo(b.release));
    return _load.last;
  }

  List<AlarmInfo> pendingAlarm() {
    List<AlarmInfo> _load = [];
    pasien.forEach((e) async {
      var isAfter = e.release.isAfter(DateTime.now());
      if (isAfter) {
        _load.add(e);
      }
    });
    return _load;
  }

  void save({AlarmInfo? oldData, AlarmInfo? newData}) {
    if (oldData == null) {
      add(newData!);
    } else {
      edit(oldData, newData!);
    }
  }

  void add(AlarmInfo newData) async {
    _pasien.add(newData);
    await updateLocalStorage();
    await addPendingAlarm();
    notifyListeners();
  }

  void edit(AlarmInfo oldData, AlarmInfo newData) async {
    int index = _pasien.indexOf(oldData);
    _pasien[index] = newData;
    await updateLocalStorage();
    await addPendingAlarm();
    notifyListeners();
  }

  void delete(AlarmInfo data) async {
    _pasien.remove(data);
    await updateLocalStorage();
    await addPendingAlarm();
    notifyListeners();
  }

  init() async {
    var local = await LocalStorage.instance.getMonitoring();
    if (local != null) {
      List<AlarmInfo> load = [];
      var d = json.decode(local);
      d.forEach((e) {
        load.add(AlarmInfo.fromJson(e));
      });
      _pasien = load;
      addPendingAlarm();
    }
    print("Local Storage: $local");
  }

  Future updateLocalStorage() async {
    await LocalStorage.instance.saveData(
        'monitoring',
        json.encode(
          _pasien.map<Map<String, dynamic>>((e) => AlarmInfo.toMap(e)).toList(),
        ));
  }

  Future addPendingAlarm() async {
    pasien.forEach((e) async {
      int index = pasien.indexOf(e);
      var isAfter = e.release.isAfter(DateTime.now());
      if (isAfter) {
        await _addScheduledAlarm(index, e);
      }
      print('Pasien Selisih= ${e.selisih}, isBefore=${isAfter}');
    });
    var pending = await LocalNotification.flutterLocalNotificationsPlugin
        .pendingNotificationRequests();
    print("Pending notification: ${pending.length}");
  }

  Future _addScheduledAlarm(int index, AlarmInfo data) async {
    print('AddSchedulerAlarm');
    AndroidAlarmManager.oneShotAt(data.release, index, printHello,
        alarmClock: true, allowWhileIdle: true, wakeup: true);
    //OLD//
    // final Int64List vibrationPattern = Int64List(4);
    // vibrationPattern[0] = 0;
    // vibrationPattern[1] = 1000;
    // vibrationPattern[2] = 5000;
    // vibrationPattern[3] = 2000;
    // AndroidNotificationDetails androidPlatformChannelSpecifics =
    //     AndroidNotificationDetails(
    //   'your other channel id',
    //   'your other channel name',
    //   channelDescription: 'your other channel description',
    //   sound: RawResourceAndroidNotificationSound('ringtone'),
    //   enableVibration: true,
    //   importance: Importance.max,
    //   priority: Priority.high,
    //   vibrationPattern: vibrationPattern,
    // );
    // final String? timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
    // var tzDateNow = tz.TZDateTime.now(tz.getLocation(timeZoneName!));
    // print(
    //     "TimezoneName $timeZoneName,TZDate = ${DateFormat('HH:mm').format(tzDateNow)}");
    // await LocalNotification.flutterLocalNotificationsPlugin.zonedSchedule(
    //     index,
    //     'Infus Habis | ${data.name}',
    //     'Kamar: ${data.bed} | Jenis Infus: ${data.infus} |  Volume: ${data.volume} | Dosis: ${data.dose}',
    //     tzDateNow.add(data.selisih),
    //     NotificationDetails(android: androidPlatformChannelSpecifics),
    //     androidAllowWhileIdle: true,
    //     uiLocalNotificationDateInterpretation:
    //         UILocalNotificationDateInterpretation.absoluteTime);
  }

  void showNotif() {
    print('Run Callback');
    // List<AlarmInfo> pending = pendingAlarm();

    // final Int64List vibrationPattern = Int64List(4);
    // vibrationPattern[0] = 0;
    // vibrationPattern[1] = 1000;
    // vibrationPattern[2] = 5000;
    // vibrationPattern[3] = 2000;
    // AndroidNotificationDetails androidPlatformChannelSpecifics =
    //     AndroidNotificationDetails(
    //   'your other channel id',
    //   'your other channel name',
    //   channelDescription: 'your other channel description',
    //   sound: RawResourceAndroidNotificationSound('ringtone'),
    //   enableVibration: true,
    //   importance: Importance.max,
    //   priority: Priority.high,
    //   vibrationPattern: vibrationPattern,
    // );
    // if (pending.isNotEmpty) {
    //   var data = pending[0];
    //   LocalNotification.flutterLocalNotificationsPlugin.show(
    //     data.release.millisecondsSinceEpoch,
    //     'Infus Habis | ${data.name} ${DateFormat('HH:mm:ss').format(data.release)}',
    //     'Kamar: ${data.bed} | Jenis Infus: ${data.infus} |  Volume: ${data.volume} | Dosis: ${data.dose}',
    //     NotificationDetails(android: androidPlatformChannelSpecifics),
    //   );
    // } else {
    //   LocalNotification.flutterLocalNotificationsPlugin.show(
    //     0,
    //     'Infus Habis | - ',
    //     'Kamar: - | Jenis Infus: - |  Volume: - | Dosis: -',
    //     NotificationDetails(android: androidPlatformChannelSpecifics),
    //   );
    // }
  }
}

void printHello() async {
  final DateTime now = DateTime.now();
  print("[$now] Hello, world! '");

  final Int64List vibrationPattern = Int64List(4);
  vibrationPattern[0] = 0;
  vibrationPattern[1] = 1000;
  vibrationPattern[2] = 5000;
  vibrationPattern[3] = 2000;
  AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
    'your other channel id',
    'your other channel name',
    channelDescription: 'your other channel description',
    sound: RawResourceAndroidNotificationSound('ringtone'),
    enableVibration: true,
    importance: Importance.max,
    priority: Priority.high,
    vibrationPattern: vibrationPattern,
  );

  LocalNotification.flutterLocalNotificationsPlugin.show(
    0,
    'Infus Habis ${DateFormat('HH:mm').format(now)}',
    'Salah satu infus pasien habis',
    NotificationDetails(android: androidPlatformChannelSpecifics),
  );
}
