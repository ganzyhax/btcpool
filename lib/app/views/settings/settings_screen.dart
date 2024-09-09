import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:btcpool_app/api/api_utils.dart';
import 'package:btcpool_app/app/app.dart';
import 'package:btcpool_app/app/views/settings/components/settings_item.dart';
import 'package:btcpool_app/app/views/settings/pages/api/api_page.dart';
import 'package:btcpool_app/app/views/settings/pages/fa/fa_page.dart';
import 'package:btcpool_app/app/views/settings/pages/language/language_screen.dart';

import 'package:btcpool_app/app/views/settings/pages/security/security_screen.dart';
import 'package:btcpool_app/app/views/settings/pages/subaccount/bloc/subaccount_bloc.dart';
import 'package:btcpool_app/app/views/settings/pages/subaccount/subaccount_page.dart';
import 'package:btcpool_app/app/components/appbar/custom_appbar.dart';
import 'package:btcpool_app/app/components/modal/custom_acc_delete_modal.dart';

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
                            asset: 'assets/icons/subaccount_icon.svg',
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
                            asset: 'assets/icons/api_icon.svg',
                            text: 'API',
                          ),
                        ),
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
                        SizedBox(
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
                            asset: 'assets/icons/key_icon.svg',
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
                            asset: 'assets/icons/password_icon.svg',
                            text: LocaleKeys.security.tr(),
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
                                  builder: (context) => LanguageScreen()),
                            );
                          },
                          child: SettingsItem(
                            asset: 'assets/icons/language_icon.svg',
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
                            asset: 'assets/icons/delete_icon.svg',
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
                          asset: 'assets/icons/log_out_icon.svg',
                          text: LocaleKeys.log_out.tr(),
                        ),
                      ])))),
    );
  }
}
