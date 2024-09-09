import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:btcpool_app/api/local_auth.dart';
import 'package:btcpool_app/app/views/settings/pages/security/bloc/security_bloc.dart';

import 'package:btcpool_app/app/components/appbar/custom_appbar.dart';
import 'package:btcpool_app/app/components/custom_indicator.dart';
import 'package:btcpool_app/app/components/custom_snackbar.dart';
import 'package:btcpool_app/local_data/const.dart';
import 'package:btcpool_app/generated/locale_keys.g.dart';

class SecurityScreen extends StatelessWidget {
  const SecurityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: CustomAppBar(
          title: LocaleKeys.security.tr(),
          withArrow: true,
          withSubAccount: false,
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: BlocBuilder<SecurityBloc, SecurityState>(
        builder: (context, state) {
          if (state is SecurityLoaded) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.secondary,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 16),
                        child: Row(
                          children: [
                            const Expanded(
                              child: Text(
                                'PassCode & Face ID',
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 60,
                              height: 30,
                              child: GestureDetector(
                                onTap: () async {
                                  bool isPermission =
                                      await LocalAuth().authenticate();
                                  if (isPermission) {
                                    if (state.isSecured) {
                                      BlocProvider.of<SecurityBloc>(context)
                                          .add(SecurtiyOff());
                                    } else {
                                      BlocProvider.of<SecurityBloc>(context)
                                          .add(SecurtiyOn());
                                    }
                                  } else {
                                    CustomSnackbar().showCustomSnackbar(
                                        context,
                                        LocaleKeys.security_dont_support.tr(),
                                        false);
                                  }
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: state.isSecured
                                        ? AppColors().kPrimaryGreen
                                        : Colors.grey[400],
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: (state.isSecured)
                                        ? MainAxisAlignment.end
                                        : MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 28,
                                        height: 28,
                                        child: Stack(
                                          children: [
                                            Positioned.fill(
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: state.isSecured
                                                      ? Colors.green
                                                      : Colors.grey,
                                                  borderRadius:
                                                      BorderRadius.circular(14),
                                                ),
                                              ),
                                            ),
                                            AnimatedAlign(
                                              alignment: state.isSecured
                                                  ? Alignment.centerRight
                                                  : Alignment.centerLeft,
                                              duration: const Duration(
                                                  milliseconds: 250),
                                              curve: Curves.easeInOut,
                                              child: Container(
                                                width: 20,
                                                height: 20,
                                                margin: const EdgeInsets.all(4),
                                                decoration: const BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.white,
                                                ),
                                                child: state.isSecured
                                                    ? const Icon(
                                                        Icons.check,
                                                        size: 14,
                                                        color: Colors.green,
                                                      )
                                                    : const SizedBox.shrink(),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )),
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
