import 'package:bloc/bloc.dart';
import 'package:btcpool_app/app/views/dashboard/bloc/dashboard_bloc.dart';
import 'package:btcpool_app/app/views/dashboard/dashboard_screen.dart';
import 'package:btcpool_app/app/views/login/login_screen.dart';
import 'package:btcpool_app/app/views/revenue/revenue_screen.dart';
import 'package:btcpool_app/app/views/settings/settings_screen.dart';
import 'package:btcpool_app/app/views/workers/workers_screen.dart';

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'main_navigator_event.dart';
part 'main_navigator_state.dart';

class MainNavigatorBloc extends Bloc<MainNavigatorEvent, MainNavigatorState> {
  MainNavigatorBloc() : super(MainNavigatorInitial()) {
    List screens = [
      DashboardScreen(),
      RevenueScreen(),
      WorkersScreen(),
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
