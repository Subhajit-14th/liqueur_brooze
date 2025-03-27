import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:liqueur_brooze/services/services/hive_keys.dart';
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

  /// save park id
  static saveAccessToken({required String accessToken}) {
    HiveDatabase.box.put(HiveKeys.accessToken, accessToken);
  }

  /// get park id
  static String getAccessToken() {
    return HiveDatabase.box.get(HiveKeys.accessToken) ?? '';
  }
}
