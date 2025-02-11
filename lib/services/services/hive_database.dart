import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class HiveDatabase {
  static late Box box;

  /// Initialize Hive
  static initializeHive() async {
    Directory directory = await getApplicationDocumentsDirectory();
    debugPrint('---- Path: ${directory.path}');
    try {
      Hive.init('${directory.path}/hive');
      HiveDatabase.box = await Hive.openBox('blgprk');
    } catch (e) {
      debugPrint('---- Failed to local/create hive: $e');
    }
  }
}
