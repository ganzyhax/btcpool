import 'dart:developer';

import 'package:btcpool_app/api/api.dart';
import 'package:btcpool_app/local_data/cache_data/cache_hive.dart';

class UserData {
  static final UserData _instance = UserData._internal();

  UserData._internal();

  factory UserData() => _instance;

  Map<String, dynamic> dashboardMap = {};
  List<dynamic> dataSubAccounts = [];
  Future<void> setLocalDashboardData() async {
    dashboardMap = await LocalCache().getDashboardDataFromHive();
  }

  Future<void> setLocalSubaccountsData() async {
    dataSubAccounts = await LocalCache().getSubAccountsDataFromHive();
  }

  Future<void> fetchDashboardData(subAccounts) async {
    List<String> localSubAccounts = [];
    for (var subAccount in subAccounts) {
      localSubAccounts.add(subAccount['name']);
    }
    for (var subAccount in localSubAccounts) {
      var dashboardData = await ApiClient.get(
          'api/v1/pools/sub_account/summary/?sub_account_name=$subAccount');
      log(dashboardData.toString());
      List<dynamic> hashrateData = await Future.wait([
        _fetchHashrate(subAccount, '10MIN'),
        _fetchHashrate(subAccount, 'HOUR'),
        _fetchHashrate(subAccount, 'DAY'),
      ]);

      dashboardMap[subAccount] = {
        'dashboardData': dashboardData,
        'hashrateData': hashrateData,
      };
      log('Successfully fetched for $subAccount');
      await LocalCache().storeDashboardDataInHive(dashboardMap);
    }
  }

  Future<dynamic> _fetchHashrate(String subAccount, String interval) async {
    return await ApiClient.get(
        'api/v1/pools/sub_account/observer/hashrate_chart/?interval=$interval&with_dates=true&sub_account_name=$subAccount');
  }

  Future<dynamic> updateSubAccountData(String subAccountName) async {
    try {
      var dashboardData = await ApiClient.get(
          'api/v1/pools/sub_account/summary/?sub_account_name=$subAccountName');
      if (dashboardData != null) {
        List<dynamic> hashrateData = await Future.wait([
          _fetchHashrate(subAccountName, '10MIN'),
          _fetchHashrate(subAccountName, 'HOUR'),
          _fetchHashrate(subAccountName, 'DAY'),
        ]);

        Map<String, dynamic> subAccountData = {
          'dashboardData': dashboardData,
          'hashrateData': hashrateData,
        };

        if (dashboardMap.containsKey(subAccountName)) {
          dashboardMap[subAccountName] = subAccountData;
        } else {
          dashboardMap.putIfAbsent(subAccountName, () => subAccountData);
        }
        log('Successfully update for $subAccountName');
        await LocalCache().storeDashboardDataInHive(dashboardMap);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log(e.toString());
      return false;
    }
  }
  //================================================================================================================================

  Future<void> addSubAccountData(String subAccountName) async {
    if (!dashboardMap.containsKey(subAccountName)) {
      var dashboardData = await ApiClient.get(
          'api/v1/pools/sub_account/summary/?sub_account_name=$subAccountName');

      List<dynamic> hashrateData = await Future.wait([
        _fetchHashrate(subAccountName, '10MIN'),
        _fetchHashrate(subAccountName, 'HOUR'),
        _fetchHashrate(subAccountName, 'DAY'),
      ]);

      Map<String, dynamic> subAccountData = {
        'dashboardData': dashboardData,
        'hashrateData': hashrateData,
      };

      dashboardMap[subAccountName] = subAccountData;
      log('Succesfully added new $subAccountName');
      await LocalCache().storeDashboardDataInHive(dashboardMap);
    }
  }

  Future<dynamic> setSingleHashrateData(
      String subAccountName, data, index) async {
    try {
      if (dashboardMap[subAccountName] != null) {
        dashboardMap[subAccountName]['hashrateData'][index] = data;
        log('Succesfully setted new hashrateData$subAccountName');
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  Future<dynamic> setDashboardData(String subAccountName, data) async {
    try {
      if (dashboardMap[subAccountName] != null) {
        dashboardMap[subAccountName]['dashboardData'] = data;
        log('Succesfully setted new dashboardData $subAccountName');
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log(e.toString());
      return false;
    }
  }
}
