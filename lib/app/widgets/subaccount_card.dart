import 'dart:convert';

import 'package:btcpool_app/app/screens/dashboard/bloc/dashboard_bloc.dart';
import 'package:btcpool_app/app/screens/navigator/bloc/main_navigator_bloc.dart';
import 'package:btcpool_app/app/screens/revenue/bloc/revenue_bloc.dart';
import 'package:btcpool_app/app/screens/settings/pages/api/bloc/api_bloc.dart';
import 'package:btcpool_app/app/screens/settings/pages/subaccount/subaccount_page.dart';
import 'package:btcpool_app/app/widgets/subaccount_item.dart';
import 'package:btcpool_app/data/const.dart';
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
          builder: (context) {
            return Padding(
              padding: const EdgeInsets.all(25.0),
              child: Wrap(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(),
                      Text(
                        'Subaccount',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                          BlocProvider.of<MainNavigatorBloc>(context)
                            ..add(MainNavigatorChangePage(index: 3));
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
                          child: Center(
                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  BlocBuilder<DashboardBloc, DashboardState>(
                    builder: (context, state) {
                      if (state is DashboardLoaded) {
                        return Column(
                          children: state.subAccounts.map<Widget>((e) {
                            int index = state.subAccounts.indexOf(e);
                            return InkWell(
                                onTap: () {
                                  BlocProvider.of<DashboardBloc>(context)
                                    ..add(DashboardChooseSubAccount(
                                        index: index));
                                  BlocProvider.of<RevenueBloc>(context)
                                    ..add(RevenueSubAccountIndexChange(
                                        index: index));
                                  BlocProvider.of<ApiBloc>(context)
                                    ..add(ApiSubAccountChange());
                                  Navigator.pop(context);
                                },
                                child: SubAccountItem(title: e['name']));
                          }).toList(),
                        );
                      }
                      return Container();
                    },
                  )
                ],
              ),
            );
          },
        );
      },
      child: Container(
        padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColors().kPrimaryGreen),
        child: Row(
          children: [
            BlocBuilder<DashboardBloc, DashboardState>(
              builder: (context, state) {
                if (state is DashboardLoaded) {
                  return Text(
                    state.subAccounts[state.selectedSubAccout]['name']
                        .toString(),
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  );
                }
                // if (state is DashboardLoadingSubAccount) {
                //   return Text(
                //     state.subAccounts[state.selectedSubAccout]['name']
                //         .toString(),
                //     style: TextStyle(fontSize: 14, color: Colors.white),
                //   );
                // }
                return Container();
              },
            ),
            Icon(
              Icons.keyboard_arrow_down_rounded,
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}
