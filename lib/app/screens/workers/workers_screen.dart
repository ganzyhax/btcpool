import 'package:btcpool_app/app/screens/dashboard/components/dashboard_hashrate_info_card.dart';
import 'package:btcpool_app/app/screens/workers/bloc/workers_bloc.dart';
import 'package:btcpool_app/app/screens/workers/components/workers_card.dart';
import 'package:btcpool_app/app/screens/workers/components/workers_info_page.dart';
import 'package:btcpool_app/app/screens/workers/components/workers_tab_card.dart';
import 'package:btcpool_app/app/widgets/appbar/custom_appbar.dart';
import 'package:btcpool_app/app/widgets/buttons/custom_button.dart';
import 'package:btcpool_app/data/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WorkersScreen extends StatelessWidget {
  const WorkersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors().kPrimaryBackgroundColor,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: CustomAppBar(
            title: 'Workers',
          )),
      body: BlocBuilder<WorkersBloc, WorkersState>(
        builder: (context, state) {
          if (state is WorkersLoaded) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        DashboardHashrateInfoCard(
                          title: 'Hashrate \nCurrent/24H',
                          isHashrate: false,
                          data: 'data',
                        ),
                        DashboardHashrateInfoCard(
                          title: 'Workers \nOnline/Offline ',
                          data: 'data',
                          isHashrate: true,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width / 1.3,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  BlocProvider.of<WorkersBloc>(context)
                                    ..add(WorkersChangeIndex(index: 0));
                                },
                                child: WorkersTabCard(
                                  title: 'All',
                                  data: '320',
                                  isSelected:
                                      (state.selectedTab == 0) ? true : false,
                                  color: Colors.green,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  BlocProvider.of<WorkersBloc>(context)
                                    ..add(WorkersChangeIndex(index: 1));
                                },
                                child: WorkersTabCard(
                                  title: 'Online',
                                  data: '319',
                                  isSelected:
                                      (state.selectedTab == 1) ? true : false,
                                  color: Colors.green,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  BlocProvider.of<WorkersBloc>(context)
                                    ..add(WorkersChangeIndex(index: 2));
                                },
                                child: WorkersTabCard(
                                  title: 'Offline',
                                  data: '12',
                                  isSelected:
                                      (state.selectedTab == 2) ? true : false,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Icon(Icons.compare_arrows_rounded),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const WorkersInfoPage()),
                        );
                      },
                      child: WorkersCard(
                        isOnline: true,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Center(
                        child: SizedBox(
                            width: 100, child: CustomButton(text: 'See all')))
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
