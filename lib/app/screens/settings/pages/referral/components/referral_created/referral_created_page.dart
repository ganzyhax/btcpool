import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:btcpool_app/app/screens/settings/pages/referral/bloc/referral_bloc.dart';
import 'package:btcpool_app/app/screens/settings/pages/referral/components/referral_created/components/referral_created_detail_card.dart';
import 'package:btcpool_app/app/screens/settings/pages/referral/components/referral_created/components/referral_created_link_list.dart';
import 'package:btcpool_app/app/screens/settings/pages/referral/components/referral_created/components/referral_created_users_list.dart';
import 'package:btcpool_app/app/screens/settings/pages/referral/components/referral_created/components/referral_earnings_link_list.dart';
import 'package:btcpool_app/app/screens/settings/pages/referral/components/referral_generate_modal.dart';
import 'package:btcpool_app/app/widgets/buttons/custom_button.dart';
import 'package:btcpool_app/app/widgets/custom_indicator.dart';
import 'package:btcpool_app/data/const.dart';
import 'package:btcpool_app/generated/locale_keys.g.dart';

class ReferralCreatedPage extends StatelessWidget {
  const ReferralCreatedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReferralBloc, ReferralState>(
      builder: (context, state) {
        if (state is ReferralLoaded) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              LocaleKeys.status.tr() + ': ',
                              style: const TextStyle(
                                fontSize: 24,
                              ),
                            ),
                            Text(
                              (state.referralDetail['level']
                                          .toString()
                                          .toUpperCase() ==
                                      'AMBASSADOR')
                                  ? LocaleKeys.ambassador.tr()
                                  : (state.referralDetail['level']
                                              .toString()
                                              .toUpperCase() ==
                                          'BEGINNER')
                                      ? LocaleKeys.noob.tr()
                                      : LocaleKeys.expert.tr(),
                              style: TextStyle(
                                  fontSize: 24,
                                  color: (state.referralDetail['level']
                                              .toString()
                                              .toUpperCase() ==
                                          'AMBASSADOR')
                                      ? Colors.red
                                      : (state.referralDetail['level']
                                                  .toString()
                                                  .toUpperCase() ==
                                              'BEGINNER')
                                          ? AppColors().kPrimaryGreen
                                          : Colors.orange),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        ReferralCreatedInfoCard(
                            title: LocaleKeys.total_profit.tr(),
                            additionalSubTitle: 'BTC',
                            withImage: true,
                            subTitle: double.parse(state
                                    .referralDetail['total_profit']
                                    .toString())
                                .toStringAsFixed(8)),
                        const SizedBox(
                          height: 15,
                        ),
                        ReferralCreatedInfoCard(
                            title: LocaleKeys.total_referral_accounts.tr(),
                            subTitle: state
                                .referralDetail['referral_users_count']
                                .toString()),
                        const SizedBox(
                          height: 15,
                        ),
                        ReferralCreatedInfoCard(
                            additionalSubTitle: 'TH/s',
                            title: LocaleKeys.avarage_24h.tr(),
                            subTitle: double.parse(
                                    state.referralDetail['hashrate'].toString())
                                .toStringAsFixed(3)),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    LocaleKeys.referral_link.tr(),
                    style: const TextStyle(
                      fontSize: 24,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ReferralCreatedLinkList(data: state.referralProgram),
                  const SizedBox(
                    height: 15,
                  ),
                  (state.referralDetail['level'].toString().toUpperCase() ==
                          'AMBASSADOR')
                      ? CustomButton(
                          text: LocaleKeys.generate_referral_link.tr(),
                          function: () async {
                            bool data = await showDialog(
                              context: context,
                              builder: (_) {
                                return BlocProvider<ReferralBloc>(
                                  create: (context) =>
                                      ReferralBloc()..add(ReferralLoad()),
                                  child: ReferralGenerateModal(),
                                );
                              },
                            );
                            if (data == true) {
                              BlocProvider.of<ReferralBloc>(context)
                                  .add(ReferralLoad());
                            }
                          },
                        )
                      : const SizedBox(),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    LocaleKeys.referral_earnings.tr(),
                    style: const TextStyle(
                      fontSize: 24,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ReferralEarningsLinkList(data: state.referralEarnings),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    LocaleKeys.list_of_invited_users.tr(),
                    style: const TextStyle(
                      fontSize: 24,
                    ),
                  ),
                  ReferralUsersLinkList(data: state.referralUsers),
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
    );
  }
}
