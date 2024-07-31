import 'package:btcpool_app/app/screens/settings/pages/fa/bloc/fa_bloc.dart';
import 'package:btcpool_app/app/widgets/appbar/custom_title_appbar.dart';
import 'package:btcpool_app/app/widgets/buttons/custom_button.dart';
import 'package:btcpool_app/app/widgets/textfields/custom_textfiled.dart';
import 'package:btcpool_app/data/const.dart';
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
                            Text(
                                '1. Install the Google Identifier application (iOS/Android)'),
                            Text(
                              '2. Open the application and add your 21pool account. To do this, scan the QR code or enter the code:',
                            ),
                            Text(
                              state.secretCode,
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            Text(
                                '3. Enter the 6-digit code from the application and click "Connect"'),
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
                                      child: CustomButton(text: 'Connect'))
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
