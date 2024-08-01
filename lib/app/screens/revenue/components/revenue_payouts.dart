import 'package:btcpool_app/app/screens/revenue/bloc/revenue_bloc.dart';
import 'package:btcpool_app/app/screens/revenue/components/revenue_payouts_card.dart';
import 'package:btcpool_app/app/widgets/custom_indicator.dart';
import 'package:btcpool_app/data/const.dart';
import 'package:btcpool_app/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RevenuePayouts extends StatelessWidget {
  const RevenuePayouts({super.key});

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
                  //         RevenueSetPayoutsPickedDates(
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
                  //                 Text(state.displayPayoutsDate[0]),
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
                  //                 Text(state.displayPayoutsDate[1]),
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
                  (state.isRLoading == false)
                      ? (state.payoutsData.length != 0)
                          ? Column(
                              children: state.payoutsData.map<Widget>((e) {
                                return Padding(
                                  padding: EdgeInsets.only(bottom: 8.0),
                                  child: RevenuePayoutsCard(
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
