import 'package:btcpool_app/app/screens/dashboard/bloc/dashboard_bloc.dart';
import 'package:btcpool_app/app/screens/login/bloc/login_bloc.dart';
import 'package:btcpool_app/app/screens/login/login_screen.dart';
import 'package:btcpool_app/app/screens/navigator/bloc/main_navigator_bloc.dart';
import 'package:btcpool_app/app/screens/navigator/main_navigator.dart';
import 'package:btcpool_app/app/screens/reset/bloc/reset_bloc.dart';
import 'package:btcpool_app/app/screens/revenue/bloc/revenue_bloc.dart';
import 'package:btcpool_app/app/screens/settings/pages/api/bloc/api_bloc.dart';
import 'package:btcpool_app/app/screens/settings/pages/fa/bloc/fa_bloc.dart';
import 'package:btcpool_app/app/screens/settings/pages/observer/bloc/observer_bloc.dart';
import 'package:btcpool_app/app/screens/settings/pages/subaccount/bloc/subaccount_bloc.dart';
import 'package:btcpool_app/app/screens/signup/bloc/signup_bloc.dart';
import 'package:btcpool_app/app/screens/workers/bloc/workers_bloc.dart';
import 'package:btcpool_app/data/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BTCPool extends StatelessWidget {
  final bool isLogged;
  const BTCPool({super.key, required this.isLogged});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => MainNavigatorBloc()..add(MainNavigatorLoad()),
        ),
        BlocProvider(
          create: (context) => LoginBloc()..add(LoginLaod()),
        ),
        BlocProvider(
          create: (context) => DashboardBloc()..add(DashboardLoad()),
        ),
        BlocProvider(
          create: (context) => WorkersBloc()..add(WorkersLoad()),
        ),
        BlocProvider(
          create: (context) => SignupBloc()..add(SignupLoad()),
        ),
        BlocProvider(
          create: (context) => RevenueBloc()..add(RevenueLoad()),
        ),
        BlocProvider(
          create: (context) => FaBloc()..add(FaLoad()),
        ),
        BlocProvider(
          create: (context) => ResetBloc()..add(ResetLoad()),
        ),
        BlocProvider(
          create: (context) => ApiBloc()..add(ApiLoad()),
        ),
        BlocProvider(
          create: (context) => SubaccountBloc()..add(SubaccountLoad()),
        ),
        BlocProvider(
          create: (context) => ObserverBloc()..add(ObserverLoad()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'EnegixApp',
        theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
            useMaterial3: true,
            primaryColor: AppColors().kPrimaryGreen
            // textTheme: GoogleFonts.mulishTextTheme(),
            ),
        home: MediaQuery(
          child: (isLogged) ? CustomNavigationBar() : LoginScreen(),
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        ),
      ),
    );
  }
}
