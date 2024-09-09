import 'package:btcpool_app/app/views/dashboard/bloc/dashboard_bloc.dart';
import 'package:btcpool_app/app/views/navigator/bloc/main_navigator_bloc.dart';
import 'package:btcpool_app/app/views/revenue/bloc/revenue_bloc.dart';
import 'package:btcpool_app/app/views/settings/pages/api/bloc/api_bloc.dart';
import 'package:btcpool_app/app/views/settings/pages/subaccount/subaccount_page.dart';
import 'package:btcpool_app/app/components/subaccount_item.dart';
import 'package:btcpool_app/local_data/const.dart';
import 'package:btcpool_app/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SubAccountCard extends StatelessWidget {
  const SubAccountCard({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showModalBottomSheet(
          context: context,
          backgroundColor: Theme.of(context).colorScheme.background,
          builder: (context) {
            return Padding(
              padding: const EdgeInsets.all(25.0),
              child: Wrap(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(),
                      Text(
                        LocaleKeys.subaccounts.tr(),
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                          BlocProvider.of<MainNavigatorBloc>(context)
                              .add(MainNavigatorChangePage(index: 2));
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SubAccountPage()),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: AppColors().kPrimaryGreen,
                              borderRadius: BorderRadius.circular(5)),
                          child: const Center(
                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height / 2,
                    child: SingleChildScrollView(
                      child: BlocBuilder<DashboardBloc, DashboardState>(
                        builder: (context, state) {
                          if (state is DashboardLoaded) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 15.0),
                              child: Column(
                                children: state.subAccounts.map<Widget>((e) {
                                  int index = state.subAccounts.indexOf(e);
                                  return InkWell(
                                      onTap: () {
                                        BlocProvider.of<DashboardBloc>(context)
                                            .add(DashboardChooseSubAccount(
                                                index: index));
                                        // BlocProvider.of<WorkersBloc>(context)
                                        //     .add(WorkersSubAccountIndexChange(
                                        //         index: index));
                                        BlocProvider.of<RevenueBloc>(context)
                                            .add(RevenueSubAccountIndexChange(
                                                index: index));
                                        BlocProvider.of<ApiBloc>(context).add(
                                            ApiSubAccountChange(index: index));
                                        Navigator.pop(context);
                                      },
                                      child: SubAccountItem(title: e['name']));
                                }).toList(),
                              ),
                            );
                          }
                          return Container();
                        },
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        );
      },
      child: Container(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColors().kPrimaryGreen),
        child: Row(
          children: [
            BlocBuilder<DashboardBloc, DashboardState>(
              builder: (context, state) {
                if (state is DashboardLoaded) {
                  return (state.subAccounts != null)
                      ? Text(
                          state.subAccounts[state.selectedSubAccout]['name']
                              .toString(),
                          style: const TextStyle(
                              fontSize: 14, color: Colors.white),
                        )
                      : Text('');
                }

                return Container();
              },
            ),
            const Icon(
              Icons.keyboard_arrow_down_rounded,
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}
