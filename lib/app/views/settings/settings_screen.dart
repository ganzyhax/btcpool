import 'package:btcpool_app/api/api_utils.dart';
import 'package:btcpool_app/app/app.dart';
import 'package:btcpool_app/app/components/modal/custom_acc_delete_modal.dart';
import 'package:btcpool_app/app/views/settings/components/settings_item.dart';
import 'package:btcpool_app/app/views/settings/pages/api/api_page.dart';
import 'package:btcpool_app/app/views/settings/pages/fa/fa_page.dart';
import 'package:btcpool_app/app/views/settings/pages/subaccount/subaccount_page.dart';
import 'package:btcpool_app/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:btcpool_app/app/views/settings/pages/language/language_screen.dart';
import 'package:btcpool_app/app/views/settings/pages/subaccount/bloc/subaccount_bloc.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 50),
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  LocaleKeys.settings.tr(),
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  LocaleKeys.account.tr(),
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: SingleChildScrollView(
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
                          MaterialPageRoute(builder: (context) => ApiPage()),
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
                            MaterialPageRoute(builder: (context) => BTCPool()),
                            (route) => false);
                      },
                      asset: 'assets/icons/log_out_icon.svg',
                      text: LocaleKeys.log_out.tr(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Компонент кнопки с иконкой и текстом


