import 'package:btcpool_app/api/api_utils.dart';
import 'package:btcpool_app/app/screens/login/login_screen.dart';
import 'package:btcpool_app/app/screens/settings/components/settings_item.dart';
import 'package:btcpool_app/app/screens/settings/pages/api/api_page.dart';
import 'package:btcpool_app/app/screens/settings/pages/fa/fa_page.dart';
import 'package:btcpool_app/app/screens/settings/pages/observer/observer_page.dart';
import 'package:btcpool_app/app/screens/settings/pages/personal/personal_page.dart';
import 'package:btcpool_app/app/screens/settings/pages/subaccount/subaccount_page.dart';
import 'package:btcpool_app/app/widgets/appbar/custom_appbar.dart';
import 'package:btcpool_app/data/const.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors().kPrimaryBackgroundColor,
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(60),
            child: CustomAppBar(
              title: 'Settings',
              withSubAccount: false,
            )),
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'General Settings',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                      // SizedBox(
                      //   height: 7,
                      // ),
                      // InkWell(
                      //   onTap: () {
                      //     Navigator.push(
                      //       context,
                      //       MaterialPageRoute(
                      //           builder: (context) => const PersonalPage()),
                      //     );
                      //   },
                      //   child: SettingsItem(
                      //     asset: 'assets/icons/settings.svg',
                      //     text: 'Personal Settings',
                      //   ),
                      // ),
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
                          asset: 'assets/icons/key.svg',
                          text: '2FA Authentificator',
                        ),
                      ),
                      // SizedBox(
                      //   height: 7,
                      // ),
                      // InkWell(
                      //   onTap: () {
                      //     // Navigator.push(
                      //     //   context,
                      //     //   MaterialPageRoute(
                      //     //       builder: (context) => const PasswordEditScreen()),
                      //     // );
                      //   },
                      //   child: SettingsItem(
                      //     asset: 'assets/icons/language.svg',
                      //     text: 'Language',
                      //   ),
                      // ),
                      SizedBox(
                        height: 25,
                      ),
                      Text(
                        'Subaccount Settings',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ObserverPage()),
                          );
                        },
                        child: SettingsItem(
                          asset: 'assets/icons/observer.svg',
                          text: 'Observers',
                        ),
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SubAccountPage()),
                          );
                        },
                        child: SettingsItem(
                          asset: 'assets/icons/subaccount.svg',
                          text: 'Subaccounts',
                        ),
                      ),
                      // SizedBox(
                      //   height: 7,
                      // ),
                      // InkWell(
                      //   onTap: () {
                      //     // Navigator.push(
                      //     //   context,
                      //     //   MaterialPageRoute(
                      //     //       builder: (context) => const WalletEditScreen()),
                      //     // );
                      //   },
                      //   child: SettingsItem(
                      //     asset: 'assets/icons/wallet.svg',
                      //     text: 'Wallet and Threshold',
                      //   ),
                      // ),
                      SizedBox(
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
                          asset: 'assets/icons/api.svg',
                          text: 'API',
                        ),
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      SettingsItem(
                        function: () async {
                          await AuthUtils.clearStorage();
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()),
                              (Route<dynamic> route) => false);
                        },
                        asset: 'assets/icons/logout.svg',
                        text: 'Выход',
                      ),
                    ]))));
  }
}
