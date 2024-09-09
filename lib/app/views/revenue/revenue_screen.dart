import 'package:btcpool_app/app/views/revenue/bloc/revenue_bloc.dart';
import 'package:btcpool_app/app/views/revenue/components/revenue_earnings.dart';
import 'package:btcpool_app/app/views/revenue/components/revenue_payouts.dart';
import 'package:btcpool_app/app/components/appbar/custom_appbar.dart';
import 'package:btcpool_app/local_data/const.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:btcpool_app/generated/locale_keys.g.dart';

class RevenueScreen extends StatelessWidget {
  const RevenueScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(60),
            child: CustomAppBar(
              title: LocaleKeys.revenue,
            )),
        body: DefaultTabController(
            length: 2,
            child: Scaffold(
              backgroundColor: Theme.of(context).colorScheme.background,
              appBar: PreferredSize(
                preferredSize: const Size.fromHeight(kToolbarHeight),
                child: Container(
                  color: Theme.of(context).colorScheme.secondary,
                  height: 50.0,
                  child: TabBar(
                    indicatorColor: AppColors().kPrimaryGreen,
                    unselectedLabelColor: Colors.grey,
                    labelColor: AppColors().kPrimaryGreen,
                    dividerColor: Colors.transparent,
                    tabs: [
                      Tab(
                        text: LocaleKeys.earnings.tr(),
                      ),
                      Tab(
                        text: LocaleKeys.payouts.tr(),
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
