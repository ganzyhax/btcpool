import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:btcpool_app/app/widgets/custom_snackbar.dart';
import 'package:btcpool_app/data/const.dart';

class ReferralEarningsLinkCard extends StatelessWidget {
  final data;

  const ReferralEarningsLinkCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    double inTh = double.parse(data['hashrate'].toString()) / 1e6;
    inTh = (inTh < 1000)
        ? inTh
        : (data.y >= 1000 && data.y < 1000000)
            ? inTh / 1000
            : inTh / 1000000;
    String hType = (inTh < 1000)
        ? ' TH/s'
        : (data.y >= 1000 && data.y < 1000000)
            ? ' PH/s'
            : ' EH/s';
    DateTime originalDateTime =
        DateTime.parse(data['earnings_for_str'].toString());
    DateTime newDateTime = DateTime(
        originalDateTime.year, originalDateTime.month, originalDateTime.day);
    String formattedDate =
        DateFormat('yyyy-MM-dd HH:mm:ss').format(newDateTime);

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Theme.of(context).colorScheme.secondary,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width / 5,
            child: Text(
              formattedDate,
              // overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 13),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 5,
            child: Text(
              (inTh).toStringAsFixed(3) + hType,
              style: const TextStyle(fontSize: 13),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 7,
            child: Text(
              double.parse(data['profit'].toString()).toStringAsFixed(8),
              style: const TextStyle(fontSize: 13),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 7,
            child: Text(
              data['referral_user'],
              style: const TextStyle(fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }
}
