import 'package:bloc/bloc.dart';
import 'package:btcpool_app/api/api.dart';
import 'package:btcpool_app/api/api_utils.dart';
import 'package:btcpool_app/app/screens/dashboard/functions/functions.dart';
import 'package:meta/meta.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(DashboardInitial()) {
    int selectedSubAccount = 0;
    var data;
    var dashboardData;
    var hashrates;
    var strumUrls;
    var allData;
    int selectedInterval = 0;
    on<DashboardEvent>((event, emit) async {
      void emitAllDataState() {
        emit(DashboardLoaded(
            selectedInterval: selectedInterval,
            strumUrls: strumUrls,
            dashboardData: allData[data[selectedSubAccount]['name']]
                ['dashboardData']['data'],
            subAccounts: data,
            hashrates: allData[data[selectedSubAccount]['name']]['hashrateData']
                [selectedInterval]['hashrates'],
            selectedSubAccout: selectedSubAccount));
      }

      if (event is DashboardLoad) {
        data = await ApiClient.get('api/v1/pools/sub_account/all/');
        selectedSubAccount = await AuthUtils.getIndexSubAccount();
        if (data[selectedSubAccount] == null) {
          selectedSubAccount = 0;
        }
        emit(DashboardLoaded(
          selectedInterval: selectedInterval,
          subAccounts: data,
          selectedSubAccout: selectedSubAccount,
          strumUrls: null,
          hashrates: null,
          dashboardData: null,
        ));

        if (strumUrls == null) {
          strumUrls = await ApiClient.get(
              'api/v1/pools/sub_account/stratum_url/?sub_account_name=' +
                  data[selectedSubAccount]['name']);
        }

        emit(DashboardLoaded(
          selectedInterval: selectedInterval,
          subAccounts: data,
          selectedSubAccout: selectedSubAccount,
          strumUrls: strumUrls,
          hashrates: null,
          dashboardData: null,
        ));
        dashboardData = await ApiClient.get(
            'api/v1/pools/sub_account/summary/?sub_account_name=' +
                data[selectedSubAccount]['name']);
        hashrates = await ApiClient.get(
            'api/v1/pools/sub_account/observer/hashrate_chart/?interval=10MIN&with_dates=true&sub_account_name=' +
                data[selectedSubAccount]['name']);

        emit(DashboardLoaded(
            selectedInterval: selectedInterval,
            strumUrls: strumUrls,
            hashrates: hashrates['hashrates'],
            dashboardData: dashboardData['data'],
            subAccounts: data,
            selectedSubAccout: selectedSubAccount));
        allData = await DashboardFunctions().fetchDashboardData(data);
      }
      if (event is DashboardChooseInterval) {
        selectedInterval = event.index;
        String interval = '10MIN';
        if (selectedInterval == 0) {
          interval = '10MIN';
        } else if (selectedInterval == 1) {
          interval = 'HOUR';
        } else {
          interval = 'DAY';
        }
        if (allData == null) {
          emit(DashboardLoaded(
              selectedInterval: selectedInterval,
              strumUrls: strumUrls,
              dashboardData: dashboardData['data'],
              subAccounts: data,
              hashrates: null,
              selectedSubAccout: selectedSubAccount));
          hashrates = await ApiClient.get(
              'api/v1/pools/sub_account/observer/hashrate_chart/?interval=' +
                  interval +
                  '&with_dates=true&sub_account_name=' +
                  data[selectedSubAccount]['name']);
          emit(DashboardLoaded(
              selectedInterval: selectedInterval,
              strumUrls: strumUrls,
              dashboardData: dashboardData['data'],
              subAccounts: data,
              hashrates: hashrates['hashrates'],
              selectedSubAccout: selectedSubAccount));
        } else {
          emitAllDataState();
        }
      }
      if (event is DashboardChooseSubAccount) {
        selectedSubAccount = event.index;
        await AuthUtils.setIndexSubAccount(selectedSubAccount);
        selectedInterval = 0;
        if (allData == null) {
          emit(DashboardLoaded(
              selectedInterval: selectedInterval,
              strumUrls: strumUrls,
              dashboardData: null,
              subAccounts: data,
              hashrates: null,
              selectedSubAccout: selectedSubAccount));
          dashboardData = await ApiClient.get(
              'api/v1/pools/sub_account/summary/?sub_account_name=' +
                  data[selectedSubAccount]['name']);
          hashrates = await ApiClient.get(
              'api/v1/pools/sub_account/observer/hashrate_chart/?interval=' +
                  '10MIN' +
                  '&with_dates=true&sub_account_name=' +
                  data[selectedSubAccount]['name']);

          emit(DashboardLoaded(
              selectedInterval: selectedInterval,
              strumUrls: strumUrls,
              dashboardData: dashboardData['data'],
              subAccounts: data,
              hashrates: hashrates['hashrates'],
              selectedSubAccout: selectedSubAccount));
        } else {
          emitAllDataState();
          allData = await DashboardFunctions()
              .updateSubAccountData(data[selectedSubAccount]['name'], allData);
          emitAllDataState();
        }
      }
      if (event is DashboardLoadCache) {
        selectedInterval = 0;
        if (allData == null) {
          emit(DashboardLoaded(
              selectedInterval: selectedInterval,
              strumUrls: strumUrls,
              dashboardData: dashboardData['data'],
              subAccounts: data,
              hashrates: hashrates['hashrates'],
              selectedSubAccout: selectedSubAccount));
          data = await ApiClient.get('api/v1/pools/sub_account/all/');
          hashrates = await ApiClient.get(
              'api/v1/pools/sub_account/observer/hashrate_chart/?interval=10MIN&with_dates=true&sub_account_name=' +
                  data[selectedSubAccount]['name']);
          dashboardData = await ApiClient.get(
              'api/v1/pools/sub_account/summary/?sub_account_name=' +
                  data[selectedSubAccount]['name']);
          emit(DashboardLoaded(
              selectedInterval: selectedInterval,
              strumUrls: strumUrls,
              dashboardData: dashboardData['data'],
              subAccounts: data,
              hashrates: hashrates['hashrates'],
              selectedSubAccout: selectedSubAccount));
        } else {
          emitAllDataState();
          allData = await DashboardFunctions()
              .updateSubAccountData(data[selectedSubAccount]['name'], allData);
          emitAllDataState();
        }
      }
      if (event is DashboardUpdateSubaccounts) {
        data = await ApiClient.get('api/v1/pools/sub_account/all/');
        selectedSubAccount = await AuthUtils.getIndexSubAccount();
        if (data[selectedSubAccount] == null) {
          selectedSubAccount = 0;
        }
        emit(DashboardLoaded(
            selectedInterval: selectedInterval,
            strumUrls: strumUrls,
            dashboardData: dashboardData['data'],
            subAccounts: data,
            hashrates: hashrates['hashrates'],
            selectedSubAccout: selectedSubAccount));
      }
    });
  }
}
