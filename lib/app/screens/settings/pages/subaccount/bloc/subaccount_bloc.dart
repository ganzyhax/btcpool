import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:btcpool_app/api/api.dart';
import 'package:meta/meta.dart';

part 'subaccount_event.dart';
part 'subaccount_state.dart';

class SubaccountBloc extends Bloc<SubaccountEvent, SubaccountState> {
  SubaccountBloc() : super(SubaccountInitial()) {
    String method = 'FPPS';
    List selectedSubAccounts = [];
    bool isLoading = false;
    bool isCheck = false;
    bool isShowAddField = true;
    var filteredSubAccounts = [];
    var accountsData = [];
    on<SubaccountEvent>((event, emit) async {
      if (event is SubaccountLoad) {
        selectedSubAccounts = [];
        isLoading = false;
        isCheck = false;
        isShowAddField = true;
        accountsData = await ApiClient.get('api/v1/pools/sub_account/all/');
        emit(SubaccountLoaded(
            accountsData: accountsData,
            filteredSubAccounts: filteredSubAccounts,
            isShowAddField: isShowAddField,
            isLoading: isLoading,
            isCheck: isCheck,
            selectedSubAccounts: selectedSubAccounts));
      }

      if (event is SubaccountSetMethod) {
        method = event.method;
      }
      if (event is SubaccountNewCreate) {
        isLoading = true;
        emit(SubaccountLoaded(
            isShowAddField: isShowAddField,
            isLoading: isLoading,
            accountsData: accountsData,
            filteredSubAccounts: filteredSubAccounts,
            isCheck: isCheck,
            selectedSubAccounts: selectedSubAccounts));
        var data = await ApiClient.post(
            'api/v1/pools/sub_account/create/',
            {
              'crypto_currency': "BTC",
              'earning_scheme_id': (method == 'FPPS') ? 1 : 2,
              'name': event.name,
              'wallet_address': event.wallet + '\t',
            },
            withBadRequest: false);
        if (data.containsKey('title')) {
          emit(SubaccountNewError(message: data['title']));
          isLoading = false;
          emit(SubaccountLoaded(
            isCheck: isCheck,
            accountsData: accountsData,
            isShowAddField: isShowAddField,
            selectedSubAccounts: selectedSubAccounts,
            isLoading: isLoading,
            filteredSubAccounts: filteredSubAccounts,
          ));
        } else {
          emit(SubaccountNewSuccess(
              message: 'Created successfully!', newSubAccount: event.name));
          add(SubaccountLoad());
        }
      }

      ///new create end
      ///
      ///
      ///
      ///
      if (event is SubaccountCreate) {
        isLoading = true;
        emit(SubaccountLoaded(
            isShowAddField: isShowAddField,
            isLoading: isLoading,
            accountsData: accountsData,
            filteredSubAccounts: filteredSubAccounts,
            isCheck: isCheck,
            selectedSubAccounts: selectedSubAccounts));
        var data = await ApiClient.post(
            'api/v1/sub_accounts/create/',
            (selectedSubAccounts.isNotEmpty)
                ? {
                    'crypto_currency': "BTC",
                    'earning_scheme_id': (method == 'FPPS') ? 2 : 2,
                    'name': event.name,
                    'wallet_address': event.wallet,
                    'virtual_sub_accounts': selectedSubAccounts
                  }
                : {
                    'crypto_currency': "BTC",
                    'earning_scheme_id': (method == 'FPPS') ? 2 : 2,
                    'name': event.name,
                    'wallet_address': event.wallet,
                  },
            withBadRequest: true);
        if (data.containsKey('title')) {
          emit(SubaccountError(message: data['title']));
          isLoading = false;
          emit(SubaccountLoaded(
            isCheck: isCheck,
            accountsData: accountsData,
            isShowAddField: isShowAddField,
            selectedSubAccounts: selectedSubAccounts,
            isLoading: isLoading,
            filteredSubAccounts: filteredSubAccounts,
          ));
        } else if (data.containsKey('detail')) {
          emit(SubaccountError(message: data['detail']));
          isLoading = false;
          emit(SubaccountLoaded(
            isCheck: isCheck,
            accountsData: accountsData,
            isShowAddField: isShowAddField,
            selectedSubAccounts: selectedSubAccounts,
            isLoading: isLoading,
            filteredSubAccounts: filteredSubAccounts,
          ));
        } else {
          emit(SubaccountSuccess(
              message: 'Created successfully!', newSubAccount: event.name));
          add(SubaccountLoad());
        }
      }
      if (event is SubaccountCheckSplit) {
        isCheck = event.value;
        emit(SubaccountLoaded(
          isShowAddField: isShowAddField,
          isCheck: isCheck,
          accountsData: accountsData,
          selectedSubAccounts: selectedSubAccounts,
          isLoading: isLoading,
          filteredSubAccounts: filteredSubAccounts,
        ));
      }
      if (event is SubaccountAddSubAccount) {
        selectedSubAccounts.add(event.data);
        emit(SubaccountLoaded(
          accountsData: accountsData,
          isShowAddField: isShowAddField,
          isCheck: isCheck,
          selectedSubAccounts: selectedSubAccounts,
          isLoading: isLoading,
          filteredSubAccounts: filteredSubAccounts,
        ));
      }
      if (event is SubaccountDeleteSubAccount) {
        selectedSubAccounts.removeAt(event.index);
        emit(SubaccountLoaded(
          isCheck: isCheck,
          accountsData: accountsData,
          filteredSubAccounts: filteredSubAccounts,
          isShowAddField: isShowAddField,
          selectedSubAccounts: selectedSubAccounts,
          isLoading: isLoading,
        ));
      }
      if (event is SubaccountShowSplitField) {
        if (isShowAddField) {
          isShowAddField = false;
        } else {
          isShowAddField = true;
        }
        emit(SubaccountLoaded(
          isCheck: isCheck,
          accountsData: accountsData,
          filteredSubAccounts: filteredSubAccounts,
          isShowAddField: isShowAddField,
          selectedSubAccounts: selectedSubAccounts,
          isLoading: isLoading,
        ));
      }
      if (event is SubaccountSearch) {
        filteredSubAccounts = event.data;
        filteredSubAccounts = filteredSubAccounts
            .where((data) => (data['name'] as String)
                .toLowerCase()
                .startsWith(event.searchValue.toLowerCase()))
            .toList();
        emit(SubaccountLoaded(
          isCheck: isCheck,
          accountsData: accountsData,
          filteredSubAccounts: filteredSubAccounts,
          isShowAddField: isShowAddField,
          selectedSubAccounts: selectedSubAccounts,
          isLoading: isLoading,
        ));
      }
      if (event is SubaccountSplittedAccountUpdate) {
        isLoading = true;
        emit(SubaccountLoaded(
          isCheck: isCheck,
          accountsData: accountsData,
          filteredSubAccounts: filteredSubAccounts,
          isShowAddField: isShowAddField,
          selectedSubAccounts: selectedSubAccounts,
          isLoading: isLoading,
        ));
        var res = await ApiClient.post(
          'api/v1/sub_accounts/virtual_sub_accounts_update/',
          event.data,
        );
        isLoading = false;

        if (res.toString() == '') {
          emit(SubaccountUpdateSplittedSuccess(
              message: 'Success!', subAccount: event.data['name']));
          add(SubaccountLoad());
        } else {
          if (res.containsKey('error_code')) {
            emit(SubaccountError(message: res['title']));
            emit(SubaccountLoaded(
              isCheck: isCheck,
              accountsData: accountsData,
              filteredSubAccounts: filteredSubAccounts,
              isShowAddField: isShowAddField,
              selectedSubAccounts: selectedSubAccounts,
              isLoading: isLoading,
            ));
          } else {
            emit(SubaccountSuccess(
                message: 'Success!', newSubAccount: event.data['name']));
            emit(SubaccountLoaded(
              isCheck: isCheck,
              accountsData: accountsData,
              filteredSubAccounts: filteredSubAccounts,
              isShowAddField: isShowAddField,
              selectedSubAccounts: selectedSubAccounts,
              isLoading: isLoading,
            ));
          }
        }
      }
      if (event is SubaccountWalletAccountUpdate) {
        isLoading = true;
        emit(SubaccountLoaded(
          isCheck: isCheck,
          accountsData: accountsData,
          filteredSubAccounts: filteredSubAccounts,
          isShowAddField: isShowAddField,
          selectedSubAccounts: selectedSubAccounts,
          isLoading: isLoading,
        ));
        String name = event.data['name'];
        event.data.remove('name');
        var res = await ApiClient.patch(
          'api/v1/sub_accounts/sub_account_update/wallet_address/',
          event.data,
        );
        isLoading = false;
        print(res);
        if (res.toString() == '') {
          emit(SubaccountUpdateSplittedSuccess(
              message: 'Success!', subAccount: name));
          add(SubaccountLoad());
        } else {
          if (res.containsKey('error_code')) {
            emit(SubaccountError(message: res['title']));
            emit(SubaccountLoaded(
              isCheck: isCheck,
              accountsData: accountsData,
              filteredSubAccounts: filteredSubAccounts,
              isShowAddField: isShowAddField,
              selectedSubAccounts: selectedSubAccounts,
              isLoading: isLoading,
            ));
          } else {
            emit(SubaccountSuccess(message: 'Success!', newSubAccount: name));
            emit(SubaccountLoaded(
              isCheck: isCheck,
              accountsData: accountsData,
              filteredSubAccounts: filteredSubAccounts,
              isShowAddField: isShowAddField,
              selectedSubAccounts: selectedSubAccounts,
              isLoading: isLoading,
            ));
          }
        }
      }
    });
  }
}
