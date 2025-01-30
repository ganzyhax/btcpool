import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:btcpool_app/api/api.dart';
import 'package:btcpool_app/api/api_utils.dart';
import 'package:meta/meta.dart';

part 'workers_event.dart';
part 'workers_state.dart';

class WorkersBloc extends Bloc<WorkersEvent, WorkersState> {
  WorkersBloc() : super(WorkersInitial()) {
    int selectedTab = 0;
    var searchedTabs = [];
    var dashboardData;
    var tabs = [[], [], []];
    var accountsData;
    bool isLoading = false;
    String searchText = '';
    int sortingIndex = -1;
    String selectedSubAccountCurrency = 'BTC';
    on<WorkersEvent>((event, emit) async {
      if (event is WorkersLoad) {
        tabs = [[], [], [], []];
        var allList = [];
        var deadList = [];
        var offlineList = [];
        var onlineList = [];
        isLoading = true;
        emit(WorkersLoaded(
            selectedTab: selectedTab,
            tabs: tabs,
            selectedSubAccountCurrency: selectedSubAccountCurrency,
            isLoading: isLoading,
            sortingIndex: sortingIndex,
            dashboardData: dashboardData));

        if (accountsData == null) {
          accountsData = await ApiClient.get('api/v1/pools/sub_account/all/');
        }
        int selectedSubAccount = await AuthUtils.getIndexSubAccount();
        log('Workers trying to get account Data ' +
            accountsData[selectedSubAccount]['name']);

        if (accountsData != null) {
          try {
            selectedSubAccountCurrency =
                accountsData[selectedSubAccount]['crypto_currency'];
            var dataList = await ApiClient.get(
                'api/v1/pools/sub_account/workers/?sub_account_name=' +
                    accountsData[selectedSubAccount]['name']);

            for (var data in dataList) {
              log(data.toString());
              if (data['status'] == 'DEAD') {
                deadList.add(data);
              } else if (data['status'] == 'ONLINE') {
                onlineList.add(data);
              } else {
                offlineList.add(data);
              }
              allList.add(data);
            }

            tabs[0] = allList;
            tabs[1] = onlineList;
            tabs[2] = offlineList;
            log('Getting data fow workers' +
                accountsData[selectedSubAccount]['name']);
            dashboardData = await ApiClient.get(
                'api/v1/pools/sub_account/summary/?sub_account_name=' +
                    accountsData[selectedSubAccount]['name']);
            log(dashboardData.toString());
            isLoading = false;
            emit(WorkersLoaded(
                selectedTab: selectedTab,
                tabs: tabs,
                selectedSubAccountCurrency: selectedSubAccountCurrency,
                sortingIndex: sortingIndex,
                isLoading: isLoading,
                dashboardData: dashboardData));
          } catch (e) {
            log(e.toString());
            if (e.toString().contains('SynchronousOnlyOperation')) {
              add(WorkersLoad());
            }

            emit(WorkersLoaded(
                selectedTab: selectedTab,
                tabs: tabs,
                sortingIndex: sortingIndex,
                isLoading: isLoading,
                selectedSubAccountCurrency: selectedSubAccountCurrency,
                dashboardData: dashboardData));
          }
        } else {
          log('nmo datata');
          emit(WorkersLoaded(
              selectedTab: selectedTab,
              tabs: tabs,
              selectedSubAccountCurrency: selectedSubAccountCurrency,
              sortingIndex: sortingIndex,
              isLoading: isLoading,
              dashboardData: dashboardData));
        }
      }
      if (event is WorkersChangeIndex) {
        selectedTab = event.index;
        if (searchText == '') {
          emit(WorkersLoaded(
              selectedTab: selectedTab,
              tabs: tabs,
              isLoading: isLoading,
              sortingIndex: sortingIndex,
              selectedSubAccountCurrency: selectedSubAccountCurrency,
              dashboardData: dashboardData));
        } else {
          if (searchedTabs.length != 0) {
            emit(WorkersLoaded(
                selectedTab: selectedTab,
                sortingIndex: sortingIndex,
                tabs: tabs,
                isLoading: isLoading,
                selectedSubAccountCurrency: selectedSubAccountCurrency,
                dashboardData: dashboardData));
          } else {
            emit(WorkersLoaded(
                selectedTab: selectedTab,
                sortingIndex: sortingIndex,
                tabs: tabs,
                isLoading: isLoading,
                selectedSubAccountCurrency: selectedSubAccountCurrency,
                dashboardData: dashboardData));
          }
        }
      }
      if (event is WorkersSubAccountIndexChange) {
        tabs = [[], [], []];
        var allList = [];
        var deadList = [];
        var onlineList = [];
        isLoading = true;
        emit(WorkersLoaded(
            selectedTab: selectedTab,
            sortingIndex: sortingIndex,
            selectedSubAccountCurrency: selectedSubAccountCurrency,
            tabs: tabs,
            isLoading: isLoading,
            dashboardData: dashboardData));

        if (accountsData == null) {
          accountsData = await ApiClient.get('api/v1/pools/sub_account/all/');
        }
        int selectedSubAccount = await AuthUtils.getIndexSubAccount();

        dashboardData = await ApiClient.get(
            'api/v1/pools/sub_account/summary/?sub_account_name=' +
                accountsData[selectedSubAccount]['name']);
        selectedSubAccountCurrency =
            accountsData[selectedSubAccount]['crypto_currency'];
        try {
          var dataList = await ApiClient.get(
              'api/v1/pools/sub_account/workers/?sub_account_name=' +
                  accountsData[event.index]['name']);

          for (var data in dataList) {
            if (data['status'] == 'DEAD') {
              deadList.add(data);
            } else if (data['status'] == 'ONLINE') {
              onlineList.add(data);
            }
            allList.add(data);
          }

          tabs[0] = allList;
          tabs[1] = onlineList;
          tabs[2] = deadList;
          isLoading = false;
        } catch (e) {
          isLoading = false;
        }
        emit(WorkersLoaded(
            selectedTab: selectedTab,
            tabs: tabs,
            sortingIndex: sortingIndex,
            isLoading: isLoading,
            selectedSubAccountCurrency: selectedSubAccountCurrency,
            dashboardData: dashboardData));
      }
      if (event is WorkersClear) {
        emit(WorkersInitial());
      }
      if (event is WorkersSubaccountUpdate) {
        accountsData = await ApiClient.get('api/v1/pools/sub_account/all/');
      }
      if (event is WorkersRefresh) {
        var allList = [];
        var deadList = [];
        var offlineList = [];
        var onlineList = [];
        if (accountsData == null) {
          accountsData = await ApiClient.get('api/v1/pools/sub_account/all/');
        }
        int selectedSubAccount = await AuthUtils.getIndexSubAccount();
        if (accountsData != null) {
          try {
            var dataList = await ApiClient.get(
                'api/v1/pools/sub_account/workers/?sub_account_name=' +
                    accountsData[selectedSubAccount]['name']);

            for (var data in dataList) {
              if (data['status'] == 'DEAD') {
                offlineList.add(data);
              } else if (data['status'] == 'ONLINE') {
                onlineList.add(data);
              } else {
                offlineList.add(data);
              }
              allList.add(data);
            }

            tabs[0] = allList;
            tabs[1] = onlineList;
            tabs[2] = offlineList;
            tabs[3] = deadList;
            isLoading = false;
            emit(WorkersLoaded(
                selectedTab: selectedTab,
                tabs: tabs,
                sortingIndex: sortingIndex,
                isLoading: isLoading,
                selectedSubAccountCurrency: selectedSubAccountCurrency,
                dashboardData: dashboardData));
          } catch (e) {
            emit(WorkersLoaded(
                selectedTab: selectedTab,
                tabs: tabs,
                sortingIndex: sortingIndex,
                isLoading: isLoading,
                selectedSubAccountCurrency: selectedSubAccountCurrency,
                dashboardData: dashboardData));
          }
        } else {
          emit(WorkersLoaded(
              selectedTab: selectedTab,
              tabs: tabs,
              sortingIndex: sortingIndex,
              isLoading: isLoading,
              selectedSubAccountCurrency: selectedSubAccountCurrency,
              dashboardData: dashboardData));
        }
      }
      if (event is WorkersSearch) {
        searchedTabs = [[], [], [], []];
        searchText = event.value;
        if (searchText == '') {
          emit(WorkersLoaded(
              selectedTab: selectedTab,
              sortingIndex: sortingIndex,
              tabs: tabs,
              selectedSubAccountCurrency: selectedSubAccountCurrency,
              isLoading: isLoading,
              dashboardData: dashboardData));
        } else {
          searchedTabs = [...tabs];
          for (var i = 0; i < tabs.length; i++) {
            searchedTabs[i] = tabs[i]
                .where((data) => (data['worker_name'] as String)
                    .toLowerCase()
                    .startsWith(searchText.toLowerCase()))
                .toList();
          }
          emit(WorkersLoaded(
              selectedTab: selectedTab,
              tabs: tabs,
              selectedSubAccountCurrency: selectedSubAccountCurrency,
              sortingIndex: sortingIndex,
              isLoading: isLoading,
              dashboardData: dashboardData));
        }
      }
      if (event is WorkersSortByHour) {
        log(tabs[selectedTab].toString());
        bool isDesc = (sortingIndex == 0) ? false : true;
        tabs[selectedTab].sort((a, b) {
          double valueA = (a['hashrate_1h'] ?? 0.0).toDouble();
          double valueB = (b['hashrate_1h'] ?? 0.0).toDouble();
          return isDesc ? valueB.compareTo(valueA) : valueA.compareTo(valueB);
        });

        if (sortingIndex != 0) {
          sortingIndex = 0;
        } else {
          sortingIndex = -1;
        }
        emit(WorkersLoaded(
            selectedTab: selectedTab,
            tabs: tabs,
            sortingIndex: sortingIndex,
            isLoading: isLoading,
            selectedSubAccountCurrency: selectedSubAccountCurrency,
            dashboardData: dashboardData));
      }
      if (event is WorkersSortByDay) {
        bool isDesc = (sortingIndex == 1) ? false : true;
        tabs[selectedTab].sort((a, b) {
          double valueA = (a['hashrate_24h'] ?? 0.0).toDouble();
          double valueB = (b['hashrate_24h'] ?? 0.0).toDouble();
          return isDesc ? valueB.compareTo(valueA) : valueA.compareTo(valueB);
        });
        if (sortingIndex != 1) {
          sortingIndex = 1;
        } else {
          sortingIndex = -1;
        }
        emit(WorkersLoaded(
            selectedTab: selectedTab,
            tabs: tabs,
            sortingIndex: sortingIndex,
            isLoading: isLoading,
            selectedSubAccountCurrency: selectedSubAccountCurrency,
            dashboardData: dashboardData));
      }
    });
  }
}
