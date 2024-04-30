import 'package:btcpool_app/api/api.dart';
import 'package:hive/hive.dart';

class DashboardFunctions {
  //================================================================================================================================
  Future<Map<String, dynamic>> fetchDashboardData(subAccounts) async {
    Map<String, dynamic> dashboardMap = {};
    List<String> localSubAccounts = [];
    for (var subAccount in subAccounts) {
      localSubAccounts.add(subAccount['name']);
    }
    for (var subAccount in localSubAccounts) {
      var dashboardData = await ApiClient.get(
          'api/v1/pools/sub_account/summary/?sub_account_name=' + subAccount);

      List<dynamic> hashrateData = await Future.wait([
        _fetchHashrate(subAccount, '10MIN'),
        _fetchHashrate(subAccount, 'HOUR'),
        _fetchHashrate(subAccount, 'DAY'),
      ]);

      dashboardMap[subAccount] = {
        'dashboardData': dashboardData,
        'hashrateData': hashrateData,
      };
    }
    await storeDataInHive(dashboardMap);
    return dashboardMap;
  }

//================================================================================================================================
  Future<dynamic> _fetchHashrate(String subAccount, String interval) async {
    return await ApiClient.get(
        'api/v1/pools/sub_account/observer/hashrate_chart/?interval=$interval&with_dates=true&sub_account_name=$subAccount');
  }

//================================================================================================================================
  Future<Map<String, dynamic>> updateSubAccountData(
      String subAccountName, Map<String, dynamic> dashboardMap) async {
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
    if (dashboardMap.containsKey(subAccountName)) {
      dashboardMap[subAccountName] = subAccountData;
    } else {
      dashboardMap.putIfAbsent(subAccountName, () => subAccountData);
    }
    return dashboardMap;
  }
  //================================================================================================================================

  Future<void> storeDataInHive(Map<String, dynamic> dashboardMap) async {
    final box = await Hive.openBox('dashboardBox');

    await box.clear();

    for (var entry in dashboardMap.entries) {
      await box.put(entry.key, entry.value);
    }
  }

//================================================================================================================================
  Future<Map<String, dynamic>> getDataFromHive() async {
    final box = await Hive.openBox('dashboardBox');

    Map<String, dynamic> dashboardMap = {};
    for (var key in box.keys) {
      dashboardMap[key] = box.get(key);
    }

    return dashboardMap;
  }
//================================================================================================================================
}
