import 'package:bloc/bloc.dart';
import 'package:btcpool_app/app/screens/dashboard/bloc/dashboard_bloc.dart';
import 'package:btcpool_app/app/screens/dashboard/dashboard_screen.dart';
import 'package:btcpool_app/app/screens/login/login_screen.dart';
import 'package:btcpool_app/app/screens/revenue/revenue_screen.dart';
import 'package:btcpool_app/app/screens/settings/settings_screen.dart';
import 'package:btcpool_app/app/screens/workers/workers_screen.dart';

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'main_navigator_event.dart';
part 'main_navigator_state.dart';

class MainNavigatorBloc extends Bloc<MainNavigatorEvent, MainNavigatorState> {
  MainNavigatorBloc() : super(MainNavigatorInitial()) {
    List screens = [
      DashboardScreen(),
      RevenueScreen(),
      SettingsScreen(),
    ];
    int index = 0;
    on<MainNavigatorEvent>((event, emit) async {
      if (event is MainNavigatorLoad) {
        // final SharedPreferences prefs = await SharedPreferences.getInstance();

        // bool isLogged = await prefs.getBool('isLogged') ?? false;
        // if (isLogged) {
        // } else {}
        emit(MainNavigatorLoaded(index: index, screens: screens));
      }

      if (event is MainNavigatorChangePage) {
        // final SharedPreferences prefs = await SharedPreferences.getInstance();
        index = event.index;
        emit(MainNavigatorLoaded(index: index, screens: screens));
      }
    });
  }
}
