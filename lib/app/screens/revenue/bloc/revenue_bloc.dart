import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:btcpool_app/api/api.dart';
import 'package:btcpool_app/api/api_utils.dart';
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
    var accountsData;
    bool isRLoading = false;
    bool isELoading = false;
    on<RevenueEvent>((event, emit) async {
      if (event is RevenueLoad) {
        displayEarningsDate = [
          RevenueFunctions().getFormattedDateMinusTenDays(),
          RevenueFunctions().getTodayDateFormatted()
        ];
        displayPayoutsDate = [
          RevenueFunctions().getFormattedDateMinusTenDays(),
          RevenueFunctions().getTodayDateFormatted()
        ];
        resEarningsDate =
            RevenueFunctions().convertResultDate(displayEarningsDate);

        resPayoutsDate =
            RevenueFunctions().convertResultDate(displayPayoutsDate);
        isRLoading = true;
        isELoading = true;
        emit(RevenueLoaded(
            isRLoading: isRLoading,
            isELoading: isELoading,
            earningsData: earningsData,
            payoutsData: payoutsData,
            displayEarningsDate: displayEarningsDate,
            displayPayoutsDate: displayPayoutsDate));
        accountsData =
            await ApiClient.get('api/v1/pools/sub_account/all/') ?? null;
        int selectedSubAccount = await AuthUtils.getIndexSubAccount();
        if (accountsData != null) {
          if (accountsData[selectedSubAccount] == null) {
            selectedSubAccount = 0;
          }
          log('Revenue trying to get account Data ' +
              accountsData[selectedSubAccount]['name']);
          earningsData = await ApiClient.get(
              '${'api/v1/pools/sub_account/earnings/?start_date=' + resEarningsDate[0] + '&end_date=' + resEarningsDate[1]}&sub_account_name=' +
                  accountsData[selectedSubAccount]['name']);
          payoutsData = await ApiClient.get(
              '${'api/v1/pools/sub_account/payouts/?start_date=' + resPayoutsDate[0] + '&end_date=' + resPayoutsDate[1]}&sub_account_name=' +
                  accountsData[selectedSubAccount]['name']);

          isRLoading = false;
          isELoading = false;
          emit(RevenueLoaded(
              isELoading: isELoading,
              isRLoading: isRLoading,
              earningsData: earningsData,
              payoutsData: payoutsData,
              displayEarningsDate: displayEarningsDate,
              displayPayoutsDate: displayPayoutsDate));
        } else {
          isRLoading = false;
          isELoading = false;
          emit(RevenueLoaded(
              isELoading: isELoading,
              isRLoading: isRLoading,
              earningsData: earningsData,
              payoutsData: payoutsData,
              displayEarningsDate: displayEarningsDate,
              displayPayoutsDate: displayPayoutsDate));
        }
      }
      if (event is RevenueSetEarningsPickedDates) {
        isELoading = true;
        emit(RevenueLoaded(
            isELoading: isELoading,
            isRLoading: isRLoading,
            earningsData: earningsData,
            payoutsData: payoutsData,
            displayEarningsDate: displayEarningsDate,
            displayPayoutsDate: displayPayoutsDate));
        int selectedSubAccount = await AuthUtils.getIndexSubAccount();
        displayEarningsDate = event.data;
        resEarningsDate =
            RevenueFunctions().convertResultDate(displayEarningsDate);
        earningsData = await ApiClient.get(
            '${'api/v1/pools/sub_account/earnings/?start_date=' + resEarningsDate[0] + '&end_date=' + resEarningsDate[1]}&sub_account_name=' +
                accountsData[selectedSubAccount]['name']);
        isELoading = false;

        emit(RevenueLoaded(
            isELoading: isELoading,
            isRLoading: isRLoading,
            earningsData: earningsData,
            payoutsData: payoutsData,
            displayEarningsDate: displayEarningsDate,
            displayPayoutsDate: displayPayoutsDate));
      }
      if (event is RevenueSetPayoutsPickedDates) {
        isRLoading = true;
        emit(RevenueLoaded(
            isRLoading: isRLoading,
            isELoading: isELoading,
            earningsData: earningsData,
            payoutsData: payoutsData,
            displayEarningsDate: displayEarningsDate,
            displayPayoutsDate: displayPayoutsDate));

        int selectedSubAccount = await AuthUtils.getIndexSubAccount();

        displayPayoutsDate = event.data;
        resPayoutsDate =
            RevenueFunctions().convertResultDate(displayPayoutsDate);
        payoutsData = await ApiClient.get(
            '${'api/v1/pools/sub_account/payouts/?start_date=' + resPayoutsDate[0] + '&end_date=' + resPayoutsDate[1]}&sub_account_name=' +
                accountsData[selectedSubAccount]['name']);
        isRLoading = false;

        emit(RevenueLoaded(
            earningsData: earningsData,
            isRLoading: isRLoading,
            isELoading: isELoading,
            payoutsData: payoutsData,
            displayEarningsDate: displayEarningsDate,
            displayPayoutsDate: displayPayoutsDate));
      }
      if (event is RevenueSubAccountIndexChange) {
        if (accountsData == null || resEarningsDate.isEmpty) {
          accountsData = await ApiClient.get('api/v1/pools/sub_account/all/');
          displayEarningsDate = [
            RevenueFunctions().getFormattedDateMinusTenDays(),
            RevenueFunctions().getTodayDateFormatted()
          ];
          displayPayoutsDate = [
            RevenueFunctions().getFormattedDateMinusTenDays(),
            RevenueFunctions().getTodayDateFormatted()
          ];
          resEarningsDate =
              RevenueFunctions().convertResultDate(displayEarningsDate);

          resPayoutsDate =
              RevenueFunctions().convertResultDate(displayPayoutsDate);
        }
        try {
          isRLoading = true;
          isELoading = true;
          emit(RevenueLoaded(
              earningsData: earningsData,
              isRLoading: isRLoading,
              isELoading: isELoading,
              payoutsData: payoutsData,
              displayEarningsDate: displayEarningsDate,
              displayPayoutsDate: displayPayoutsDate));
          earningsData = await ApiClient.get(
              '${'api/v1/pools/sub_account/earnings/?start_date=' + resEarningsDate[0] + '&end_date=' + resEarningsDate[1]}&sub_account_name=' +
                  accountsData[event.index]['name']);
          payoutsData = await ApiClient.get(
              '${'api/v1/pools/sub_account/payouts/?start_date=' + resPayoutsDate[0] + '&end_date=' + resPayoutsDate[1]}&sub_account_name=' +
                  accountsData[event.index]['name']);
        } catch (e) {
          isRLoading = false;
          isELoading = false;
          emit(RevenueLoaded(
              earningsData: earningsData,
              isRLoading: isRLoading,
              isELoading: isELoading,
              payoutsData: payoutsData,
              displayEarningsDate: displayEarningsDate,
              displayPayoutsDate: displayPayoutsDate));
        }
        isRLoading = false;
        isELoading = false;
        emit(RevenueLoaded(
            earningsData: earningsData,
            isRLoading: isRLoading,
            isELoading: isELoading,
            payoutsData: payoutsData,
            displayEarningsDate: displayEarningsDate,
            displayPayoutsDate: displayPayoutsDate));
      }
      if (event is RevenueLoadEarnings) {
        isELoading = true;
        emit(RevenueLoaded(
            earningsData: earningsData,
            payoutsData: payoutsData,
            isRLoading: isRLoading,
            isELoading: isELoading,
            displayEarningsDate: displayEarningsDate,
            displayPayoutsDate: displayPayoutsDate));
        int selectedSubAccount = await AuthUtils.getIndexSubAccount();
        earningsData = await ApiClient.get(
            '${'api/v1/pools/sub_account/earnings/?start_date=' + resEarningsDate[0] + '&end_date=' + resEarningsDate[1]}&sub_account_name=' +
                accountsData[selectedSubAccount]['name']);
        isELoading = false;
        emit(RevenueLoaded(
            earningsData: earningsData,
            payoutsData: payoutsData,
            isRLoading: isRLoading,
            isELoading: isELoading,
            displayEarningsDate: displayEarningsDate,
            displayPayoutsDate: displayPayoutsDate));
      }
      if (event is RevenueLoadPayouts) {
        isRLoading = true;
        int selectedSubAccount = await AuthUtils.getIndexSubAccount();
        payoutsData = await ApiClient.get(
            '${'api/v1/pools/sub_account/payouts/?start_date=' + resPayoutsDate[0] + '&end_date=' + resPayoutsDate[1]}&sub_account_name=' +
                accountsData[selectedSubAccount]['name']);
        isRLoading = false;
        emit(RevenueLoaded(
            earningsData: earningsData,
            payoutsData: payoutsData,
            isRLoading: isRLoading,
            isELoading: isELoading,
            displayEarningsDate: displayEarningsDate,
            displayPayoutsDate: displayPayoutsDate));
      }
      if (event is RevenueUpdateSubaccount) {
        accountsData = await ApiClient.get('api/v1/pools/sub_account/all/');
      }
    });
  }
}
