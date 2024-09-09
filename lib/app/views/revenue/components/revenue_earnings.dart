import 'package:btcpool_app/app/views/revenue/bloc/revenue_bloc.dart';
import 'package:btcpool_app/app/views/revenue/components/revenue_earnings_card.dart';
import 'package:btcpool_app/app/views/revenue/function/functions.dart';
import 'package:btcpool_app/app/components/custom_indicator.dart';
import 'package:btcpool_app/local_data/const.dart';
import 'package:btcpool_app/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RevenueEarnings extends StatelessWidget {
  const RevenueEarnings({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RevenueBloc, RevenueState>(
      builder: (context, state) {
        if (state is RevenueLoaded) {
          return SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(12),
              color: Theme.of(context).colorScheme.background,
              child: Column(
                children: [
                  // InkWell(
                  //   onTap: () async {
                  //     List pickedDates =
                  //         await RevenueFunctions().selectDateRange(context);
                  //     List formattedPickedDates =
                  //         RevenueFunctions().formatPickedDates(pickedDates);
                  //     BlocProvider.of<RevenueBloc>(context).add(
                  //         RevenueSetEarningsPickedDates(
                  //             data: formattedPickedDates));
                  //   },
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.start,
                  //     children: [
                  //       Row(
                  //         children: [
                  //           Container(
                  //             decoration: BoxDecoration(
                  //                 borderRadius: BorderRadius.circular(
                  //                   10,
                  //                 ),
                  //                 color:
                  //                     Theme.of(context).colorScheme.secondary),
                  //             padding: const EdgeInsets.all(10),
                  //             child: Row(
                  //               children: [
                  //                 const Icon(Icons.calendar_month_outlined),
                  //                 const SizedBox(
                  //                   width: 10,
                  //                 ),
                  //                 Text(state.displayEarningsDate[0]),
                  //               ],
                  //             ),
                  //           ),
                  //           const SizedBox(
                  //             width: 5,
                  //           ),
                  //           const Text('to'),
                  //           const SizedBox(
                  //             width: 5,
                  //           ),
                  //           Container(
                  //             decoration: BoxDecoration(
                  //                 borderRadius: BorderRadius.circular(
                  //                   10,
                  //                 ),
                  //                 color:
                  //                     Theme.of(context).colorScheme.secondary),
                  //             padding: const EdgeInsets.all(10),
                  //             child: Row(
                  //               children: [
                  //                 const Icon(Icons.calendar_month_outlined),
                  //                 const SizedBox(
                  //                   width: 10,
                  //                 ),
                  //                 Text(state.displayEarningsDate[1]),
                  //               ],
                  //             ),
                  //           )
                  //         ],
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  const SizedBox(
                    height: 15,
                  ),
                  (state.isELoading == false)
                      ? (state.earningsData.length != 0)
                          ? Column(
                              children: state.earningsData.map<Widget>((e) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: RevenueEarningsCard(
                                    data: e,
                                  ),
                                );
                              }).toList(),
                            )
                          : Center(
                              child: Text(
                                LocaleKeys.the_table_is_empty.tr(),
                                style:
                                    TextStyle(color: AppColors().kPrimaryGreen),
                              ),
                            )
                      : Center(
                          child: CustomIndicator(),
                        )
                ],
              ),
            ),
          );
        }
        return Container();
      },
    );
  }
}
