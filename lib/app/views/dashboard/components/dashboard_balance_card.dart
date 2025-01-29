import 'package:btcpool_app/app/components/custom_line.dart';
import 'package:btcpool_app/local_data/const.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';

class DashboardInfoCard extends StatelessWidget {
  final data;
  final String title;
  final double btcPrice;
  final String cryptocurrency;
  const DashboardInfoCard(
      {super.key,
      required this.data,
      required this.cryptocurrency,
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
          Row(
            children: [
              Text(
                title,
                style: TextStyle(color: AppColors().kPrimaryGrey, fontSize: 21),
              ).tr(),
              SizedBox(
                width: 10,
              ),
              SizedBox(
                height: 25,
                child: Image.asset('assets/images/btc_logo.png'),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Row(
                    children: [
                      Text(
                        data.toString(),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 24),
                      ),
                      Text(
                        '≈' + priceInUsd + '\$',
                        style: TextStyle(
                            color: AppColors().kPrimaryGrey, fontSize: 24),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          SizedBox(
              width: MediaQuery.of(context).size.width / 3,
              child: TransparentLine(color: Colors.blue)),
          SizedBox(
            height: 10,
          ),
          Text(
            cryptocurrency,
            style: TextStyle(color: AppColors().kPrimaryGrey, fontSize: 16),
            textAlign: TextAlign.end,
          )
        ],
      ),
    );
  }
}
