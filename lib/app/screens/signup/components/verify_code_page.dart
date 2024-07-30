import 'package:btcpool_app/app/screens/navigator/main_navigator.dart';
import 'package:btcpool_app/app/screens/reset/bloc/reset_bloc.dart';
import 'package:btcpool_app/app/screens/reset/components/reset_set_password_page.dart';
import 'package:btcpool_app/app/screens/reset/reset_screen.dart';
import 'package:btcpool_app/app/screens/signup/bloc/signup_bloc.dart';
import 'package:btcpool_app/app/widgets/custom_snackbar.dart';
import 'package:btcpool_app/data/const.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';
import 'package:btcpool_app/generated/locale_keys.g.dart';

class VerifyCodePage extends StatelessWidget {
  final String email;
  final bool? isSign;
  final bool? reVerify;
  const VerifyCodePage(
      {super.key,
      required this.email,
      this.isSign = true,
      this.reVerify = false});

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
      body: BlocListener<SignupBloc, SignupState>(
        listener: (context, state) {
          if (state is SignupSuccess) {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => CustomNavigationBar()),
                (Route<dynamic> route) => false);
          }
          if (state is SignupError) {
            CustomSnackbar().showCustomSnackbar(context, state.message, false);
          }
          if (state is SignupMessage) {
            CustomSnackbar().showCustomSnackbar(context, state.message, true);
          }
        },
        child: BlocListener<ResetBloc, ResetState>(
          listener: (context, state) {
            if (state is ResetResetPassword) {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ResetSetPasswordScreen()),
              );
            }
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 40,
              ),
              Text(
                LocaleKeys.verification.tr(),
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                child: Text(
                  LocaleKeys.please_enter_verification_code.tr() + ' $email',
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
                    if (isSign == true) {
                      BlocProvider.of<SignupBloc>(context).add(SignupVerify(
                          value: value.toString(),
                          email: email,
                          isReVerify: (reVerify!) ? true : false));
                    } else {
                      BlocProvider.of<ResetBloc>(context).add(
                          ResetConfirm(code: value.toString(), email: email));
                    }
                    return null;
                  },
                  autofocus: false,
                  length: 5,
                  androidSmsAutofillMethod:
                      AndroidSmsAutofillMethod.smsUserConsentApi,
                  controller: pinput,
                ),
              ),
              Center(
                child: TextButton(
                    onPressed: () {
                      if (isSign == true) {
                        BlocProvider.of<SignupBloc>(context)
                            .add(SignupSendCode(email: email));
                      } else {
                        BlocProvider.of<ResetBloc>(context)
                            .add(ResetSendCode(email: email));
                      }
                    },
                    child: Text(
                      LocaleKeys.resend_code.tr(),
                      style: TextStyle(color: AppColors().kPrimaryGreen),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
