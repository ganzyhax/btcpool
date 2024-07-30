import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:btcpool_app/api/api.dart';
import 'package:btcpool_app/api/api_utils.dart';

part 'workers_event.dart';
part 'workers_state.dart';

class WorkersBloc extends Bloc<WorkersEvent, WorkersState> {
  WorkersBloc() : super(WorkersInitial()) {
    int selectedTab = 0;
    var searchedTabs = [];
    var tabs = [[], [], [], []];
    var accountsData;
    bool isLoading = false;
    String searchText = '';
    on<WorkersEvent>((event, emit) async {
      if (event is WorkersLoad) {
        log('Load workers');
        tabs = [[], [], [], []];
        var allList = [];
        var deadList = [];
        var offlineList = [];
        var onlineList = [];
        isLoading = true;
        emit(WorkersLoaded(
            selectedTab: selectedTab, tabs: tabs, isLoading: isLoading));

        accountsData ??= await ApiClient.get('api/v1/sub_accounts/all/');
        int selectedSubAccount = await AuthUtils.getIndexSubAccount();
        log('Workers trying to get account Data ' +
            accountsData[selectedSubAccount]['name']);
        if (accountsData != null) {
          try {
            var dataList = await ApiClient.get(
                'api/v1/sub_accounts/workers/?sub_account_name=' +
                    accountsData[selectedSubAccount]['name']);

            for (var data in dataList) {
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
            tabs[3] = deadList;
            isLoading = false;
            emit(WorkersLoaded(
                selectedTab: selectedTab, tabs: tabs, isLoading: isLoading));
          } catch (e) {
            emit(WorkersLoaded(
                selectedTab: selectedTab, tabs: tabs, isLoading: isLoading));
          }
        } else {
          emit(WorkersLoaded(
              selectedTab: selectedTab, tabs: tabs, isLoading: isLoading));
        }
      }
      if (event is WorkersChangeIndex) {
        selectedTab = event.index;
        if (searchText == '') {
          emit(WorkersLoaded(
              selectedTab: selectedTab, tabs: tabs, isLoading: isLoading));
        } else {
          if (searchedTabs.isNotEmpty) {
            emit(WorkersLoaded(
                selectedTab: selectedTab,
                tabs: searchedTabs,
                isLoading: isLoading));
          } else {
            emit(WorkersLoaded(
                selectedTab: selectedTab, tabs: tabs, isLoading: isLoading));
          }
        }
      }
      if (event is WorkersSubAccountIndexChange) {
        var allList = [];
        var deadList = [];
        var onlineList = [];
        isLoading = true;
        emit(WorkersLoaded(
            selectedTab: selectedTab, tabs: tabs, isLoading: isLoading));

        accountsData ??= await ApiClient.get('api/v1/sub_accounts/all/');
        try {
          var dataList = await ApiClient.get(
              'api/v1/sub_accounts/workers/?sub_account_name=' +
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
            selectedTab: selectedTab, tabs: tabs, isLoading: isLoading));
      }
      if (event is WorkersClear) {
        emit(WorkersInitial());
      }
      if (event is WorkersSubaccountUpdate) {
        accountsData = await ApiClient.get('api/v1/sub_accounts/all/');
      }
      if (event is WorkersRefresh) {
        var allList = [];
        var deadList = [];
        var offlineList = [];
        var onlineList = [];
        accountsData ??= await ApiClient.get('api/v1/sub_accounts/all/');
        int selectedSubAccount = await AuthUtils.getIndexSubAccount();
        if (accountsData != null) {
          try {
            var dataList = await ApiClient.get(
                'api/v1/sub_accounts/workers/?sub_account_name=' +
                    accountsData[selectedSubAccount]['name']);

            for (var data in dataList) {
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
            tabs[3] = deadList;
            isLoading = false;
            emit(WorkersLoaded(
                selectedTab: selectedTab, tabs: tabs, isLoading: isLoading));
          } catch (e) {
            emit(WorkersLoaded(
                selectedTab: selectedTab, tabs: tabs, isLoading: isLoading));
          }
        } else {
          emit(WorkersLoaded(
              selectedTab: selectedTab, tabs: tabs, isLoading: isLoading));
        }
      }
      if (event is WorkersSearch) {
        searchedTabs = [[], [], [], []];
        searchText = event.value;
        if (searchText == '') {
          emit(WorkersLoaded(
              selectedTab: selectedTab, tabs: tabs, isLoading: isLoading));
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
              tabs: searchedTabs,
              isLoading: isLoading));
        }
      }
    });
  }
}
