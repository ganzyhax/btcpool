import 'dart:developer';

import 'package:btcpool_app/app/components/custom_line.dart';
import 'package:btcpool_app/app/views/dashboard/functions/functions.dart';
import 'package:btcpool_app/generated/locale_keys.g.dart';
import 'package:btcpool_app/local_data/const.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';

class DashboardHashrateInfoCard extends StatelessWidget {
  final data;
  final String title;
  final bool isHashrate;
  final String selectedCrpyto;
  const DashboardHashrateInfoCard(
      {super.key,
      required this.data,
      required this.selectedCrpyto,
      required this.title,
      required this.isHashrate});

  @override
  Widget build(BuildContext context) {
    log(data.toString());
    var h10;
    var h24;
    var h1;
    if (selectedCrpyto == 'LTC') {
      h10 = DashboardFunctions().hashrateConverterLTC(data[0].toDouble(), 2);
      h24 = DashboardFunctions().hashrateConverterLTC(data[0].toDouble(), 2);
      h1 = DashboardFunctions().hashrateConverterLTC(data[1].toDouble(), 2);
    } else {
      h10 = DashboardFunctions().hashrateConverter(data[0].toDouble(), 2);
      h24 = DashboardFunctions().hashrateConverter(data[0].toDouble(), 2);
      h1 = DashboardFunctions().hashrateConverter(data[1].toDouble(), 2);
    }
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Theme.of(context).colorScheme.secondary),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LocaleKeys.total_average_hashrate_10min.tr(),
            style: TextStyle(color: AppColors().kPrimaryGrey, fontSize: 21),
          ).tr(),
          const SizedBox(
            height: 5,
          ),
          Text(
            h10[0] + ' ' + h10[1],
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          SizedBox(
            height: 25,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: MediaQuery.of(context).size.width / 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      h1[0] + ' ' + h1[1],
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TransparentLine(color: Colors.orange),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      LocaleKeys.for_hour.tr(),
                      style: TextStyle(color: AppColors().kPrimaryGrey),
                    )
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width / 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      h24[0] + ' ' + h24[1],
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TransparentLine(color: Colors.orange),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      LocaleKeys.for_day.tr(),
                      style: TextStyle(color: AppColors().kPrimaryGrey),
                    )
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
