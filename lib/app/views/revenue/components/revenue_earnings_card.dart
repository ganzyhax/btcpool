import 'dart:developer';

import 'package:btcpool_app/app/views/dashboard/functions/functions.dart';
import 'package:btcpool_app/app/views/revenue/components/revenue_earnings_info_card.dart';
import 'package:btcpool_app/generated/locale_keys.g.dart';
import 'package:btcpool_app/local_data/const.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RevenueEarningsCard extends StatelessWidget {
  final data;

  const RevenueEarningsCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    Locale currentLocale = context.locale;

    DateTime dateTime = DateTime.parse(data['date'].toString());
    String date = DateFormat('MMM d, yyyy, HH:mm', currentLocale.toString())
        .format(dateTime);
    String hashrate;
    double convertedHashrate;
    String profit;
    String hashrateSign;
    if (data['crypto_currency'] == 'BTC') {
      hashrate = DashboardFunctions().hashrateConverter(data['hashrate'], 3)[0];
      hashrateSign =
          DashboardFunctions().hashrateConverter(data['hashrate'], 3)[1];
      convertedHashrate = double.parse(
          (double.parse(data['hashrate'].toString()) / 1e6).toStringAsFixed(3));
      profit = (data['total_profit'] / convertedHashrate).toStringAsFixed(8);
    } else {
      hashrate =
          DashboardFunctions().hashrateConverterLTC(data['hashrate'], 3)[0];

      hashrateSign =
          DashboardFunctions().hashrateConverterLTC(data['hashrate'], 3)[1];
      hashrate =
          DashboardFunctions().hashrateConverterLTC(data['hashrate'], 3)[0];
      convertedHashrate = double.parse(
          (double.parse(data['hashrate'].toString()) / 1e3).toStringAsFixed(2));
      profit = (data['total_profit'] / convertedHashrate).toStringAsFixed(8);
    }

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => RevenueEarningsInfoCard(
                    data: data,
                  )),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Theme.of(context).colorScheme.secondary),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width / 1.2,
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        date,
                        style: const TextStyle(
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            LocaleKeys.income.tr(),
                            style: TextStyle(
                                fontSize: 12, color: AppColors().kPrimaryGrey),
                          ),
                          Text(
                              data['total_profit'].toString() +
                                  ' ' +
                                  data['crypto_currency'],
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                              ))
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            LocaleKeys.hashrate.tr(),
                            style: TextStyle(
                                fontSize: 12, color: AppColors().kPrimaryGrey),
                          ),
                          Text('$hashrate ' + hashrateSign,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                              ))
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data['crypto_currency'] + ' / 1 TH',
                            style: TextStyle(
                                fontSize: 12, color: AppColors().kPrimaryGrey),
                          ),
                          Text('${profit} ' + data['crypto_currency'],
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                              ))
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(
              width: 12,
              child: Icon(
                Icons.arrow_forward_ios_outlined,
                size: 20,
              ),
            )
          ],
        ),
      ),
    );
  }
}
