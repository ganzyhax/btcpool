import 'package:bloc/bloc.dart';
import 'package:btcpool_app/api/api.dart';
import 'package:btcpool_app/api/api_utils.dart';
import 'package:btcpool_app/app/screens/dashboard/bloc/dashboard_bloc.dart';
import 'package:btcpool_app/app/screens/revenue/function/functions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'revenue_event.dart';
part 'revenue_state.dart';

class RevenueBloc extends Bloc<RevenueEvent, RevenueState> {
  RevenueBloc() : super(RevenueInitial()) {
    List displayEarningsDate = [];
    List displayPayoutsDate = [];
    List resEarningsDate = [];
    List resPayoutsDate = [];
    var earningsData = [];
    var payoutsData = [];
    var accountsData = [];
    bool isLoading = false;
    on<RevenueEvent>((event, emit) async {
      if (event is RevenueLoad) {
        displayEarningsDate = [
          RevenueFunctions().getTodayDateFormatted(),
          RevenueFunctions().getTodayDateFormatted()
        ];
        displayPayoutsDate = [
          RevenueFunctions().getTodayDateFormatted(),
          RevenueFunctions().getTodayDateFormatted()
        ];
        resEarningsDate =
            RevenueFunctions().convertResultDate(displayEarningsDate);

        resPayoutsDate =
            RevenueFunctions().convertResultDate(displayPayoutsDate);
        isLoading = true;
        emit(RevenueLoaded(
            isLoading: isLoading,
            earningsData: earningsData,
            payoutsData: payoutsData,
            displayEarningsDate: displayEarningsDate,
            displayPayoutsDate: displayPayoutsDate));
        accountsData = await ApiClient.get('api/v1/pools/sub_account/all/');
        int selectedSubAccount = await AuthUtils.getIndexSubAccount();
        if (accountsData[selectedSubAccount] == null) {
          selectedSubAccount = 0;
        }

        earningsData = await ApiClient.get(
            'api/v1/pools/sub_account/earnings/?sub_account_name=' +
                accountsData[selectedSubAccount]['name']);
        payoutsData = await ApiClient.get(
            'api/v1/pools/sub_account/payouts/?sub_account_name=' +
                accountsData[selectedSubAccount]['name']);

        isLoading = false;
        emit(RevenueLoaded(
            isLoading: isLoading,
            earningsData: earningsData,
            payoutsData: payoutsData,
            displayEarningsDate: displayEarningsDate,
            displayPayoutsDate: displayPayoutsDate));
      }
      if (event is RevenueSetEarningsPickedDates) {
        int selectedSubAccount = await AuthUtils.getIndexSubAccount();
        displayEarningsDate = event.data;
        resEarningsDate =
            RevenueFunctions().convertResultDate(displayEarningsDate);
        earningsData = await ApiClient.get(
            'api/v1/pools/sub_account/earnings/?sub_account_name=' +
                accountsData[selectedSubAccount]['name']);
        emit(RevenueLoaded(
            isLoading: isLoading,
            earningsData: earningsData,
            payoutsData: payoutsData,
            displayEarningsDate: displayEarningsDate,
            displayPayoutsDate: displayPayoutsDate));
      }
      if (event is RevenueSetPayoutsPickedDates) {
        int selectedSubAccount = await AuthUtils.getIndexSubAccount();

        displayPayoutsDate = event.data;
        resPayoutsDate =
            RevenueFunctions().convertResultDate(displayPayoutsDate);
        payoutsData = await ApiClient.get(
            'api/v1/pools/sub_account/payouts/?sub_account_name=' +
                accountsData[selectedSubAccount]['name']);
        emit(RevenueLoaded(
            earningsData: earningsData,
            isLoading: isLoading,
            payoutsData: payoutsData,
            displayEarningsDate: displayEarningsDate,
            displayPayoutsDate: displayPayoutsDate));
      }
      if (event is RevenueSubAccountIndexChange) {
        if (accountsData.length == 0 || resEarningsDate.length == 0) {
          accountsData = await ApiClient.get('api/v1/pools/sub_account/all/');
          displayEarningsDate = [
            RevenueFunctions().getTodayDateFormatted(),
            RevenueFunctions().getTodayDateFormatted()
          ];
          displayPayoutsDate = [
            RevenueFunctions().getTodayDateFormatted(),
            RevenueFunctions().getTodayDateFormatted()
          ];
          resEarningsDate =
              RevenueFunctions().convertResultDate(displayEarningsDate);

          resPayoutsDate =
              RevenueFunctions().convertResultDate(displayPayoutsDate);
        }
        earningsData = await ApiClient.get(
            'api/v1/pools/sub_account/earnings/?sub_account_name=' +
                accountsData[event.index]['name']);
        payoutsData = await ApiClient.get(
            'api/v1/pools/sub_account/payouts/?sub_account_name=' +
                accountsData[event.index]['name']);
        emit(RevenueLoaded(
            earningsData: earningsData,
            isLoading: isLoading,
            payoutsData: payoutsData,
            displayEarningsDate: displayEarningsDate,
            displayPayoutsDate: displayPayoutsDate));
      }
      if (event is RevenueLoadEarnings) {
        int selectedSubAccount = await AuthUtils.getIndexSubAccount();
        earningsData = await ApiClient.get(
            'api/v1/pools/sub_account/earnings/?sub_account_name=' +
                accountsData[selectedSubAccount]['name']);
        emit(RevenueLoaded(
            earningsData: earningsData,
            payoutsData: payoutsData,
            isLoading: isLoading,
            displayEarningsDate: displayEarningsDate,
            displayPayoutsDate: displayPayoutsDate));
      }
      if (event is RevenueLoadPayouts) {
        int selectedSubAccount = await AuthUtils.getIndexSubAccount();
        payoutsData = await ApiClient.get(
            'api/v1/pools/sub_account/payouts/?sub_account_name=' +
                accountsData[selectedSubAccount]['name']);
        emit(RevenueLoaded(
            earningsData: earningsData,
            payoutsData: payoutsData,
            isLoading: isLoading,
            displayEarningsDate: displayEarningsDate,
            displayPayoutsDate: displayPayoutsDate));
      }
    });
  }
}
