import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:btcpool_app/app/screens/settings/pages/referral/components/referral_created/components/referral_created_users_card.dart';
import 'package:btcpool_app/generated/locale_keys.g.dart';

class ReferralUsersLinkList extends StatelessWidget {
  final data;
  const ReferralUsersLinkList({super.key, required this.data});

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
                      LocaleKeys.registration_date.tr(),
                      style: const TextStyle(fontSize: 13),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 5,
                    child: Text(
                      LocaleKeys.user_name.tr(),
                      style: const TextStyle(fontSize: 13),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 7,
                    child: const Text(
                      'E-mail',
                      style: TextStyle(fontSize: 13),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 7,
                    child: Text(
                      LocaleKeys.country.tr(),
                      style: const TextStyle(fontSize: 13),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 7,
                    child: Text(
                      LocaleKeys.referral_fee.tr() + '%',
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
            return ReferralUsersLinkCard(data: e);
          }).toList(),
        ),
      ],
    );
  }
}
