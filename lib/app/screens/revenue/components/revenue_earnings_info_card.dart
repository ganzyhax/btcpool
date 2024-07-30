import 'package:easy_localization/easy_localization.dart';
import 'package:btcpool_app/app/screens/dashboard/functions/functions.dart';
import 'package:btcpool_app/app/widgets/appbar/custom_title_appbar.dart';
import 'package:btcpool_app/app/widgets/buttons/custom_button.dart';
import 'package:btcpool_app/app/widgets/custom_data_card.dart';
import 'package:btcpool_app/data/const.dart';
import 'package:flutter/material.dart';
import 'package:btcpool_app/generated/locale_keys.g.dart';

class RevenueEarningsInfoCard extends StatelessWidget {
  final data;
  const RevenueEarningsInfoCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    Locale currentLocale = context.locale;

    List<dynamic> profitDetail = data['profit_detail'];

    DateTime dateTime = DateTime.parse(data['date'].toString());
    String date = DateFormat('MMM d, yyyy, HH:mm', currentLocale.toString())
        .format(dateTime);
    double convertedHashrate = double.parse(
        (double.parse(data['hashrate'].toString()) / 1e6).toStringAsFixed(3));
    String profit =
        (data['total_profit'] / convertedHashrate).toStringAsFixed(8);
    String hashrate =
        DashboardFunctions().hashrateConverter(data['hashrate'], 3)[0];
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
              data: '$hashrate ' +
                  DashboardFunctions()
                      .hashrateConverter(data['hashrate'], 3)[1],
            ),
            CustomDataCard(
              title: LocaleKeys.income.tr(),
              data: '${data['total_profit']} BTC',
            ),
            CustomDataCard(
              title: 'BTC / 1 TH',
              data: profit,
            ),
            CustomDataCard(
              title: LocaleKeys.calculation_method.tr(),
              data: 'FPPS',
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              LocaleKeys.reward_split.tr(),
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 15,
            ),
            DataTable(
              dividerThickness: 0.0,
              dataRowHeight: 40,
              horizontalMargin: 0,
              columns: [
                DataColumn(
                    label: Text(LocaleKeys.split.tr(),
                        style: const TextStyle(fontSize: 13))),
                DataColumn(
                    label: Text(
                  LocaleKeys.account_name.tr(),
                  style: const TextStyle(fontSize: 13),
                )),
                DataColumn(
                    label: Text(LocaleKeys.amount.tr(),
                        style: const TextStyle(fontSize: 13))),
              ],
              rows: profitDetail.map((detail) {
                return DataRow(
                  cells: [
                    DataCell(Text(
                        '${detail['percentage'].toString().split('.')[0]}%',
                        textAlign: TextAlign.center)),
                    DataCell(Text(detail['name'].toString(),
                        textAlign: TextAlign.center)),
                    DataCell(Text('${detail['profit']} BTC',
                        textAlign: TextAlign.center)),
                  ],
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
