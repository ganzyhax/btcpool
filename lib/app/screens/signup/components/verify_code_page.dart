import 'package:btcpool_app/app/screens/reset/bloc/reset_bloc.dart';
import 'package:btcpool_app/app/screens/reset/components/reset_set_password_page.dart';
import 'package:btcpool_app/app/screens/reset/reset_screen.dart';
import 'package:btcpool_app/app/screens/signup/bloc/signup_bloc.dart';
import 'package:btcpool_app/data/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';

class VerifyCodePage extends StatelessWidget {
  final String email;
  final bool? isSign;
  const VerifyCodePage({super.key, required this.email, this.isSign = true});

  @override
  Widget build(BuildContext context) {
    TextEditingController pinput = TextEditingController();
    return Scaffold(
      backgroundColor: AppColors().kPrimaryBackgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Center(
          child: SizedBox(
            width: 120,
            child: Image.asset(
              'assets/images/btcpool_logo.png',
            ),
          ),
        ),
      ),
      body: BlocListener<ResetBloc, ResetState>(
        listener: (context, state) {
          if (state is ResetResetPassword) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ResetSetPasswordScreen()),
            );
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 40,
            ),
            Text(
              'Verification',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              child: Text(
                'Please enter verification code , we send to your email account ' +
                    email,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 17),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: Pinput(
                validator: (value) {
                  if (isSign == true) {
                    BlocProvider.of<SignupBloc>(context)
                      ..add(
                          SignupVerify(value: value.toString(), email: email));
                  } else {
                    BlocProvider.of<ResetBloc>(context)
                      ..add(ResetConfirm(code: value.toString(), email: email));
                  }
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
                    print(isSign);
                    if (isSign == true) {
                      BlocProvider.of<SignupBloc>(context)
                        ..add(SignupSendCode(email: email));
                    } else {
                      BlocProvider.of<ResetBloc>(context)
                        ..add(ResetSendCode(email: email));
                    }
                  },
                  child: Text('Resend code')),
            )
          ],
        ),
      ),
    );
  }
}
