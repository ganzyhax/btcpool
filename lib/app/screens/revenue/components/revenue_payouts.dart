import 'package:btcpool_app/app/screens/revenue/bloc/revenue_bloc.dart';
import 'package:btcpool_app/app/screens/revenue/components/revenue_earnings_card.dart';
import 'package:btcpool_app/app/screens/revenue/components/revenue_payouts_card.dart';
import 'package:btcpool_app/app/screens/revenue/function/functions.dart';
import 'package:btcpool_app/app/widgets/custom_indicator.dart';
import 'package:btcpool_app/data/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RevenuePayouts extends StatelessWidget {
  const RevenuePayouts({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RevenueBloc, RevenueState>(
      builder: (context, state) {
        if (state is RevenueLoaded) {
          return Container(
            padding: EdgeInsets.all(12),
            color: AppColors().kPrimaryBackgroundColor,
            child: Column(
              children: [
                InkWell(
                  onTap: () async {
                    List pickedDates =
                        await RevenueFunctions().selectDateRange(context);
                    List formattedPickedDates =
                        RevenueFunctions().formatPickedDates(pickedDates);
                    BlocProvider.of<RevenueBloc>(context)
                      ..add(RevenueSetPayoutsPickedDates(
                          data: formattedPickedDates));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  10,
                                ),
                                color: AppColors().kPrimaryWhite),
                            padding: EdgeInsets.all(10),
                            child: Row(
                              children: [
                                Icon(Icons.calendar_month_outlined),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(state.displayPayoutsDate[0]),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text('to'),
                          SizedBox(
                            width: 5,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  10,
                                ),
                                color: AppColors().kPrimaryWhite),
                            padding: EdgeInsets.all(10),
                            child: Row(
                              children: [
                                Icon(Icons.calendar_month_outlined),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(state.displayPayoutsDate[1]),
                              ],
                            ),
                          )
                        ],
                      ),
                      Icon(Icons.arrow_circle_up_sharp)
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                (state.isLoading == false)
                    ? Column(
                        children: state.payoutsData.map<Widget>((e) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: RevenuePayoutsCard(
                              data: e,
                            ),
                          );
                        }).toList(),
                      )
                    : Center(
                        child: CustomIndicator(),
                      )
              ],
            ),
          );
        }
        return Container();
      },
    );
  }
}
