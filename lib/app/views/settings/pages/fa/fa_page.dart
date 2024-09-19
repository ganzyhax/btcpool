import 'package:btcpool_app/app/components/appbar/custom_appbar.dart';
import 'package:btcpool_app/app/views/settings/pages/fa/bloc/fa_bloc.dart';
import 'package:btcpool_app/app/components/appbar/custom_title_appbar.dart';
import 'package:btcpool_app/app/components/buttons/custom_button.dart';
import 'package:btcpool_app/app/components/textfields/custom_textfiled.dart';
import 'package:btcpool_app/generated/locale_keys.g.dart';
import 'package:btcpool_app/local_data/const.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FAPage extends StatelessWidget {
  const FAPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController fa = TextEditingController();
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: CustomTitleAppBar(
          title: '2FA Authenticator',
        ),
      ),
      body: BlocProvider(
        create: (context) => FaBloc()..add(FaLoad()),
        child: BlocBuilder<FaBloc, FaState>(
          builder: (context, state) {
            if (state is FaLoaded) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: (state.isTurnedFa)
                      ? Center(
                          child: Text('Уже подключено'),
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(child: SvgPicture.string(state.svgImage)),
                            Text(LocaleKeys.install_google_identifier.tr()),
                            Text(
                              LocaleKeys.open_the_app_add_account.tr(),
                            ),
                            Text(
                              state.secretCode,
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            Text(LocaleKeys.enter_six_code_and_connect.tr()),
                            Padding(
                              padding: const EdgeInsets.only(top: 20.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                      child: SizedBox(
                                    child: CustomTextField(
                                        hintText: '2FA Code', controller: fa),
                                  )),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width /
                                          2.2,
                                      child: CustomButton(
                                          text: LocaleKeys.connect.tr()))
                                ],
                              ),
                            )
                          ],
                        ),
                ),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
