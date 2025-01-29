import 'dart:developer';

import 'package:btcpool_app/app/views/dashboard/functions/functions.dart';
import 'package:btcpool_app/local_data/const.dart';
import 'package:flutter/material.dart';

class WorkersHashrateInfoCard extends StatelessWidget {
  final data;
  final String title;
  final String selectedCrpyto;
  const WorkersHashrateInfoCard(
      {super.key,
      required this.data,
      required this.title,
      required this.selectedCrpyto});

  @override
  Widget build(BuildContext context) {
    var h10;
    var h1;
    var h24;
    log(data.toString() + 'adadadad');
    if (selectedCrpyto == 'LTC') {
      h10 = DashboardFunctions().hashrateConverterLTC(data[0].toDouble(), 1);
      h1 = DashboardFunctions().hashrateConverterLTC(data[1].toDouble(), 1);
      h24 = DashboardFunctions().hashrateConverterLTC(data[2].toDouble(), 1);
    } else {
      h10 = DashboardFunctions().hashrateConverter(data[0].toDouble(), 1);
      h1 = DashboardFunctions().hashrateConverter(data[1].toDouble(), 1);
      h24 = DashboardFunctions().hashrateConverter(data[2].toDouble(), 1);
    }

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
            style: TextStyle(color: AppColors().kPrimaryGrey, fontSize: 16),
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              SizedBox(
                  width: MediaQuery.of(context).size.width / 3,
                  child: Text(
                    h10[0] + '/' + h1[0] + '/' + h24[0],
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 12),
                  )),
              Text(
                h24[1],
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors().kPrimaryGrey,
                    fontSize: 12),
              ),
            ],
          )
        ],
      ),
    );
  }
}
