import 'package:btcpool_app/app/screens/revenue/bloc/revenue_bloc.dart';
import 'package:btcpool_app/app/screens/revenue/components/revenue_earnings.dart';
import 'package:btcpool_app/app/screens/revenue/components/revenue_payouts.dart';
import 'package:btcpool_app/app/widgets/appbar/custom_appbar.dart';
import 'package:btcpool_app/data/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RevenueScreen extends StatelessWidget {
  const RevenueScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors().kPrimaryBackgroundColor,
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(60),
            child: CustomAppBar(
              title: 'Revenue',
            )),
        body: DefaultTabController(
            length: 2,
            child: Scaffold(
              backgroundColor: Colors.white,
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(kToolbarHeight),
                child: Container(
                  height: 50.0,
                  child: TabBar(
                    indicatorColor: AppColors().kPrimaryGreen,
                    unselectedLabelColor: Colors.grey,
                    labelColor: AppColors().kPrimaryGreen,
                    tabs: [
                      Tab(
                        text: "Earnings",
                      ),
                      Tab(
                        text: "Payouts",
                      ),
                    ],
                  ),
                ),
              ),
              body: BlocBuilder<RevenueBloc, RevenueState>(
                builder: (context, state) {
                  if (state is RevenueLoaded) {
                    return TabBarView(
                      children: [RevenueEarnings(), RevenuePayouts()],
                    );
                  }
                  return Container();
                },
              ),
            )));
  }
}
