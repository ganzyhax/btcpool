import 'package:btcpool_app/local_data/const.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';

class DashboardInfoCard extends StatelessWidget {
  final data;
  final String title;
  final double btcPrice;

  const DashboardInfoCard(
      {super.key,
      required this.data,
      required this.title,
      required this.btcPrice});

  @override
  Widget build(BuildContext context) {
    double d = data * btcPrice;
    String priceInUsd = d.toStringAsFixed(2);
    return Container(
      width: MediaQuery.of(context).size.width,
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
            style: TextStyle(color: AppColors().kPrimaryGrey, fontSize: 21),
          ).tr(),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SizedBox(
                    height: 45,
                    child: Image.asset('assets/images/btc_logo.png'),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Row(
                    children: [
                      Text(
                        data.toString(),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 21),
                      ),
                      Text(
                        '≈' + priceInUsd + '\$',
                        style: TextStyle(
                            color: AppColors().kPrimaryGrey, fontSize: 21),
                      ),
                    ],
                  ),
                ],
              ),
              Text(
                'BTC',
                style: TextStyle(color: AppColors().kPrimaryGrey, fontSize: 21),
                textAlign: TextAlign.end,
              )
            ],
          )
        ],
      ),
    );
  }
}
