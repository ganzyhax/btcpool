import 'package:btcpool_app/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:btcpool_app/app/screens/navigator/main_navigator.dart';
import 'package:btcpool_app/app/screens/settings/pages/language/bloc/language_bloc.dart';
import 'package:btcpool_app/app/screens/settings/pages/language/components/language_card.dart';
import 'package:btcpool_app/app/widgets/appbar/custom_appbar.dart';
import 'package:btcpool_app/app/widgets/custom_indicator.dart';
import 'package:btcpool_app/data/const.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => CustomNavigationBar()),
            (Route<dynamic> route) => false);
        return Future.value(false);
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(60),
            child: CustomAppBar(
              withArrow: false,
              onTapBack: () {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (context) => CustomNavigationBar()),
                    (Route<dynamic> route) => false);
              },
              withSubAccount: false,
              title: LocaleKeys.language.tr(),
            )),
        body: SingleChildScrollView(
          child: BlocBuilder<LanguageBloc, LanguageState>(
            builder: (context, state) {
              if (state is LanguageLoaded) {
                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      LanguageCard(
                          function: () {
                            context.setLocale(const Locale('en'));
                            BlocProvider.of<LanguageBloc>(context)
                                .add(LanguageChangeIndex(index: 0));
                          },
                          isSelected: (state.selectedIndex == 0) ? true : false,
                          title: 'English',
                          asset: 'assets/icons/us-flag.png'),
                      LanguageCard(
                          function: () {
                            context.setLocale(const Locale('pt'));

                            BlocProvider.of<LanguageBloc>(context)
                                .add(LanguageChangeIndex(index: 1));
                          },
                          isSelected: (state.selectedIndex == 1) ? true : false,
                          title: 'Portugal',
                          asset: 'assets/icons/pt-flag.png'),
                      LanguageCard(
                          function: () {
                            context.setLocale(const Locale('es'));
                            BlocProvider.of<LanguageBloc>(context)
                                .add(LanguageChangeIndex(index: 2));
                          },
                          isSelected: (state.selectedIndex == 2) ? true : false,
                          title: 'Español',
                          asset: 'assets/icons/es-flag.png'),
                      LanguageCard(
                          function: () {
                            context.setLocale(const Locale('ru'));
                            BlocProvider.of<LanguageBloc>(context)
                                .add(LanguageChangeIndex(index: 3));
                          },
                          isSelected: (state.selectedIndex == 3) ? true : false,
                          title: 'Русский',
                          asset: 'assets/icons/ru-flag.png'),
                      LanguageCard(
                          function: () {
                            context.setLocale(const Locale('ar'));
                            BlocProvider.of<LanguageBloc>(context)
                                .add(LanguageChangeIndex(index: 4));
                          },
                          isSelected: (state.selectedIndex == 4) ? true : false,
                          title: 'عربي',
                          asset: 'assets/icons/ar-flag.png'),
                    ],
                  ),
                );
              }
              return Center(
                child: CustomIndicator(),
              );
            },
          ),
        ),
      ),
    );
  }
}
