import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:btcpool_app/api/api.dart';
import 'package:btcpool_app/api/api_utils.dart';
import 'package:btcpool_app/api/local_auth.dart';
import 'package:btcpool_app/app/screens/dashboard/bloc/dashboard_bloc.dart';
import 'package:btcpool_app/app/screens/login/login_screen.dart';
import 'package:btcpool_app/app/screens/navigator/main_navigator.dart';
import 'package:btcpool_app/app/screens/settings/pages/api/bloc/api_bloc.dart';
import 'package:btcpool_app/app/screens/settings/pages/security/components/lock_page.dart';

import 'package:btcpool_app/app/widgets/custom_indicator.dart';
import 'package:btcpool_app/app/widgets/custom_snackbar.dart';
import 'package:btcpool_app/app/widgets/modal/custom_modal.dart';
import 'package:btcpool_app/app/widgets/modal/custom_update.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isLogged = false;
  @override
  initState() {
    super.initState();
    _initializeState();
  }

  Future<void> _initializeState() async {
    isLogged = await AuthUtils.isAccess();
    try {
      var res =
          await ApiClient.checkUpdate('api/v1/statistic/crypto_currency/');
      if (res == 17000) {
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return UpdateModal(
              withSkip: false,
            );
          },
        );
      } else if (res == 16000) {
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return UpdateModal(
              withSkip: true,
            );
          },
        );
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (context) =>
                  (isLogged) ? CustomNavigationBar() : LoginScreen()),
          (Route<dynamic> route) => false,
        );
      } else {
        bool isSecured = await AuthUtils.getIsSecure() ?? false;
        if (isSecured && isLogged) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => LockPage()),
            (Route<dynamic> route) => false,
          );
        } else {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (context) =>
                    (isLogged) ? CustomNavigationBar() : LoginScreen()),
            (Route<dynamic> route) => false,
          );
        }
      }
    } catch (e) {
      CustomSnackbar()
          .showCustomSnackbar(context, 'No internet connection...', false);
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
            builder: (context) =>
                (isLogged) ? CustomNavigationBar() : LoginScreen()),
        (Route<dynamic> route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: (isLogged)
            ? BlocBuilder<DashboardBloc, DashboardState>(
                builder: (context, state) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                            width: MediaQuery.of(context).size.width / 2,
                            child: (Theme.of(context).brightness ==
                                    Brightness.dark)
                                ? Image.asset('assets/images/btcpool_logo.png')
                                : Image.asset(
                                    'assets/images/btcpool_logo.png')),
                        const SizedBox(
                          height: 30,
                        ),
                        CustomIndicator()
                      ],
                    ),
                  );
                },
              )
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                        width: MediaQuery.of(context).size.width / 2,
                        child: (Theme.of(context).brightness == Brightness.dark)
                            ? Image.asset('assets/images/btcpool_logo.png')
                            : Image.asset('assets/images/btcpool_logo.png')),
                    const SizedBox(
                      height: 30,
                    ),
                    CustomIndicator()
                  ],
                ),
              ));
  }
}
