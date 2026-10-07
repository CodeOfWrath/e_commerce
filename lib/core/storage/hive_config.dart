// lib/core/storage/hive_config.dart
import 'package:hive_flutter/hive_flutter.dart';

class HiveConfig {
  static Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox('auth');
    await Hive.openBox('restaurants');
  }
}
