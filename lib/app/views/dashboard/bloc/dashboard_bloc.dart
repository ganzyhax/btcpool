import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:btcpool_app/api/api.dart';
import 'package:btcpool_app/api/api_utils.dart';
import 'package:btcpool_app/local_data/cache_data/cache_hive.dart';
import 'package:btcpool_app/local_data/user_data/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(DashboardInitial()) {
    int selectedSubAccount = 0;
    var data;
    var dashboardData;
    var hashrates;
    var strumUrls;

    double btcPrice = 60000;
    int selectedInterval = 0;
    on<DashboardEvent>((event, emit) async {
      void emitAllDataState({strumUrlss, hashratess, dashboardDatas}) {
        if (UserData().dataSubAccounts[selectedSubAccount] != null) {
          if (UserData().dashboardMap.containsKey(
              UserData().dataSubAccounts[selectedSubAccount]['name'])) {
            if (UserData().dashboardMap != null &&
                UserData().dashboardMap[UserData()
                        .dataSubAccounts[selectedSubAccount]['name']] !=
                    null &&
                UserData().dashboardMap[UserData().dataSubAccounts[selectedSubAccount]['name']]
                        ['hashrateData'] !=
                    null &&
                UserData().dashboardMap[UserData().dataSubAccounts[selectedSubAccount]['name']]
                        ['dashboardData'] !=
                    null &&
                UserData().dashboardMap[UserData().dataSubAccounts[selectedSubAccount]['name']]
                        ['hashrateData'][selectedInterval] !=
                    null &&
                UserData().dashboardMap[UserData().dataSubAccounts[selectedSubAccount]['name']]
                        ['hashrateData'][selectedInterval]['hashrates'] !=
                    null) {
              emit(DashboardLoaded(
                  btcPrice: btcPrice,
                  selectedInterval: selectedInterval,
                  strumUrls: strumUrlss,
                  dashboardData: UserData().dashboardMap[
                      UserData().dataSubAccounts[selectedSubAccount]
                          ['name']]['dashboardData'],
                  subAccounts: UserData().dataSubAccounts,
                  hashrates: UserData().dashboardMap[UserData()
                          .dataSubAccounts[selectedSubAccount]['name']]
                      ['hashrateData'][selectedInterval]['hashrates'],
                  selectedSubAccout: selectedSubAccount));
            } else {
              emit(DashboardLoaded(
                btcPrice: btcPrice,
                selectedInterval: selectedInterval,
                subAccounts: UserData().dataSubAccounts,
                selectedSubAccout: selectedSubAccount,
                strumUrls: strumUrlss,
                hashrates: hashratess,
                dashboardData: dashboardDatas,
              ));
            }
          } else {
            log('Dashboard NOT CACHE loaded ');
            emit(DashboardLoaded(
              btcPrice: btcPrice,
              selectedInterval: selectedInterval,
              subAccounts: UserData().dataSubAccounts,
              selectedSubAccout: selectedSubAccount,
              strumUrls: strumUrls,
              hashrates: hashratess,
              dashboardData: dashboardDatas,
            ));
          }
        } else {
          log('Dashboard NOT CACHE loaded ');
          emit(DashboardLoaded(
            btcPrice: btcPrice,
            selectedInterval: selectedInterval,
            subAccounts: UserData().dataSubAccounts,
            selectedSubAccout: selectedSubAccount,
            strumUrls: strumUrls,
            hashrates: hashratess,
            dashboardData: dashboardDatas,
          ));
        }
      }

      if (event is DashboardSubAccountCreateShowModal) {
        emit(DashboardShowingSubAccountModal());
      }
      if (event is DashboardLoad) {
        log("DashboardBloc Load started...");
        btcPrice = await ApiClient().fetchBTCPrice();
        await UserData().setLocalDashboardData();
        await UserData().setLocalSubaccountsData();
        data = await ApiClient.get('api/v1/pools/sub_account/all/');

        if (data != null) {
          if (data.length == 0) {
            emit(DashboardCreateSubAccountModal());
          } else {
            await LocalCache().storeSubAccountsDataInHive(data);
            try {
              selectedSubAccount = await AuthUtils.getIndexSubAccount();
              if (UserData().dataSubAccounts[selectedSubAccount] == null) {
                selectedSubAccount = 0;
              }
              emitAllDataState(
                  strumUrlss: null, hashratess: null, dashboardDatas: null);
              strumUrls ??= await ApiClient.get(
                  'api/v1/pools/sub_account/stratum_url/?sub_account_name=' +
                      UserData().dataSubAccounts[selectedSubAccount]['name']);
              emitAllDataState(
                  strumUrlss: strumUrls,
                  hashratess: null,
                  dashboardDatas: null);

              await UserData().updateSubAccountData(
                  UserData().dataSubAccounts[selectedSubAccount]['name']);

              emitAllDataState(
                  strumUrlss: strumUrls,
                  hashratess: hashrates,
                  dashboardDatas: dashboardData);
              await UserData().fetchDashboardData(data);
            } catch (e) {
              emit(DashboardInternetException());
              emitAllDataState();
            }
          }
        } else {
          emit(DashboardInternetException());
          emitAllDataState();
        }
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
        if (!UserData().dashboardMap.containsKey(
            UserData().dataSubAccounts[selectedSubAccount]['name'])) {
          emitAllDataState(
              hashratess: null,
              strumUrlss: strumUrls,
              dashboardDatas: dashboardData);
          try {
            hashrates = await ApiClient.get(
                'api/v1/pools/sub_account/observer/hashrate_chart/?interval=$interval&sub_account_name=' +
                    UserData().dataSubAccounts[selectedSubAccount]['name']);
            await UserData().setSingleHashrateData(
                UserData().dataSubAccounts[selectedSubAccount]['name'],
                hashrates,
                selectedInterval);
            emitAllDataState(
                hashratess: hashrates['hashrates'],
                dashboardDatas: dashboardData,
                strumUrlss: strumUrls);
          } catch (e) {
            emitAllDataState();
          }
        } else {
          emitAllDataState(
            hashratess: hashrates,
            strumUrlss: strumUrls,
            dashboardDatas: dashboardData,
          );
        }
      }
      if (event is DashboardChooseSubAccount) {
        selectedSubAccount = event.index;
        await AuthUtils.setIndexSubAccount(selectedSubAccount);
        selectedInterval = 0;
        if (!UserData().dashboardMap.containsKey(
            UserData().dataSubAccounts[selectedSubAccount]['name'])) {
          emitAllDataState(strumUrlss: strumUrls);
          try {
            dashboardData = await ApiClient.get(
                'api/v1/pools/sub_account/summary/?sub_account_name=' +
                    UserData().dataSubAccounts[selectedSubAccount]['name']);
            hashrates = await ApiClient.get(
                'api/v1/pools/sub_account/observer/hashrate_chart/?interval=1HOUR&with_dates=true&sub_account_name=' +
                    UserData().dataSubAccounts[selectedSubAccount]['name']);
            await UserData().setDashboardData(
              UserData().dataSubAccounts[selectedSubAccount]['name'],
              dashboardData,
            );

            await UserData().setSingleHashrateData(
                UserData().dataSubAccounts[selectedSubAccount]['name'],
                hashrates,
                0);
            emitAllDataState(
                strumUrlss: strumUrls,
                hashratess: hashrates['hashrates'],
                dashboardDatas: dashboardData);
          } catch (e) {
            emitAllDataState(
              strumUrlss: strumUrls,
            );
          }
        } else {
          emitAllDataState(
            dashboardDatas: dashboardData,
            strumUrlss: strumUrls,
            hashratess: hashrates,
          );
          try {
            await UserData().updateSubAccountData(
                UserData().dataSubAccounts[selectedSubAccount]['name']);
            emitAllDataState(
              dashboardDatas: dashboardData,
              strumUrlss: strumUrls,
              hashratess: hashrates,
            );
          } catch (e) {}
        }
      }
      if (event is DashboardLoadCache) {
        selectedInterval = 0;
        try {
          if (!UserData().dashboardMap.containsKey(
              UserData().dataSubAccounts[selectedSubAccount]['name'])) {
            emitAllDataState(
                hashratess: (hashrates == null) ? null : hashrates['hashrates'],
                dashboardDatas: dashboardData,
                strumUrlss: strumUrls);

            data = await ApiClient.get('api/v1/pools/sub_account/all/');
            await LocalCache().storeSubAccountsDataInHive(data);
            hashrates = await ApiClient.get(
                'api/v1/pools/sub_account/observer/hashrate_chart/?interval=1HOUR&with_dates=true&sub_account_name=' +
                    UserData().dataSubAccounts[selectedSubAccount]['name']);

            dashboardData = await ApiClient.get(
                'api/v1/pools/sub_account/summary/?sub_account_name=' +
                    UserData().dataSubAccounts[selectedSubAccount]['name']);

            emitAllDataState(
                hashratess: hashrates['hashrates'],
                dashboardDatas: dashboardData,
                strumUrlss: strumUrls);
          } else {
            emitAllDataState(
                hashratess: hashrates,
                dashboardDatas: dashboardData,
                strumUrlss: strumUrls);
            await UserData().updateSubAccountData(
                UserData().dataSubAccounts[selectedSubAccount]['name']);
            emitAllDataState(
                hashratess: hashrates,
                dashboardDatas: dashboardData,
                strumUrlss: strumUrls);
          }
        } catch (e) {
          emit(DashboardInternetException());
          emit(DashboardLoaded(
            btcPrice: btcPrice,
            selectedInterval: selectedInterval,
            subAccounts: null,
            selectedSubAccout: selectedSubAccount,
            strumUrls: null,
            hashrates: null,
            dashboardData: null,
          ));
        }
      }
      if (event is DashboardUpdateSubaccounts) {
        log("DashboardUpdateSubaccounts Load started...");
        data = await ApiClient.get('api/v1/pools/sub_account/all/');
        await LocalCache().storeSubAccountsDataInHive(data);
        selectedSubAccount = await AuthUtils.getIndexSubAccount();
        if (UserData().dataSubAccounts[selectedSubAccount] == null) {
          selectedSubAccount = 0;
        }
        strumUrls ??= await ApiClient.get(
            'api/v1/pools/sub_account/stratum_url/?sub_account_name=' +
                UserData().dataSubAccounts[selectedSubAccount]['name']);
        await UserData().addSubAccountData(event.subAccount);
        emitAllDataState(
            hashratess: hashrates,
            dashboardDatas: dashboardData,
            strumUrlss: strumUrls);
      }
      if (event is DashboardRefresh) {
        try {
          selectedSubAccount = await AuthUtils.getIndexSubAccount();

          bool isUpdated = await UserData().updateSubAccountData(
              UserData().dataSubAccounts[selectedSubAccount]['name']);
          if (isUpdated) {
            emitAllDataState(
                dashboardDatas: dashboardData,
                hashratess: hashrates,
                strumUrlss: strumUrls);
          }
        } catch (e) {
          emit(DashboardInternetException());
          emitAllDataState(
              dashboardDatas: dashboardData,
              hashratess: hashrates,
              strumUrlss: strumUrls);
        }
      }
      if (event is DashboardShowEvent) {
        emit(DashboardShowUpdate(withSkip: false));
      }
    });
  }
}
