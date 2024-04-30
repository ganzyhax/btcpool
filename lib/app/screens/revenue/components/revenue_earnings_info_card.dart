import 'package:btcpool_app/app/widgets/appbar/custom_title_appbar.dart';
import 'package:btcpool_app/app/widgets/buttons/custom_button.dart';
import 'package:btcpool_app/app/widgets/custom_data_card.dart';
import 'package:btcpool_app/data/const.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RevenueEarningsInfoCard extends StatelessWidget {
  final data;
  const RevenueEarningsInfoCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    print(data);
    DateTime dateTime = DateTime.parse(data['date'].toString());
    String date = DateFormat('MMM d, yyyy, HH:mm').format(dateTime);
    String hashrate =
        (double.parse(data['hashrate'].toString()) / 1e10).toStringAsFixed(3);
    return Scaffold(
      backgroundColor: AppColors().kPrimaryBackgroundColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: CustomTitleAppBar(
          title: 'Earnings',
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
              title: 'Hashrate',
              data: hashrate + ' TH/s',
            ),
            CustomDataCard(
              title: 'Income',
              data: '0.00010152 BTC',
            ),
            CustomDataCard(
              title: 'Est. Profitability (1 TH/s)',
              data: data['total_profit'].toString(),
            ),
            CustomDataCard(
              title: 'Calculation method',
              data: 'FPPS',
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              'Reward split',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 15,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 1.2,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Split'),
                  Text('Account name'),
                  Text('Amount'),
                ],
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 1.2,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('60%'),
                  Text('Bitcoind account'),
                  Text('0.0000018434 BTC'),
                ],
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('60%'),
                Text('Bitcoind account'),
                Text('0.0000018434 BTC'),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('60%'),
                Text('Bitcoind account'),
                Text('0.0000018434 BTC'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
