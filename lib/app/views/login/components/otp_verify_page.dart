import 'package:btcpool_app/app/views/login/bloc/login_bloc.dart';
import 'package:btcpool_app/app/views/navigator/main_navigator.dart';
import 'package:btcpool_app/app/components/custom_snackbar.dart';
import 'package:btcpool_app/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';

class VerifyOTPPage extends StatelessWidget {
  final String oathToken;
  const VerifyOTPPage({super.key, required this.oathToken});

  @override
  Widget build(BuildContext context) {
    TextEditingController pinput = TextEditingController();
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Center(
          child: SizedBox(
              width: 120,
              child: (Theme.of(context).brightness == Brightness.dark)
                  ? Image.asset('assets/images/btcpool_logo.png')
                  : Image.asset('assets/images/btcpool_logo.png')),
        ),
      ),
      body: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => CustomNavigationBar()),
                (Route<dynamic> route) => false);
          }
          if (state is LoginError) {
            CustomSnackbar().showCustomSnackbar(context, state.message, false);
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 40,
            ),
            Center(
              child: Text(
                LocaleKeys.fa_verification.tr(),
                textAlign: TextAlign.center,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              child: Text(
                LocaleKeys.please_enter_otp_code.tr(),
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 17),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: Pinput(
                validator: (value) {
                  BlocProvider.of<LoginBloc>(context).add(LoginLogWithOtp(
                      oathToken: oathToken, otp: value.toString()));
                  return null;
                },
                autofocus: false,
                length: 6,
                androidSmsAutofillMethod:
                    AndroidSmsAutofillMethod.smsUserConsentApi,
                controller: pinput,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
