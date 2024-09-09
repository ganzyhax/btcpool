import 'package:easy_localization/easy_localization.dart';
import 'package:btcpool_app/app/components/appbar/custom_title_appbar.dart';
import 'package:btcpool_app/app/components/buttons/custom_button.dart';
import 'package:btcpool_app/app/components/custom_data_card.dart';
import 'package:btcpool_app/local_data/const.dart';
import 'package:flutter/material.dart';
import 'package:btcpool_app/generated/locale_keys.g.dart';

class RevenuePayoutsInfoCard extends StatelessWidget {
  final data;
  const RevenuePayoutsInfoCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    Locale currentLocale = context.locale;

    DateTime dateTime = DateTime.parse(data['paid_date'].toString());
    String date = DateFormat('MMM d, yyyy, HH:mm', currentLocale.toString())
        .format(dateTime);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: CustomTitleAppBar(
          title: LocaleKeys.payouts.tr(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomDataCard(
              title: LocaleKeys.date.tr(),
              data: date,
            ),
            CustomDataCard(
              title: 'TxID',
              data: data['tx_id'],
              urlOpen: 'https://blockchair.com/ru/bitcoin/transaction/' +
                  data['tx_id'],
            ),
            CustomDataCard(
              title: LocaleKeys.amount.tr(),
              data: '${data['amount']} BTC',
            ),
            CustomDataCard(
              title: LocaleKeys.wallet.tr(),
              data: data['address'].toString(),
            ),
          ],
        ),
      ),
    );
  }
}
