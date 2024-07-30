import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:btcpool_app/app/screens/settings/pages/referral/components/referral_created/components/referral_created_link_card.dart';
import 'package:btcpool_app/generated/locale_keys.g.dart';

class ReferralCreatedLinkList extends StatelessWidget {
  final data;
  const ReferralCreatedLinkList({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 5,
                    child: Text(
                      LocaleKeys.wallet.tr(),
                      style: const TextStyle(fontSize: 13),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 5,
                    child: Text(
                      LocaleKeys.pool_fee_for_client.tr() + ' %',
                      style: const TextStyle(fontSize: 13),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 7,
                    child: Text(
                      LocaleKeys.referral_fee.tr() + ' %',
                      style: const TextStyle(fontSize: 13),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 7,
                    child: Text(
                      LocaleKeys.reward_fee.tr() + ' %',
                      style: const TextStyle(fontSize: 13),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 7,
                    child: Text(
                      LocaleKeys.referral_link.tr(),
                      style: const TextStyle(fontSize: 13),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Column(
          children: data.map<Widget>((e) {
            return ReferralCreatedLinkCard(data: e);
          }).toList(),
        ),
      ],
    );
  }
}
