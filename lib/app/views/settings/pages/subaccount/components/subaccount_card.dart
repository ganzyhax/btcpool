import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:btcpool_app/app/views/settings/pages/subaccount/components/subaccount_edit_wallet.dart';
import 'package:btcpool_app/app/views/settings/pages/subaccount/components/subaccount_splitted_edit_modal.dart';
import 'package:btcpool_app/app/components/custom_snackbar.dart';
import 'package:btcpool_app/local_data/const.dart';

class SubaccountCard extends StatelessWidget {
  final data;

  const SubaccountCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    log(data.toString());
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
            width: MediaQuery.of(context).size.width / 18,
            child: Text(
              data['id'].toString(),
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 13),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 8,
            child: Text(
              data['name'],
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 13),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 13,
            child: Text(
              '${double.parse(data['commission'].toString()).toStringAsFixed(1)}%',
              style: const TextStyle(fontSize: 13),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 14,
            child: Text(
              data['crypto_currency'],
              style: TextStyle(fontSize: 13),
            ),
          ),
          SizedBox(
              width: MediaQuery.of(context).size.width / 4,
              child: Tooltip(
                message: data['wallet_address'],
                triggerMode: TooltipTriggerMode.tap,
                child: Text(
                  data['wallet_address'],
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 13),
                ),
              )),
          SizedBox(
            width: MediaQuery.of(context).size.width / 10,
            child: Text(
              data['earning_scheme'],
              style: TextStyle(fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }
}
