import 'dart:developer';

import 'package:btcpool_app/app/screens/dashboard/functions/functions.dart';
import 'package:btcpool_app/data/const.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';

class DashboardHashrateInfoCard extends StatelessWidget {
  final data;
  final String title;
  final bool isHashrate;

  const DashboardHashrateInfoCard(
      {super.key,
      required this.data,
      required this.title,
      required this.isHashrate});

  @override
  Widget build(BuildContext context) {
    var h10 = DashboardFunctions().hashrateConverter(data[0].toDouble(), 2);
    var h24 = DashboardFunctions().hashrateConverter(data[1].toDouble(), 2);

    return Container(
      width: MediaQuery.of(context).size.width / 2.2,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Theme.of(context).colorScheme.secondary),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(color: AppColors().kPrimaryGrey, fontSize: 15),
          ).tr(),
          const SizedBox(
            height: 5,
          ),
          (isHashrate == false)
              ? Row(
                  children: [
                    SizedBox(
                        width: MediaQuery.of(context).size.width / 3.1,
                        child: Text(
                          '${h10[0]}/${h24[0]}',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 13),
                        )),
                    Text(
                      h24[1].toString(),
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors().kPrimaryGrey,
                          fontSize: 13),
                    ),
                  ],
                )
              : Row(
                  children: [
                    Text(data[0].toString(),
                        style: const TextStyle(
                            fontSize: 13,
                            color: Colors.green,
                            fontWeight: FontWeight.bold)),
                    const Text('/',
                        style: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.bold)),
                    Text(data[1].toString(),
                        style: const TextStyle(
                            fontSize: 13,
                            color: Colors.red,
                            fontWeight: FontWeight.bold)),
                  ],
                )
        ],
      ),
    );
  }
}
