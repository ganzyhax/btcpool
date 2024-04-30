import 'package:btcpool_app/app/screens/dashboard/bloc/dashboard_bloc.dart';
import 'package:btcpool_app/app/screens/dashboard/components/dashboard_balance_card.dart';
import 'package:btcpool_app/app/screens/dashboard/components/dashboard_hashrate_info_card.dart';
import 'package:btcpool_app/app/screens/dashboard/components/dashboard_url_card.dart';
import 'package:btcpool_app/app/screens/dashboard/components/dashborad_chart.dart';
import 'package:btcpool_app/app/widgets/appbar/custom_appbar.dart';
import 'package:btcpool_app/app/widgets/custom_indicator.dart';
import 'package:btcpool_app/data/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_indicator/loading_indicator.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors().kPrimaryBackgroundColor,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(60), child: CustomAppBar()),
      body: BlocBuilder<DashboardBloc, DashboardState>(
        builder: (context, state) {
          if (state is DashboardLoadingSubAccount) {
            return Center(child: CustomIndicator());
          }
          if (state is DashboardLoaded) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    (state.dashboardData != null)
                        ? Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  DashboardInfoCard(
                                    title: 'Balance',
                                    data: state.dashboardData['balance'],
                                  ),
                                  DashboardInfoCard(
                                    title: 'Total earnings',
                                    data: state.dashboardData['balance'],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  DashboardHashrateInfoCard(
                                    title: 'Hashrate \nCurrent/24H',
                                    isHashrate: false,
                                    data: [
                                      state.dashboardData['hashrate_10min'] /
                                          1e11,
                                      state.dashboardData['hashrate_1hour'] /
                                          1e11
                                    ],
                                  ),
                                  DashboardHashrateInfoCard(
                                    title: 'Workers \nOnline/Offline ',
                                    data: [
                                      state.dashboardData['active_workers'],
                                      state.dashboardData['unactive_workers']
                                    ],
                                    isHashrate: true,
                                  ),
                                ],
                              ),
                            ],
                          )
                        : CustomIndicator(),
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Text(
                        'Connection to mining',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      height: MediaQuery.of(context).size.height / 2.3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              InkWell(
                                onTap: () {
                                  BlocProvider.of<DashboardBloc>(context)
                                    ..add(DashboardChooseInterval(index: 0));
                                },
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width / 7,
                                  child: Column(children: [
                                    Text(
                                      '10 min',
                                      style: TextStyle(
                                          color: AppColors().kPrimaryGreen,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Divider(
                                      thickness:
                                          (state.selectedInterval == 0) ? 3 : 1,
                                      color: AppColors().kPrimaryGreen,
                                    )
                                  ]),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  BlocProvider.of<DashboardBloc>(context)
                                    ..add(DashboardChooseInterval(index: 1));
                                },
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width / 7,
                                  child: Column(children: [
                                    Text(
                                      '1 hour',
                                      style: TextStyle(
                                          color: AppColors().kPrimaryGreen,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Divider(
                                      thickness:
                                          (state.selectedInterval == 1) ? 3 : 1,
                                      color: AppColors().kPrimaryGreen,
                                    )
                                  ]),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  BlocProvider.of<DashboardBloc>(context)
                                    ..add(DashboardChooseInterval(index: 2));
                                },
                                child: SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width / 5.6,
                                  child: Column(children: [
                                    Text(
                                      '24 hours',
                                      style: TextStyle(
                                          color: AppColors().kPrimaryGreen,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Divider(
                                      thickness:
                                          (state.selectedInterval == 2) ? 3 : 1,
                                      color: AppColors().kPrimaryGreen,
                                    )
                                  ]),
                                ),
                              )
                            ],
                          ),
                          (state.hashrates != null)
                              ? Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20)),
                                  height:
                                      MediaQuery.of(context).size.height / 2.7,
                                  padding: EdgeInsets.only(
                                      left: 5, right: 5, top: 0, bottom: 25),
                                  width: MediaQuery.of(context).size.width,
                                  child: MiningPowerChart(
                                    times: state.hashrates
                                        .map((data) {
                                          return DateTime
                                              .fromMillisecondsSinceEpoch(
                                                  (data['date'] as double)
                                                          .toInt() *
                                                      1000,
                                                  isUtc: true);
                                        })
                                        .toList()
                                        .cast<DateTime>(),
                                    powerValues: state.hashrates.map((data) {
                                      return (data['speed'] as double);
                                    }).toList(), // Corresponding power values for each hour
                                  ))
                              : Center(child: CustomIndicator())
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Text(
                        'Connection to mining',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    (state.strumUrls != null)
                        ? DashboardUrlCard(
                            data: state.strumUrls,
                          )
                        : CustomIndicator(),
                  ],
                ),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
