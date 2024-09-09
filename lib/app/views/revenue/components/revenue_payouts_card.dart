import 'package:easy_localization/easy_localization.dart';
import 'package:btcpool_app/app/views/revenue/components/revenue_payouts_info_card.dart';
import 'package:btcpool_app/local_data/const.dart';
import 'package:flutter/material.dart';
import 'package:btcpool_app/generated/locale_keys.g.dart';

class RevenuePayoutsCard extends StatelessWidget {
  final data;

  const RevenuePayoutsCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    Locale currentLocale = context.locale;

    DateTime dateTime = DateTime.parse(data['paid_date'].toString());
    String date = DateFormat('MMM d, yyyy, HH:mm', currentLocale.toString())
        .format(dateTime);

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
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Theme.of(context).colorScheme.secondary),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width / 1.2,
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        date,
                        style: const TextStyle(
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            LocaleKeys.amount.tr(),
                            style: TextStyle(
                                fontSize: 12, color: AppColors().kPrimaryGrey),
                          ),
                          Text(
                              '${double.parse(data['amount'].toString()).toStringAsFixed(8)} BTC',
                              style: const TextStyle(
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
                                style: const TextStyle(
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
                            LocaleKeys.wallet.tr(),
                            style: TextStyle(
                                fontSize: 12, color: AppColors().kPrimaryGrey),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 4,
                            child: Text(data['address'].toString(),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
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
            const SizedBox(
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
