import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:btcpool_app/app/screens/settings/pages/fa/bloc/fa_bloc.dart';
import 'package:btcpool_app/app/screens/settings/pages/notification/bloc/notification_bloc.dart';
import 'package:btcpool_app/app/widgets/appbar/custom_title_appbar.dart';
import 'package:btcpool_app/app/widgets/custom_indicator.dart';
import 'package:btcpool_app/app/widgets/custom_snackbar.dart';
import 'package:btcpool_app/app/widgets/textfields/custom_textfiled.dart';
import 'package:btcpool_app/data/const.dart';
import 'package:btcpool_app/generated/locale_keys.g.dart';
import 'package:url_launcher/url_launcher.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: CustomTitleAppBar(
          title: LocaleKeys.telegram_notification.tr(),
        ),
      ),
      body: BlocBuilder<NotificationBloc, NotificationState>(
        builder: (context, state) {
          if (state is NotificationLoaded) {
            return SingleChildScrollView(
              child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        LocaleKeys.your_token_to_subscribe.tr(),
                        style: const TextStyle(fontSize: 17),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            state.data['token'],
                            style: const TextStyle(fontSize: 16),
                          ),
                          InkWell(
                            onTap: () {
                              Clipboard.setData(
                                  ClipboardData(text: state.data['token']));
                              CustomSnackbar()
                                  .showCustomSnackbar(context, 'Copied!', true);
                            },
                            child: Icon(
                              Icons.copy,
                              color: AppColors().kPrimaryGreen,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(LocaleKeys.url_for_bot.tr(),
                          style: const TextStyle(
                            fontSize: 17,
                          )),
                      InkWell(
                        onTap: () {
                          launchUrl(Uri.parse(
                              'https://t.me/twenty_one_pool_manager_bot'));
                        },
                        child: const Text(
                          'https://t.me/twenty_one_pool_manager_bot',
                          style: TextStyle(color: Colors.blue, fontSize: 17),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        LocaleKeys.to_setup_low_hashrate_notification.tr(),
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.italic,
                        ),
                      )
                    ],
                  )),
            );
          }
          return Center(
            child: CustomIndicator(),
          );
        },
      ),
    );
  }
}
