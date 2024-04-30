import 'package:btcpool_app/app/screens/revenue/components/revenue_payouts_info_card.dart';
import 'package:btcpool_app/data/const.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RevenuePayoutsCard extends StatelessWidget {
  final data;

  const RevenuePayoutsCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    print(data);
    DateTime dateTime = DateTime.parse(data['paid_date'].toString());
    String date = DateFormat('MMM d, yyyy, HH:mm').format(dateTime);

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => RevenuePayoutsInfoCard(
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
                            'Amount',
                            style: TextStyle(
                                fontSize: 12, color: AppColors().kPrimaryGrey),
                          ),
                          Text(data['amount'].toString() + ' BTC',
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
                            'TxID',
                            style: TextStyle(
                                fontSize: 12, color: AppColors().kPrimaryGrey),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 4,
                            child: Text(data['tx_id'],
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                )),
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Wallet',
                            style: TextStyle(
                                fontSize: 12, color: AppColors().kPrimaryGrey),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 4,
                            child: Text(data['address'].toString(),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                )),
                          )
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
