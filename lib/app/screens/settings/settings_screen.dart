import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:btcpool_app/api/api_utils.dart';
import 'package:btcpool_app/app/app.dart';
import 'package:btcpool_app/app/screens/settings/components/settings_item.dart';
import 'package:btcpool_app/app/screens/settings/pages/api/api_page.dart';
import 'package:btcpool_app/app/screens/settings/pages/fa/fa_page.dart';
import 'package:btcpool_app/app/screens/settings/pages/language/language_screen.dart';

import 'package:btcpool_app/app/screens/settings/pages/security/security_screen.dart';
import 'package:btcpool_app/app/screens/settings/pages/subaccount/bloc/subaccount_bloc.dart';
import 'package:btcpool_app/app/screens/settings/pages/subaccount/subaccount_page.dart';
import 'package:btcpool_app/app/widgets/appbar/custom_appbar.dart';
import 'package:btcpool_app/app/widgets/modal/custom_acc_delete_modal.dart';

import 'package:flutter/material.dart';
import 'package:btcpool_app/generated/locale_keys.g.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return ScaffoldMessenger(
      child: Scaffold(
          key: scaffoldKey,
          backgroundColor: Theme.of(context).colorScheme.background,
          appBar: PreferredSize(
              preferredSize: const Size.fromHeight(60),
              child: CustomAppBar(
                title: LocaleKeys.settings,
                withSubAccount: false,
              )),
          body: SingleChildScrollView(
              child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          LocaleKeys.subaccount_settings,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ).tr(),
                        const SizedBox(
                          height: 7,
                        ),
                        // InkWell(
                        //   onTap: () {
                        //     Navigator.push(
                        //       context,
                        //       MaterialPageRoute(
                        //           builder: (context) => const ObserverPage()),
                        //     );
                        //   },
                        //   child: SettingsItem(
                        //     asset: 'assets/icons/observer.svg',
                        //     text: LocaleKeys.observers,
                        //   ),
                        // ),
                        // const SizedBox(
                        //   height: 7,
                        // ),
                        InkWell(
                          onTap: () {
                            BlocProvider.of<SubaccountBloc>(context)
                                .add(SubaccountLoad());
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SubAccountPage()),
                            );
                          },
                          child: SettingsItem(
                            asset: 'assets/icons/subaccount.svg',
                            text: LocaleKeys.subaccounts.tr(),
                          ),
                        ),
                        const SizedBox(
                          height: 7,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ApiPage()),
                            );
                          },
                          child: SettingsItem(
                            asset: 'assets/icons/api.svg',
                            text: 'API',
                          ),
                        ),
                        // const SizedBox(
                        //   height: 7,
                        // ),
                        // InkWell(
                        //   onTap: () {
                        //     Navigator.push(
                        //       context,
                        //       MaterialPageRoute(
                        //           builder: (context) => ReferralPage()),
                        //     );
                        //   },
                        //   child: SettingsItem(
                        //     asset: 'assets/icons/referral.svg',
                        //     text: LocaleKeys.referral_program,
                        //   ),
                        // ),
                        const SizedBox(
                          height: 25,
                        ),
                        Row(
                          children: [
                            Text(
                              LocaleKeys.general_settings,
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500),
                            ).tr(),
                            const Text(' '),
                          ],
                        ),
                        // const SizedBox(
                        //   height: 7,
                        // ),
                        // InkWell(
                        //   onTap: () {
                        //     Navigator.push(
                        //       context,
                        //       MaterialPageRoute(
                        //           builder: (context) => PersonalPage()),
                        //     );
                        //   },
                        //   child: SettingsItem(
                        //     asset: 'assets/icons/user.svg',
                        //     text: LocaleKeys.personal_settings,
                        //   ),
                        // ),
                        // const SizedBox(
                        //   height: 7,
                        // ),
                        // InkWell(
                        //   onTap: () {
                        //     Navigator.push(
                        //       context,
                        //       MaterialPageRoute(
                        //           builder: (context) =>
                        //               const NotificationScreen()),
                        //     );
                        //   },
                        //   child: SettingsItem(
                        //     asset: 'assets/icons/notification.svg',
                        //     text: LocaleKeys.telegram_notification,
                        //   ),
                        // ),
                        const SizedBox(
                          height: 7,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const FAPage()),
                            );
                          },
                          child: SettingsItem(
                            asset: 'assets/icons/key.svg',
                            text: LocaleKeys.fa_auhenticator.tr(),
                          ),
                        ),
                        const SizedBox(
                          height: 7,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SecurityScreen()),
                            );
                          },
                          child: SettingsItem(
                            asset: 'assets/icons/password.svg',
                            text: LocaleKeys.security.tr(),
                          ),
                        ),
                        const SizedBox(
                          height: 7,
                        ),
                        // InkWell(
                        //   onTap: () {
                        //     Navigator.push(
                        //       context,
                        //       MaterialPageRoute(
                        //           builder: (context) => CalculatorScreen()),
                        //     );
                        //   },
                        //   child: SettingsItem(
                        //     asset: 'assets/icons/calculator.svg',
                        //     text: LocaleKeys.calculator.tr(),
                        //   ),
                        // ),
                        // const SizedBox(
                        //   height: 7,
                        // ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LanguageScreen()),
                            );
                          },
                          child: SettingsItem(
                            asset: 'assets/icons/language.svg',
                            text: LocaleKeys.language.tr(),
                          ),
                        ),
                        const SizedBox(
                          height: 7,
                        ),
                        InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (c) {
                                return AccDeleteModal(
                                  scaffoldKey: scaffoldKey,
                                );
                              },
                            );
                          },
                          child: SettingsItem(
                            asset: 'assets/icons/delete.svg',
                            text: LocaleKeys.delete_account.tr(),
                          ),
                        ),
                        const SizedBox(
                          height: 7,
                        ),
                        SettingsItem(
                          function: () async {
                            await AuthUtils.logout();
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BTCPool()),
                                (route) => false);
                          },
                          asset: 'assets/icons/logout.svg',
                          text: LocaleKeys.log_out.tr(),
                        ),
                      ])))),
    );
  }
}
