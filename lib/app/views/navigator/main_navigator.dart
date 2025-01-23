import 'package:btcpool_app/app/components/subaccount_card.dart';
import 'package:btcpool_app/app/views/dashboard/bloc/dashboard_bloc.dart';
import 'package:btcpool_app/app/views/navigator/bloc/main_navigator_bloc.dart';
import 'package:btcpool_app/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    return BlocBuilder<MainNavigatorBloc, MainNavigatorState>(
      builder: (context, state) {
        if (state is MainNavigatorLoaded) {
          return Scaffold(
            key: _scaffoldKey,
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.secondary,
              scrolledUnderElevation: 0,
              leading: IconButton(
                icon: Icon(Icons.menu),
                onPressed: () {
                  _scaffoldKey.currentState?.openDrawer();
                },
              ),
              title: Row(
                children: [
                  Row(
                    children: [
                      SizedBox(
                          width: 100,
                          child: (Theme.of(context).brightness ==
                                  Brightness.dark)
                              ? Image.asset('assets/images/btcpool_logo.png')
                              : Image.asset('assets/images/btcpool_logo.png')),
                    ],
                  ),
                ],
              ),
            ),
            resizeToAvoidBottomInset: false,
            backgroundColor: Theme.of(context).colorScheme.background,
            drawer: Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  SizedBox(
                    height: 45,
                  ),
                  ListTile(
                    leading: SvgPicture.asset(
                      'assets/icons/dashboard_icon.svg',
                      color: (state.index == 0)
                          ? Theme.of(context).colorScheme.primary
                          : null,
                    ),
                    title: Text(
                      LocaleKeys.dashboard.tr(),
                      style: TextStyle(
                        color: (state.index == 0)
                            ? Theme.of(context).colorScheme.primary
                            : null,
                      ),
                    ),
                    selected: state.index == 0,
                    onTap: () {
                      BlocProvider.of<MainNavigatorBloc>(context)
                          .add(MainNavigatorChangePage(index: 0));
                      BlocProvider.of<DashboardBloc>(context)
                          .add(DashboardLoadCache());
                      Navigator.pop(context); // Close drawer
                    },
                  ),
                  ListTile(
                    leading: SvgPicture.asset(
                      'assets/icons/payment_icon.svg',
                      color: (state.index == 1)
                          ? Theme.of(context).colorScheme.primary
                          : null,
                    ),
                    title: Text(
                      LocaleKeys.revenue.tr(),
                      style: TextStyle(
                        color: (state.index == 1)
                            ? Theme.of(context).colorScheme.primary
                            : null,
                      ),
                    ),
                    selected: state.index == 1,
                    onTap: () {
                      BlocProvider.of<MainNavigatorBloc>(context)
                          .add(MainNavigatorChangePage(index: 1));
                      Navigator.pop(context); // Close drawer
                    },
                  ),
                  ListTile(
                    leading: SvgPicture.asset(
                      'assets/icons/settings_icon.svg',
                      color: (state.index == 2)
                          ? Theme.of(context).colorScheme.primary
                          : null,
                    ),
                    title: Text(
                      LocaleKeys.settings.tr(),
                      style: TextStyle(
                        color: (state.index == 2)
                            ? Theme.of(context).colorScheme.primary
                            : null,
                      ),
                    ),
                    selected: state.index == 2,
                    onTap: () {
                      BlocProvider.of<MainNavigatorBloc>(context)
                          .add(MainNavigatorChangePage(index: 2));
                      Navigator.pop(context); // Close drawer
                    },
                  ),
                ],
              ),
            ),
            body: state.screens[state.index],
          );
        }
        return Container();
      },
    );
  }
}
