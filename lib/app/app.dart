import 'package:btcpool_app/app/bloc/theme_bloc.dart';
import 'package:btcpool_app/app/screens/dashboard/bloc/dashboard_bloc.dart';
import 'package:btcpool_app/app/screens/login/bloc/login_bloc.dart';
import 'package:btcpool_app/app/screens/navigator/bloc/main_navigator_bloc.dart';
import 'package:btcpool_app/app/screens/reset/bloc/reset_bloc.dart';
import 'package:btcpool_app/app/screens/revenue/bloc/revenue_bloc.dart';
import 'package:btcpool_app/app/screens/settings/pages/api/bloc/api_bloc.dart';
import 'package:btcpool_app/app/screens/settings/pages/calculator/bloc/calculator_bloc.dart';
import 'package:btcpool_app/app/screens/settings/pages/fa/bloc/fa_bloc.dart';
import 'package:btcpool_app/app/screens/settings/pages/language/bloc/language_bloc.dart';
import 'package:btcpool_app/app/screens/settings/pages/notification/bloc/notification_bloc.dart';
import 'package:btcpool_app/app/screens/settings/pages/observer/bloc/observer_bloc.dart';
import 'package:btcpool_app/app/screens/settings/pages/referral/bloc/referral_bloc.dart';
import 'package:btcpool_app/app/screens/settings/pages/security/bloc/security_bloc.dart';
import 'package:btcpool_app/app/screens/settings/pages/subaccount/bloc/subaccount_bloc.dart';
import 'package:btcpool_app/app/screens/signup/bloc/signup_bloc.dart';
import 'package:btcpool_app/app/screens/splash/splash_screen.dart';
import 'package:btcpool_app/app/screens/workers/bloc/workers_bloc.dart';
import 'package:btcpool_app/theme/theme.dart';
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
        BlocProvider(
          create: (context) => CalculatorBloc()..add(CalculatorLoad()),
        ),
        BlocProvider(
          create: (context) => LanguageBloc()..add(LanguageLoad()),
        ),
        BlocProvider(
          create: (context) => SecurityBloc()..add(SecurityLoad()),
        ),
        BlocProvider(
          create: (context) => ReferralBloc()..add(ReferralLoad()),
        ),
        BlocProvider(
          create: (context) => NotificationBloc()..add(NotificationLoad()),
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
