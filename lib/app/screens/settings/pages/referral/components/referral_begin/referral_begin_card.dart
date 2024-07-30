import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:btcpool_app/generated/locale_keys.g.dart';

class ReferralBeginCard extends StatelessWidget {
  final data;

  const ReferralBeginCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
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
            width: MediaQuery.of(context).size.width / 12,
            child: Text(
              data['number'],
              style: const TextStyle(fontSize: 13),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 7,
            child: Text(
              data['level'],
              style: const TextStyle(fontSize: 13),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 5,
            child: Text(
              data['pool_fee'] + '%',
              style: const TextStyle(fontSize: 13),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 7,
            child: Text(
              data['referral_fee'] + '%',
              style: const TextStyle(fontSize: 13),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 7,
            child: Text(
              data['reward_fee'] + '%',
              style: const TextStyle(fontSize: 13),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 7,
            child: Text(
              data['status'],
              style: TextStyle(
                  fontSize: 13,
                  color: (data['status'] == LocaleKeys.unavailable.tr()
                      ? Colors.red
                      : Colors.green)),
            ),
          ),
        ],
      ),
    );
  }
}
