import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:btcpool_app/app/widgets/custom_snackbar.dart';
import 'package:btcpool_app/data/const.dart';

class ReferralCreatedLinkCard extends StatelessWidget {
  final data;

  const ReferralCreatedLinkCard({super.key, required this.data});

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
            width: MediaQuery.of(context).size.width / 5,
            child: Tooltip(
              triggerMode: TooltipTriggerMode.tap,
              message: data['wallet_address'],
              child: Text(
                data['wallet_address'],
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 13),
              ),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 5,
            child: Text(
              '${double.parse(data['pool_fee']).toStringAsFixed(0)}%',
              style: const TextStyle(fontSize: 13),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 7,
            child: Text(
              '${double.parse(data['referral_fee']).toStringAsFixed(0)}%',
              style: const TextStyle(fontSize: 13),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 7,
            child: Text(
              '${double.parse(data['reward_fee']).toStringAsFixed(1)}%',
              style: const TextStyle(fontSize: 13),
            ),
          ),
          InkWell(
            onTap: () {
              Clipboard.setData(ClipboardData(
                  text: 'https://21pool.io/auth/signup?r=' + data['link_id']));
              CustomSnackbar().showCustomSnackbar(context, 'Copied!', true);
            },
            child: SizedBox(
                width: MediaQuery.of(context).size.width / 7,
                child: Center(
                  child: Icon(
                    Icons.copy,
                    color: AppColors().kPrimaryGreen,
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
