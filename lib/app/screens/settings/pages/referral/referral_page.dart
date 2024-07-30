import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:btcpool_app/app/screens/settings/pages/referral/bloc/referral_bloc.dart';
import 'package:btcpool_app/app/screens/settings/pages/referral/components/referral_begin/referral_begin_page.dart';
import 'package:btcpool_app/app/screens/settings/pages/referral/components/referral_created/referral_created_page.dart';
import 'package:btcpool_app/app/widgets/appbar/custom_appbar.dart';
import 'package:btcpool_app/app/widgets/custom_indicator.dart';
import 'package:btcpool_app/app/widgets/custom_snackbar.dart';
import 'package:btcpool_app/generated/locale_keys.g.dart';

class ReferralPage extends StatelessWidget {
  const ReferralPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: CustomAppBar(
          title: LocaleKeys.referral_program.tr(),
          withArrow: true,
          withSubAccount: false,
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: BlocListener<ReferralBloc, ReferralState>(
        listener: (context, state) {
          if (state is ReferralSuccess) {
            CustomSnackbar().showCustomSnackbar(context, state.message, true);
          }
          if (state is ReferralError) {
            CustomSnackbar().showCustomSnackbar(context, state.message, false);
          }
        },
        child: BlocBuilder<ReferralBloc, ReferralState>(
          builder: (context, state) {
            if (state is ReferralLoaded) {
              return (!state.isStarted)
                  ? ReferralBeginPage()
                  : ReferralCreatedPage();
            }
            return Center(child: CustomIndicator());
          },
        ),
      ),
    );
  }
}
