import 'dart:developer';

import 'package:btcpool_app/app/views/dashboard/bloc/dashboard_bloc.dart';
import 'package:btcpool_app/app/views/dashboard/components/dashboard_balance_card.dart';
import 'package:btcpool_app/app/views/dashboard/components/dashboard_hashrate_info_card.dart';
import 'package:btcpool_app/app/views/dashboard/components/dashboard_url_card.dart';
import 'package:btcpool_app/app/views/dashboard/components/dashboard_worker_card.dart';
import 'package:btcpool_app/app/views/dashboard/components/dashborad_chart.dart';
import 'package:btcpool_app/app/views/revenue/bloc/revenue_bloc.dart';
import 'package:btcpool_app/app/components/appbar/custom_appbar.dart';
import 'package:btcpool_app/app/components/custom_indicator.dart';
import 'package:btcpool_app/app/components/custom_snackbar.dart';
import 'package:btcpool_app/app/components/modal/custom_modal.dart';
import 'package:btcpool_app/app/components/modal/custom_update.dart';
import 'package:btcpool_app/local_data/const.dart';
import 'package:btcpool_app/generated/locale_keys.g.dart';
import 'package:btcpool_app/utils/applifecycler.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final LifecycleService _appLifecycleObserver = LifecycleService();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(_appLifecycleObserver);
    _appLifecycleObserver.setContext(context); // Pass the context here
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(_appLifecycleObserver);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60), child: CustomAppBar()),
      body: BlocListener<DashboardBloc, DashboardState>(
        listener: (context, state) {
          if (state is DashboardInternetException) {
            CustomSnackbar().showCustomSnackbar(
                context, 'Internet connection error...', false);
          }
          if (state is DashboardShowingSubAccountModal) {
            showDialog(
              barrierDismissible: false,
              context: context,
              builder: (BuildContext context) {
                return CustomModal();
              },
            );
          }
          if (state is DashboardShowUpdate) {
            showDialog(
              barrierDismissible: false,
              context: context,
              builder: (BuildContext context) {
                return UpdateModal(
                  withSkip: state.withSkip,
                );
              },
            );
          }
        },
        child: BlocBuilder<DashboardBloc, DashboardState>(
          builder: (context, state) {
            if (state is DashboardCreateSubAccountModal) {
              BlocProvider.of<DashboardBloc>(context)
                ..add(DashboardSubAccountCreateShowModal());
            }
            if (state is DashboardLoadingSubAccount) {
              return Center(child: CustomIndicator());
            }
            if (state is DashboardLoaded) {
              log(state.dashboardData['data'].toString());
              return RefreshIndicator(
                color: AppColors().kPrimaryGreen,
                onRefresh: () async {
                  BlocProvider.of<DashboardBloc>(context)
                    ..add(DashboardRefresh());
                  BlocProvider.of<RevenueBloc>(context)..add(RevenueLoad());
                  await Future.delayed(Duration(seconds: 5));
                },
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        (state.dashboardData != null)
                            ? Column(
                                children: [
                                  DashboardInfoCard(
                                    btcPrice: state.btcPrice,
                                    title: LocaleKeys.balance,
                                    data: state.dashboardData['data']
                                        ['balance'],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  DashboardHashrateInfoCard(
                                    title: LocaleKeys.hashrate_card_t1,
                                    isHashrate: false,
                                    data: [
                                      state.dashboardData['data']
                                          ['hashrate_10min'],
                                      state.dashboardData['data']
                                          ['hashrate_24hour'],
                                      state.dashboardData['data']
                                          ['hashrate_1hour']
                                    ],
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  DashboardWorkerCard(
                                    data: [
                                      state.dashboardData['data']
                                          ['active_workers'],
                                      state.dashboardData['data']
                                          ['unactive_workers']
                                    ],
                                  )
                                ],
                              )
                            : CustomIndicator(),
                        const SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: Text(
                            LocaleKeys.chart,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600),
                          ).tr(),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 10),
                          decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.secondary,
                              borderRadius: BorderRadius.circular(20)),
                          height: MediaQuery.of(context).size.height / 2.6,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      BlocProvider.of<DashboardBloc>(context)
                                          .add(DashboardChooseInterval(
                                              index: 0));
                                    },
                                    child: SizedBox(
                                      width:
                                          MediaQuery.of(context).size.width / 7,
                                      child: Column(children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "1 ",
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  color:
                                                      AppColors().kPrimaryGreen,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            Text(
                                              LocaleKeys.hour,
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  color:
                                                      AppColors().kPrimaryGreen,
                                                  fontWeight: FontWeight.w600),
                                            ).tr(),
                                          ],
                                        ),
                                        Divider(
                                          thickness:
                                              (state.selectedInterval == 0)
                                                  ? 3
                                                  : 1,
                                          color: AppColors().kPrimaryGreen,
                                        )
                                      ]),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      BlocProvider.of<DashboardBloc>(context)
                                          .add(DashboardChooseInterval(
                                              index: 1));
                                    },
                                    child: SizedBox(
                                      width:
                                          MediaQuery.of(context).size.width / 7,
                                      child: Column(children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "24 ",
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  color:
                                                      AppColors().kPrimaryGreen,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            Text(
                                              LocaleKeys.hour,
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  color:
                                                      AppColors().kPrimaryGreen,
                                                  fontWeight: FontWeight.w600),
                                            ).tr(),
                                          ],
                                        ),
                                        Divider(
                                          thickness:
                                              (state.selectedInterval == 1)
                                                  ? 3
                                                  : 1,
                                          color: AppColors().kPrimaryGreen,
                                        )
                                      ]),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      BlocProvider.of<DashboardBloc>(context)
                                          .add(DashboardChooseInterval(
                                              index: 2));
                                    },
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width /
                                          5.6,
                                      child: Column(children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              '30 ',
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  color:
                                                      AppColors().kPrimaryGreen,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            Text(
                                              LocaleKeys.day,
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  color:
                                                      AppColors().kPrimaryGreen,
                                                  fontWeight: FontWeight.w600),
                                            ).tr(),
                                          ],
                                        ),
                                        Divider(
                                          thickness:
                                              (state.selectedInterval == 2)
                                                  ? 3
                                                  : 1,
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
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      height:
                                          MediaQuery.of(context).size.height /
                                              3.2,
                                      padding: const EdgeInsets.only(
                                          left: 5,
                                          right: 5,
                                          top: 0,
                                          bottom: 25),
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
                                          powerValues: (state.hashrates is List)
                                              ? (state.hashrates as List)
                                                  .map((data) {
                                                  // Use a dynamic map here to avoid casting issues
                                                  final mapData =
                                                      Map<String, dynamic>.from(
                                                          data as Map);
                                                  return (mapData['speed']
                                                          as num)
                                                      .toDouble();
                                                }).toList()
                                              : (state.hashrates['hashrates']
                                                      as List)
                                                  .map((data) {
                                                  // Use a dynamic map here to avoid casting issues
                                                  final mapData =
                                                      Map<String, dynamic>.from(
                                                          data as Map);
                                                  return (mapData['speed']
                                                          as num)
                                                      .toDouble();
                                                }).toList()),
                                    )
                                  : Center(child: CustomIndicator())
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Center(
                          child: Text(
                            LocaleKeys.connection_to_mining,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600),
                          ).tr(),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        (state.strumUrls != null)
                            ? DashboardUrlCard(
                                workerName:
                                    state.subAccounts[state.selectedSubAccout]
                                        ['name'],
                                data: state.strumUrls,
                              )
                            : CustomIndicator(),
                      ],
                    ),
                  ),
                ),
              );
            }
            return Center(
              child: CustomIndicator(),
            );
          },
        ),
      ),
    );
  }
}
