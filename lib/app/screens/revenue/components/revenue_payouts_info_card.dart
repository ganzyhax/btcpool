import 'package:btcpool_app/app/widgets/appbar/custom_title_appbar.dart';
import 'package:btcpool_app/app/widgets/buttons/custom_button.dart';
import 'package:btcpool_app/app/widgets/custom_data_card.dart';
import 'package:btcpool_app/data/const.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RevenuePayoutsInfoCard extends StatelessWidget {
  final data;
  const RevenuePayoutsInfoCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    print(data);
    DateTime dateTime = DateTime.parse(data['paid_date'].toString());
    String date = DateFormat('MMM d, yyyy, HH:mm').format(dateTime);

    return Scaffold(
      backgroundColor: AppColors().kPrimaryBackgroundColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: CustomTitleAppBar(
          title: 'Payouts',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomDataCard(
              title: 'Date',
              data: date,
            ),
            CustomDataCard(
              title: 'TxID',
              data: data['tx_id'],
            ),
            CustomDataCard(
              title: 'Amount',
              data: data['amount'].toString() + ' BTC',
            ),
            CustomDataCard(
              title: 'Wallet',
              data: data['address'].toString(),
            ),
          ],
        ),
      ),
    );
  }
}
