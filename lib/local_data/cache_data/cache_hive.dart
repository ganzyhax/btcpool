import 'dart:developer';

import 'package:hive/hive.dart';
import 'package:btcpool_app/local_data/user_data/user.dart';

class LocalCache {
  static final LocalCache _instance = LocalCache._internal();

  LocalCache._internal();

  factory LocalCache() => _instance;

//================================================================================================================================

  Future<void> storeDashboardDataInHive(
      Map<String, dynamic> subAccountsMap) async {
    final box = await Hive.openBox('dashboardBoxing');
    await box.clear();

    for (var entry in subAccountsMap.entries) {
      await box.put(entry.key, entry.value);
    }
  }

//================================================================================================================================
  Future<Map<String, dynamic>> getDashboardDataFromHive() async {
    final box = await Hive.openBox('dashboardBoxing');

    Map<String, dynamic> subAccountsMap = {};
    for (var key in box.keys) {
      subAccountsMap[key] = box.get(key);
    }
    return subAccountsMap;
  }

//================================================================================================================================

  Future<void> storeSubAccountsDataInHive(dataList) async {
    final box = await Hive.openBox('subAccountsBoxing');
    await box.clear();
    for (var data in dataList) {
      await box.add(data);
    }
    await UserData().setLocalSubaccountsData();
  }

  //================================================================================================================================
  Future<List<dynamic>> getSubAccountsDataFromHive() async {
    final box = await Hive.openBox('subAccountsBoxing');
    try {
      final List<dynamic> dataList = [];
      for (var i = 0; i < box.length; i++) {
        dataList.add(box.getAt(i));
      }
      log('Cache subAcc data getted!');
      return dataList;
    } catch (e) {
      return [];
    }
  }

  Future<void> clearHive() async {
    try {
      await Hive.deleteFromDisk();
      await Hive.close();

      print('Hive database cleared successfully.');
    } catch (e) {
      print('Error clearing Hive database: $e');
    }
  }
}
