import 'package:btcpool_app/app/screens/login/bloc/login_bloc.dart';
import 'package:btcpool_app/app/screens/login/components/otp_verify_page.dart';
import 'package:btcpool_app/app/screens/navigator/main_navigator.dart';
import 'package:btcpool_app/app/screens/reset/reset_screen.dart';
import 'package:btcpool_app/app/screens/signup/components/verify_code_page.dart';
import 'package:btcpool_app/app/screens/signup/signup_screen.dart';
import 'package:btcpool_app/app/widgets/buttons/custom_button.dart';
import 'package:btcpool_app/app/widgets/custom_snackbar.dart';
import 'package:btcpool_app/app/widgets/textfields/custom_textfiled.dart';
import 'package:btcpool_app/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController login = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController fa = TextEditingController();
  bool passwordShow = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
          if (state is LoginOtp) {
            Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (context) => VerifyOTPPage(
                        oathToken: state.oathToken,
                      )),
            );
          }
          if (state is LoginUnVerifiedEmail) {
            Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (context) => VerifyCodePage(
                        isSign: true,
                        reVerify: true,
                        email: state.email,
                      )),
            );
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: BlocBuilder<LoginBloc, LoginState>(
              builder: (context, state) {
                if (state is LoginLoaded) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 80,
                      ),
                      Center(
                        child: Text(
                          LocaleKeys.log_in.tr(),
                          style: const TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 18),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Text(LocaleKeys.user_name.tr()),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomTextField(
                        hintText: LocaleKeys.user_name.tr(),
                        controller: login,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(LocaleKeys.password.tr()),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomTextField(
                        controller: password,
                        hintText: '********',
                        isPassword: true,
                        passwordShow: passwordShow,
                        onTapIcon: () {
                          if (passwordShow) {
                            setState(() {
                              passwordShow = false;
                            });
                          } else {
                            setState(() {
                              passwordShow = true;
                            });
                          }
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text('2FA Code'),
                      SizedBox(
                        height: 10,
                      ),
                      CustomTextField(
                        hintText: '2FA Code (Optional)',
                        controller: fa,
                        isNumber: true,
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      CustomButton(
                        isLoading: state.isLoading,
                        function: () {
                          BlocProvider.of<LoginBloc>(context).add(LoginLog(
                              login: login.text,
                              password: password.text,
                              otp: fa.text));
                        },
                        text: LocaleKeys.sign_in.tr(),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            LocaleKeys.dont_have_account.tr() + ' ',
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignUpScreen()),
                              );
                            },
                            child: Text(
                              LocaleKeys.sign_up.tr(),
                              style:
                                  const TextStyle(fontWeight: FontWeight.w600),
                            ),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(LocaleKeys.forgot_password.tr() + ' '),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ResetScreen()),
                              );
                            },
                            child: Text(
                              LocaleKeys.reset.tr(),
                              style:
                                  const TextStyle(fontWeight: FontWeight.w600),
                            ),
                          )
                        ],
                      )
                    ],
                  );
                }
                return Container();
              },
            ),
          ),
        ),
      ),
    );
  }
}
