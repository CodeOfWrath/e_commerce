import 'package:hive_flutter/hive_flutter.dart';

class HiveConfig {
  static Future<void> init() async {
    await Hive.initFlutter();
    if (!Hive.isBoxOpen('auth')) {
      await Hive.openBox('auth');
    }
    if (!Hive.isBoxOpen('products_box')) {
      await Hive.openBox('products_box');
    }
  }
}
