import 'package:btcpool_app/app/main_bloc/theme_bloc.dart';
import 'package:btcpool_app/app/views/dashboard/bloc/dashboard_bloc.dart';
import 'package:btcpool_app/app/views/login/bloc/login_bloc.dart';
import 'package:btcpool_app/app/views/navigator/bloc/main_navigator_bloc.dart';
import 'package:btcpool_app/app/views/reset/bloc/reset_bloc.dart';
import 'package:btcpool_app/app/views/revenue/bloc/revenue_bloc.dart';
import 'package:btcpool_app/app/views/settings/pages/api/bloc/api_bloc.dart';
import 'package:btcpool_app/app/views/settings/pages/fa/bloc/fa_bloc.dart';
import 'package:btcpool_app/app/views/settings/pages/language/bloc/language_bloc.dart';
import 'package:btcpool_app/app/views/settings/pages/subaccount/bloc/subaccount_bloc.dart';
import 'package:btcpool_app/app/views/signup/bloc/signup_bloc.dart';
import 'package:btcpool_app/app/views/splash/splash_screen.dart';
import 'package:btcpool_app/app/views/workers/bloc/workers_bloc.dart';
import 'package:btcpool_app/local_theme/theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BTCPool extends StatelessWidget {
  const BTCPool({super.key});

  @override
  Widget build(BuildContext context) {
    // final dashboardBloc = GetIt.instance<DashboardBloc>();
    return MultiBlocProvider(
      providers: [
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
          create: (context) => DashboardBloc()..add(DashboardLoad()),
        ),
        BlocProvider(
          create: (context) => LanguageBloc()..add(LanguageLoad()),
        ),
        BlocProvider(
          create: (context) => SubaccountBloc()..add(SubaccountLoad()),
        ),
        BlocProvider(
          create: (context) => WorkersBloc()..add(WorkersLoad()),
        ),
        BlocProvider(
          create: (context) => MainNavigatorBloc()..add(MainNavigatorLoad()),
        ),
        BlocProvider(
          create: (context) => LoginBloc()..add(LoginLaod()),
        ),
      ],
      child: BlocProvider(
        create: (context) => ThemeBloc(context),
        child: BlocBuilder<ThemeBloc, ThemeState>(
          builder: (context, state) {
            if (state is ThemeLoaded) {
              return MaterialApp(
                builder: (BuildContext context, Widget? child) {
                  return MediaQuery(
                    data: MediaQuery.of(context).copyWith(
                      textScaleFactor: 1.0,
                    ),
                    child: child!,
                  );
                },
                darkTheme: darkMode,
                localizationsDelegates: context.localizationDelegates,
                supportedLocales: context.supportedLocales,
                locale: context.locale,
                debugShowCheckedModeBanner: false,
                title: 'BTC Pool',
                themeMode:
                    (state.isDark == true) ? ThemeMode.dark : ThemeMode.light,
                theme: lightMode,
                home: SplashScreen(),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
