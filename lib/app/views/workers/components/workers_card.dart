import 'dart:developer';

import 'package:btcpool_app/app/views/dashboard/functions/functions.dart';
import 'package:btcpool_app/generated/locale_keys.g.dart';
import 'package:btcpool_app/local_data/const.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';

class WorkersCard extends StatelessWidget {
  final data;
  final String selectedCrypto;
  const WorkersCard({
    super.key,
    required this.selectedCrypto,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    Locale currentLocale = context.locale;

    DateTime dateTime = DateTime.parse(data['last_share_datetime'].toString());

    String date = DateFormat('MMM d, yyyy, HH:mm', currentLocale.toString())
        .format(dateTime);

    String hashrate10min;
    String hashrate1h;
    String hashrate24h;

    String hashrate10minType;
    String hashrate1hType;
    String hashrate24hType;
    log('TASAK');
    log(selectedCrypto);
    if (selectedCrypto == 'BTC') {
      hashrate10min =
          DashboardFunctions().hashrateConverter(data['hashrate_10m'], 3)[0];

      hashrate1h =
          DashboardFunctions().hashrateConverter(data['hashrate_1h'], 3)[0];
      hashrate24h =
          DashboardFunctions().hashrateConverter(data['hashrate_24h'], 3)[0];
      hashrate10minType =
          DashboardFunctions().hashrateConverter(data['hashrate_10m'], 3)[1];
      hashrate1hType =
          DashboardFunctions().hashrateConverter(data['hashrate_1h'], 3)[1];
      hashrate24hType =
          DashboardFunctions().hashrateConverter(data['hashrate_24h'], 3)[1];
    } else {
      hashrate10min =
          DashboardFunctions().hashrateConverterLTC(data['hashrate_10m'], 3)[0];

      hashrate1h =
          DashboardFunctions().hashrateConverterLTC(data['hashrate_1h'], 3)[0];
      hashrate24h =
          DashboardFunctions().hashrateConverterLTC(data['hashrate_24h'], 3)[0];
      hashrate10minType =
          DashboardFunctions().hashrateConverterLTC(data['hashrate_10m'], 3)[1];
      hashrate1hType =
          DashboardFunctions().hashrateConverterLTC(data['hashrate_1h'], 3)[1];
      hashrate24hType =
          DashboardFunctions().hashrateConverterLTC(data['hashrate_24h'], 3)[1];
    }
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Theme.of(context).colorScheme.secondary),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width / 1.25,
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: (data['status'] == 'DEAD')
                              ? Colors.grey
                              : (data['status'] == 'ONLINE')
                                  ? Colors.green
                                  : Colors.red),
                      width: 17 / 2,
                      height: 17 / 2,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      data['worker_name'],
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      date,
                      style: TextStyle(
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
                          LocaleKeys.current.tr(),
                          style: TextStyle(
                              fontSize: 14, color: AppColors().kPrimaryGrey),
                        ),
                        Text(hashrate10min + ' ' + hashrate10minType,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                            ))
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '1H',
                          style: TextStyle(
                              fontSize: 14, color: AppColors().kPrimaryGrey),
                        ),
                        Text(hashrate1h + ' ' + hashrate1hType,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                            ))
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '24 H',
                          style: TextStyle(
                              fontSize: 14, color: AppColors().kPrimaryGrey),
                        ),
                        Text(hashrate24h + ' ' + hashrate24hType,
                            style: TextStyle(
                              fontSize: 13,
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
    );
  }
}
