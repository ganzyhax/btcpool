import 'dart:developer';

import 'package:btcpool_app/app/components/appbar/custom_appbar.dart';
import 'package:btcpool_app/app/components/custom_indicator.dart';
import 'package:btcpool_app/app/components/textfields/custom_textfiled.dart';
import 'package:btcpool_app/app/views/dashboard/bloc/dashboard_bloc.dart';
import 'package:btcpool_app/app/views/dashboard/components/dashboard_hashrate_info_card.dart';
import 'package:btcpool_app/app/views/workers/bloc/workers_bloc.dart';
import 'package:btcpool_app/app/views/workers/components/workers_card.dart';
import 'package:btcpool_app/app/views/workers/components/workers_hashrate_card.dart';
import 'package:btcpool_app/app/views/workers/components/workers_info_page.dart';
import 'package:btcpool_app/app/views/workers/components/workers_tab_card.dart';
import 'package:btcpool_app/generated/locale_keys.g.dart';
import 'package:btcpool_app/local_data/const.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WorkersScreen extends StatelessWidget {
  const WorkersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController search = TextEditingController();
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: CustomAppBar(
            title: LocaleKeys.workers,
          )),
      body: RefreshIndicator(
          color: AppColors().kPrimaryGreen,
          onRefresh: () async {
            BlocProvider.of<WorkersBloc>(context)..add(WorkersRefresh());
            await Future.delayed(
              Duration(
                seconds: 4,
              ),
            );
          },
          child: BlocBuilder<WorkersBloc, WorkersState>(
            builder: (context, state) {
              if (state is WorkersLoaded) {
                return SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Stack(
                    children: [
                      Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: (state.dashboardData != null)
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    BlocBuilder<DashboardBloc, DashboardState>(
                                      builder: (context, stateDashboard) {
                                        if (stateDashboard is DashboardLoaded) {
                                          log(state.dashboardData.toString() +
                                              'adadad');

                                          return (stateDashboard
                                                      .dashboardData !=
                                                  null)
                                              ? Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    DashboardHashrateInfoCard(
                                                      selectedCrpyto: stateDashboard
                                                          .selectedSubAccountCurrency,
                                                      title: LocaleKeys
                                                          .workers_card_t1,
                                                      data: [
                                                        stateDashboard.dashboardData[
                                                                    'data'][
                                                                'active_workers'] ??
                                                            'N/A',
                                                        stateDashboard.dashboardData[
                                                                    'data'][
                                                                'unactive_workers'] ??
                                                            'N/A'
                                                      ],
                                                      isHashrate: true,
                                                    ),
                                                    const SizedBox(
                                                      height: 15,
                                                    ),
                                                    SingleChildScrollView(
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      child: Row(
                                                        children: [
                                                          InkWell(
                                                            onTap: () {
                                                              BlocProvider.of<
                                                                          WorkersBloc>(
                                                                      context)
                                                                  .add(WorkersChangeIndex(
                                                                      index:
                                                                          0));
                                                            },
                                                            child:
                                                                WorkersTabCard(
                                                              title: LocaleKeys
                                                                  .all,
                                                              data: (stateDashboard.dashboardData['data']['active_workers'] +
                                                                      stateDashboard
                                                                              .dashboardData['data']
                                                                          [
                                                                          'unactive_workers'] +
                                                                      stateDashboard
                                                                              .dashboardData['data']
                                                                          [
                                                                          'unactive_workers'])
                                                                  .toString(),
                                                              isSelected:
                                                                  (state.selectedTab ==
                                                                          0)
                                                                      ? true
                                                                      : false,
                                                              color:
                                                                  Colors.green,
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            width: 5,
                                                          ),
                                                          InkWell(
                                                            onTap: () {
                                                              BlocProvider.of<
                                                                          WorkersBloc>(
                                                                      context)
                                                                  .add(WorkersChangeIndex(
                                                                      index:
                                                                          1));
                                                            },
                                                            child:
                                                                WorkersTabCard(
                                                              title: LocaleKeys
                                                                  .online,
                                                              data: stateDashboard
                                                                  .dashboardData[
                                                                      'data'][
                                                                      'active_workers']
                                                                  .toString(),
                                                              isSelected:
                                                                  (state.selectedTab ==
                                                                          1)
                                                                      ? true
                                                                      : false,
                                                              color:
                                                                  Colors.green,
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            width: 5,
                                                          ),
                                                          InkWell(
                                                            onTap: () {
                                                              BlocProvider.of<
                                                                          WorkersBloc>(
                                                                      context)
                                                                  .add(WorkersChangeIndex(
                                                                      index:
                                                                          2));
                                                            },
                                                            child:
                                                                WorkersTabCard(
                                                              title: LocaleKeys
                                                                  .offline,
                                                              data: stateDashboard
                                                                  .dashboardData[
                                                                      'data'][
                                                                      'unactive_workers']
                                                                  .toString(),
                                                              isSelected:
                                                                  (state.selectedTab ==
                                                                          2)
                                                                      ? true
                                                                      : false,
                                                              color: Colors.red,
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            width: 5,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              : Center(
                                                  child: CustomIndicator());
                                        }
                                        return Center(
                                          child: CustomIndicator(),
                                        );
                                      },
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    CustomTextField(
                                        suffixIcon: Icons.search,
                                        hintText:
                                            LocaleKeys.search_by_name.tr(),
                                        onChanged: (val) {
                                          BlocProvider.of<WorkersBloc>(context)
                                            ..add(WorkersSearch(value: val));
                                        },
                                        controller: search),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              3.6,
                                          child: Row(
                                            children: [
                                              Text(LocaleKeys.workers.tr(),
                                                  style:
                                                      TextStyle(fontSize: 13)),
                                            ],
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            BlocProvider.of<WorkersBloc>(
                                                context)
                                              ..add(WorkersSortByHour());
                                          },
                                          child: SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                3.6,
                                            child: Row(
                                              children: [
                                                Text(
                                                    LocaleKeys.short_hashrate_1h
                                                        .tr(),
                                                    style: TextStyle(
                                                        fontSize: 13)),
                                                (state.sortingIndex == 0)
                                                    ? Icon(Icons
                                                        .arrow_drop_up_sharp)
                                                    : Icon(Icons
                                                        .arrow_drop_down_sharp)
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              3.4,
                                          child: GestureDetector(
                                            onTap: () {
                                              BlocProvider.of<WorkersBloc>(
                                                  context)
                                                ..add(WorkersSortByDay());
                                            },
                                            child: Row(
                                              children: [
                                                Text(
                                                  LocaleKeys.short_hashrate_24h
                                                      .tr(),
                                                  style:
                                                      TextStyle(fontSize: 13),
                                                ),
                                                (state.sortingIndex == 1)
                                                    ? Icon(Icons
                                                        .arrow_drop_up_sharp)
                                                    : Icon(Icons
                                                        .arrow_drop_down_sharp)
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    (state.isLoading == false)
                                        ? ListView.builder(
                                            itemCount: state
                                                .tabs[state.selectedTab].length,
                                            shrinkWrap: true,
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            itemBuilder: (context, index) {
                                              return Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 8.0),
                                                child: InkWell(
                                                  onTap: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              WorkersInfoPage(
                                                                data: state.tabs[
                                                                        state
                                                                            .selectedTab]
                                                                    [index],
                                                              )),
                                                    );
                                                  },
                                                  child: WorkersCard(
                                                    data: state.tabs[state
                                                        .selectedTab][index],
                                                  ),
                                                ),
                                              );
                                            },
                                          )
                                        : Center(
                                            child: CustomIndicator(),
                                          ),
                                    (state.tabs[state.selectedTab].length == 0)
                                        ? Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                1.8,
                                          )
                                        : (state.tabs[state.selectedTab]
                                                    .length <=
                                                4)
                                            ? SizedBox(
                                                height: int.parse(state
                                                        .tabs[state.selectedTab]
                                                        .length
                                                        .toString()) *
                                                    200,
                                              )
                                            : SizedBox(),
                                    SizedBox(
                                      height: 5,
                                    ),
                                  ],
                                )
                              : Center(
                                  child: CustomIndicator(),
                                )),
                    ],
                  ),
                );
              }
              return Center(
                child: CustomIndicator(),
              );
            },
          )),
    );
  }
}
