import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:btcpool_app/app/widgets/custom_snackbar.dart';
import 'package:btcpool_app/data/const.dart';

class ReferralUsersLinkCard extends StatelessWidget {
  final data;

  const ReferralUsersLinkCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    DateTime originalDateTime = DateTime.parse(data['date_joined'].toString());
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
              style: const TextStyle(fontSize: 13),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 5,
            child: Tooltip(
              triggerMode: TooltipTriggerMode.tap,
              message: data['username'].toString(),
              child: Text(
                data['username'].toString(),
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 13),
              ),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 7,
            child: Tooltip(
              triggerMode: TooltipTriggerMode.tap,
              message: data['email'].toString(),
              child: Text(
                data['email'].toString(),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 13),
              ),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 7,
            child: Tooltip(
              triggerMode: TooltipTriggerMode.tap,
              message: data['country']['name_official'].toString(),
              child: Text(
                data['country']['name_official'].toString(),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 13),
              ),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 7,
            child: Text(
              '${double.parse(data['referral_fee'].toString()).toStringAsFixed(0)}%',
              style: const TextStyle(fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }
}
