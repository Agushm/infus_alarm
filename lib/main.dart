import 'dart:isolate';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:infus_app/core/services/notification_services.dart';
import 'package:infus_app/ui/constants/constants.dart';
import 'package:provider/provider.dart';

import 'core/providers/providers.dart';
import 'core/services/local_notification_services.dart';
import 'ui/page/pages.dart';

void printHello() {
  final DateTime now = DateTime.now();
  final int isolateId = Isolate.current.hashCode;
  print("[$now] Hello, world! isolate=${isolateId} function='$printHello'");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  LocalNotification.instance.init();
  await AndroidAlarmManager.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: MyTheme(),
        ),
        ChangeNotifierProvider.value(
          value: MonitoringProvider(),
        ),
        ChangeNotifierProvider.value(
          value: TimerProvider(),
        ),
      ],
      child: Consumer<MyTheme>(
        builder: (context, theme, child) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'SIMPECI (Aplikasi Monitoring Pemberian Carian Infus)',
          theme: themeData(context),
          darkTheme: darkThemeData(context),
          themeMode: theme.isLightTheme ? ThemeMode.light : ThemeMode.dark,
          home: MainPage(),
        ),
      ),
    );
  }
}
