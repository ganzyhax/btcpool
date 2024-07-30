import 'package:btcpool_app/app/screens/dashboard/bloc/dashboard_bloc.dart';
import 'package:btcpool_app/app/screens/navigator/bloc/main_navigator_bloc.dart';
import 'package:btcpool_app/app/screens/navigator/components/navigator_item.dart';
import 'package:btcpool_app/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainNavigatorBloc, MainNavigatorState>(
      builder: (context, state) {
        if (state is MainNavigatorLoaded) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Theme.of(context).colorScheme.background,
            body: Column(
              children: [
                Expanded(child: state.screens[state.index]),
                Container(
                  height: 80,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap: () {
                          BlocProvider.of<MainNavigatorBloc>(context)
                              .add(MainNavigatorChangePage(index: 0));
                          BlocProvider.of<DashboardBloc>(context)
                              .add(DashboardLoadCache());
                        },
                        child: NavigationItem(
                            assetImage: 'assets/icons/dashboard.svg',
                            isSelected: (state.index == 0) ? true : false,
                            text: LocaleKeys.dashboard.tr()),
                      ),
                      InkWell(
                        onTap: () {
                          BlocProvider.of<MainNavigatorBloc>(context)
                              .add(MainNavigatorChangePage(index: 1));
                        },
                        child: NavigationItem(
                            assetImage: 'assets/icons/payment.svg',
                            isSelected: (state.index == 2) ? true : false,
                            text: LocaleKeys.revenue.tr()),
                      ),
                      InkWell(
                        onTap: () {
                          BlocProvider.of<MainNavigatorBloc>(context)
                              .add(MainNavigatorChangePage(index: 2));
                        },
                        child: NavigationItem(
                            assetImage: 'assets/icons/settings.svg',
                            isSelected: (state.index == 3) ? true : false,
                            text: LocaleKeys.settings.tr()),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        }
        return Container();
      },
    );
  }
}
