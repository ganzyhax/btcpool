import 'package:btcpool_app/app/screens/revenue/components/revenue_earnings_info_card.dart';
import 'package:btcpool_app/data/const.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RevenueEarningsCard extends StatelessWidget {
  final data;

  const RevenueEarningsCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    print(data);
    DateTime dateTime = DateTime.parse(data['date'].toString());
    String date = DateFormat('MMM d, yyyy, HH:mm').format(dateTime);
    String hashrate =
        (double.parse(data['hashrate'].toString()) / 1e10).toStringAsFixed(3);
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => RevenueEarningsInfoCard(
                    data: data,
                  )),
        );
      },
      child: Container(
        padding: EdgeInsets.all(14),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: AppColors().kPrimaryWhite),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: MediaQuery.of(context).size.width / 1.2,
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        date,
                        style: TextStyle(
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Income',
                            style: TextStyle(
                                fontSize: 12, color: AppColors().kPrimaryGrey),
                          ),
                          Text('0.00010152 BTC',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                              ))
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hashrate',
                            style: TextStyle(
                                fontSize: 12, color: AppColors().kPrimaryGrey),
                          ),
                          Text(hashrate + ' TH/s',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                              ))
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Est. Profitability',
                            style: TextStyle(
                                fontSize: 12, color: AppColors().kPrimaryGrey),
                          ),
                          Text(data['total_profit'].toString() + ' BTC',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                              ))
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              width: 12,
              child: Icon(
                Icons.arrow_forward_ios_outlined,
                size: 20,
              ),
            )
          ],
        ),
      ),
    );
  }
}
