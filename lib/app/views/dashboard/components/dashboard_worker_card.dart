import 'dart:developer';

import 'package:btcpool_app/app/components/custom_line.dart';
import 'package:btcpool_app/app/views/dashboard/functions/functions.dart';
import 'package:btcpool_app/generated/locale_keys.g.dart';
import 'package:btcpool_app/local_data/const.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';

class DashboardWorkerCard extends StatelessWidget {
  final data;

  const DashboardWorkerCard({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
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
            LocaleKeys.active_miners.tr(),
            style: TextStyle(color: AppColors().kPrimaryGrey, fontSize: 21),
          ).tr(),
          Text(
            data[0].toString(),
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
                      (data[0] + data[1]).toString(),
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TransparentLine(color: Colors.green),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      LocaleKeys.total_obshii.tr(),
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
                      data[1].toString(),
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TransparentLine(color: Colors.red),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      LocaleKeys.inactive.tr(),
                      style: TextStyle(color: AppColors().kPrimaryGrey),
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
