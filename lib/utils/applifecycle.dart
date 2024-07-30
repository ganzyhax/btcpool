import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:btcpool_app/app/screens/dashboard/bloc/dashboard_bloc.dart';

class LifecycleService with WidgetsBindingObserver {
  bool isStarted = false;
  BuildContext? _context;

  void setContext(BuildContext context) {
    _context = context;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.resumed:
        _onResumed();
        break;
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.paused:
        break;
      case AppLifecycleState.detached:
        break;
      case AppLifecycleState.hidden:
    }
  }

  void _onResumed() {
    if (isStarted == false) {
      isStarted = true;
    } else {
      log('Performing actions on app resume');
      if (_context != null) {
        BlocProvider.of<DashboardBloc>(_context!).add(DashboardRefresh());
      }
    }
  }

  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
  }
}
