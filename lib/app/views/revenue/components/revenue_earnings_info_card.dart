import 'package:btcpool_app/app/components/appbar/custom_title_appbar.dart';
import 'package:btcpool_app/app/components/custom_data_card.dart';
import 'package:btcpool_app/app/views/dashboard/functions/functions.dart';
import 'package:btcpool_app/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RevenueEarningsInfoCard extends StatelessWidget {
  final data;
  const RevenueEarningsInfoCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    Locale currentLocale = context.locale;

    // List<dynamic> profitDetail = data['profit_detail'];

    DateTime dateTime = DateTime.parse(data['date'].toString());
    String date = DateFormat('MMM d, yyyy, HH:mm', currentLocale.toString())
        .format(dateTime);

    double convertedHashrate;
    String profit;
    String hashrate;
    String hashrateSign;
    if (data['crypto_currency'] == 'BTC') {
      convertedHashrate = double.parse(
          (double.parse(data['hashrate'].toString()) / 1e6).toStringAsFixed(3));
      profit = (data['total_profit'] / convertedHashrate).toStringAsFixed(8);
      hashrate = DashboardFunctions().hashrateConverter(data['hashrate'], 3)[0];
      hashrateSign =
          DashboardFunctions().hashrateConverter(data['hashrate'], 3)[1];
    } else {
      convertedHashrate = double.parse(
          (double.parse(data['hashrate'].toString()) / 1e3).toStringAsFixed(3));
      profit = (data['total_profit'] / convertedHashrate).toStringAsFixed(8);
      hashrate =
          DashboardFunctions().hashrateConverterLTC(data['hashrate'], 3)[0];
      hashrateSign =
          DashboardFunctions().hashrateConverterLTC(data['hashrate'], 3)[1];
    }

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: CustomTitleAppBar(
          title: LocaleKeys.earnings.tr(),
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
              title: LocaleKeys.hashrate.tr(),
              data: '$hashrate ' + hashrateSign,
            ),
            CustomDataCard(
              title: LocaleKeys.income.tr(),
              data: data['total_profit'].toString() +
                  ' ' +
                  data['crypto_currency'],
            ),
            CustomDataCard(
              title: data['crypto_currency'] +
                  ' / 1 ' +
                  hashrateSign.split('/')[0],
              data: profit,
            ),
            CustomDataCard(
              title: LocaleKeys.calculation_method.tr(),
              data: 'FPPS',
            ),
            // const SizedBox(
            //   height: 5,
            // ),
            // Text(
            //   LocaleKeys.reward_split.tr(),
            //   style: TextStyle(fontWeight: FontWeight.w600),
            // ),
            // const SizedBox(
            //   height: 15,
            // ),
            // DataTable(
            //   dividerThickness: 0.0,
            //   dataRowHeight: 40,
            //   horizontalMargin: 0,
            //   columns: [
            //     DataColumn(
            //         label: Text(LocaleKeys.split.tr(),
            //             style: TextStyle(fontSize: 13))),
            //     DataColumn(
            //         label: Text(
            //       LocaleKeys.account_name.tr(),
            //       style: TextStyle(fontSize: 13),
            //     )),
            //     DataColumn(
            //         label: Text(LocaleKeys.amount.tr(),
            //             style: TextStyle(fontSize: 13))),
            //   ],
            //   rows: profitDetail.map((detail) {
            //     return DataRow(
            //       cells: [
            //         DataCell(Text(
            //             detail['percentage'].toString().split('.')[0] + '%',
            //             textAlign: TextAlign.center)),
            //         DataCell(Text(detail['name'].toString(),
            //             textAlign: TextAlign.center)),
            //         DataCell(Text(
            //             detail['profit'].toString() +
            //                 ' ' +
            //                 data['crypto_currency'],
            //             textAlign: TextAlign.center)),
            //       ],
            //     );
            //   }).toList(),
            // ),
          ],
        ),
      ),
    );
  }
}
