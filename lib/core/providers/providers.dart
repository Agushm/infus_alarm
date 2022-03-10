import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:infus_app/core/models/models.dart';
import 'package:infus_app/core/services/local_storage_services.dart';
import 'package:infus_app/core/services/notification_services.dart';
import 'package:infus_app/string_converter.dart';
import 'package:intl/intl.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

part 'theme_provider.dart';
part 'monitoring_provider.dart';
part 'timer_provider.dart';
