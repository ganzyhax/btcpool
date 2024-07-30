import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:btcpool_app/app/screens/settings/pages/referral/bloc/referral_bloc.dart';
import 'package:btcpool_app/app/screens/settings/pages/referral/components/referral_begin/referral_begin_card.dart';
import 'package:btcpool_app/app/widgets/buttons/custom_button.dart';
import 'package:btcpool_app/app/widgets/custom_indicator.dart';
import 'package:btcpool_app/app/widgets/textfields/custom_textfiled.dart';
import 'package:btcpool_app/generated/locale_keys.g.dart';

class ReferralBeginPage extends StatelessWidget {
  const ReferralBeginPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController wallet = TextEditingController();
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: BlocBuilder<ReferralBloc, ReferralState>(
        builder: (context, state) {
          if (state is ReferralLoaded) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Theme.of(context).colorScheme.secondary),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            LocaleKeys.referral_program.tr(),
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                              LocaleKeys.join_our_mining_referral_program.tr()),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(LocaleKeys.the_reward_is_paid_out.tr()),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(LocaleKeys.levels_info.tr()),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(LocaleKeys.ambassadors_can_adjust_commission
                              .tr()),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(LocaleKeys.if_your_invited_referral.tr()),
                          const SizedBox(
                            height: 5,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      LocaleKeys.referral_levels.tr(),
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width /
                                          12,
                                      child: const Text(
                                        '№',
                                        style: TextStyle(fontSize: 13),
                                      ),
                                    ),
                                    SizedBox(
                                      width:
                                          MediaQuery.of(context).size.width / 7,
                                      child: Text(
                                        LocaleKeys.level.tr(),
                                        style: const TextStyle(fontSize: 13),
                                      ),
                                    ),
                                    SizedBox(
                                      width:
                                          MediaQuery.of(context).size.width / 5,
                                      child: Text(
                                        LocaleKeys.pool_fee_for_client.tr() +
                                            ' %',
                                        style: const TextStyle(fontSize: 13),
                                      ),
                                    ),
                                    SizedBox(
                                      width:
                                          MediaQuery.of(context).size.width / 7,
                                      child: Text(
                                        LocaleKeys.referral_fee.tr() + ' %',
                                        style: const TextStyle(fontSize: 13),
                                      ),
                                    ),
                                    SizedBox(
                                      width:
                                          MediaQuery.of(context).size.width / 7,
                                      child: Text(
                                        LocaleKeys.reward_fee.tr() + ' %',
                                        style: const TextStyle(fontSize: 13),
                                      ),
                                    ),
                                    SizedBox(
                                      width:
                                          MediaQuery.of(context).size.width / 7,
                                      child: Text(
                                        LocaleKeys.status.tr(),
                                        style: const TextStyle(fontSize: 13),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          ReferralBeginCard(
                            data: {
                              'number': '1',
                              'level': LocaleKeys.noob.tr(),
                              'pool_fee': '1',
                              "referral_fee": '10',
                              'reward_fee': '0,10',
                              'status': LocaleKeys.available.tr()
                            },
                          ),
                          ReferralBeginCard(
                            data: {
                              'number': '2',
                              'level': LocaleKeys.expert.tr(),
                              'pool_fee': '0.9',
                              "referral_fee": '20',
                              'reward_fee': '0,18',
                              'status': LocaleKeys.unavailable.tr()
                            },
                          ),
                          ReferralBeginCard(
                            data: {
                              'number': '3',
                              'level': LocaleKeys.ambassador.tr(),
                              'pool_fee': '0.8-2',
                              "referral_fee": '30',
                              'reward_fee': '0,24-0,6',
                              'status': LocaleKeys.unavailable.tr()
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    CustomTextField(
                        hintText: LocaleKeys.wallet.tr(), controller: wallet),
                    const SizedBox(
                      height: 15,
                    ),
                    CustomButton(
                      text: LocaleKeys.generate.tr(),
                      isLoading: state.isLoading,
                      function: () {
                        BlocProvider.of<ReferralBloc>(context)
                            .add(ReferralCreate(walletAddress: wallet.text));
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              ),
            );
          }
          return Center(
            child: CustomIndicator(),
          );
        },
      ),
    );
  }
}
