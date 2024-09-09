import 'package:btcpool_app/app/views/login/bloc/login_bloc.dart';
import 'package:btcpool_app/app/views/login/login_screen.dart';
import 'package:btcpool_app/app/views/navigator/main_navigator.dart';
import 'package:btcpool_app/app/views/signup/bloc/signup_bloc.dart';
import 'package:btcpool_app/app/views/signup/components/verify_code_page.dart';
import 'package:btcpool_app/app/components/buttons/custom_button.dart';
import 'package:btcpool_app/app/components/custom_snackbar.dart';
import 'package:btcpool_app/app/components/textfields/custom_textfiled.dart';
import 'package:btcpool_app/local_data/const.dart';
import 'package:btcpool_app/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';
import 'package:url_launcher/url_launcher.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController username = TextEditingController();

  TextEditingController email = TextEditingController();
  TextEditingController fio = TextEditingController();

  TextEditingController bin = TextEditingController();
  TextEditingController phone = TextEditingController();

  TextEditingController password = TextEditingController();
  TextEditingController rpassword = TextEditingController();
  String? emailValidator;
  String? passwordValidator;
  String? passwordMatchValidator;
  bool pShow = true;
  bool rpShow = true;
  String? phoneValidator;
  @override
  void initState() {
    super.initState();
    // Setup a listener to update the UI based on text changes
    username.addListener(_onTextChanged);
    email.addListener(_onTextChangedEmail);
    fio.addListener(_onTextChanged);
    bin.addListener(_onTextChanged);
    password.addListener(_onTextChangedPass);
    phone.addListener(_onTextChangedPhone);
    rpassword.addListener(_onTextChangedRPass);
  }

  void _onTextChanged() {
    setState(() {});
  }

  void _onTextChangedEmail() {
    setState(() {});
    bool res = RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email.text.toString());
    if (res == true) {
      setState(() {
        emailValidator = '';
      });
    } else {
      setState(() {
        emailValidator =
            'Пожалуйста, введите действительный адрес электронной почты';
      });
    }
  }

  void _onTextChangedPass() {
    setState(() {});
    if (password.text.length < 8) {
      passwordValidator =
          'Убедитесь, что это поле содержит не менее 8 символов';
    } else {
      if (rpassword.text.length > 8) {
        if (rpassword.text != password.text) {
          passwordMatchValidator = 'Пароли не совпадают';
        } else {
          passwordMatchValidator = '';
        }
      }
      passwordValidator = '';
    }
    setState(() {});
  }

  void _onTextChangedPhone() {
    setState(() {});
    if (phone.text.length != 11) {
      phoneValidator = 'Неверный формат телефона';
    } else {
      phoneValidator = '';
    }
    setState(() {});
  }

  void _onTextChangedRPass() {
    setState(() {});
    if (password.text != rpassword.text) {
      passwordMatchValidator = 'Пароли не совпадают';
    } else {
      passwordMatchValidator = '';
    }
    setState(() {});
  }

  @override
  void dispose() {
    username.dispose();
    rpassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors().kPrimaryBackgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(
          child: SizedBox(
            width: 120,
            child: Image.asset(
              'assets/images/btcpool_logo.png',
            ),
          ),
        ),
      ),
      body: BlocListener<SignupBloc, SignupState>(
        listener: (context, state) {
          if (state is SignupVerifyOpen) {
            Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (context) => VerifyCodePage(
                        email: email.text,
                      )),
            );
          }
          if (state is SignupSuccess) {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => LoginScreen()),
            );
          }
          if (state is SignupError) {
            CustomSnackbar().showCustomSnackbar(context, state.message, false);
          }
          if (state is SignupMessage) {
            CustomSnackbar().showCustomSnackbar(context, state.message, true);
          }
        },
        child: BlocBuilder<SignupBloc, SignupState>(
          builder: (context, state) {
            if (state is SignupLoaded) {
              return SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          LocaleKeys.sign_up.tr(),
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 18),
                        ),
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      Text(LocaleKeys.email.tr()),
                      SizedBox(
                        height: 7,
                      ),
                      CustomTextField(
                        hintText: LocaleKeys.email.tr(),
                        controller: email,
                      ),
                      (emailValidator == '' || emailValidator == null)
                          ? SizedBox()
                          : Text(
                              emailValidator.toString(),
                              style: TextStyle(fontSize: 12, color: Colors.red),
                            ),
                      SizedBox(
                        height: 7,
                      ),
                      Text('ФИО'),
                      SizedBox(
                        height: 7,
                      ),
                      CustomTextField(
                        hintText: 'ФИО',
                        controller: fio,
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      Text('Номер телефона'),
                      SizedBox(
                        height: 7,
                      ),
                      CustomTextField(
                        hintText: 'Номер телефона',
                        controller: phone,
                      ),
                      (phoneValidator == '' || phoneValidator == null)
                          ? SizedBox()
                          : Text(
                              phoneValidator.toString(),
                              style: TextStyle(fontSize: 12, color: Colors.red),
                            ),
                      SizedBox(
                        height: 7,
                      ),
                      Text('БИН'),
                      SizedBox(
                        height: 7,
                      ),
                      CustomTextField(
                        maxLength: 12,
                        hintText: 'БИН',
                        isNumber: true,
                        controller: bin,
                        onChanged: (value) {
                          if (value.length == 12) {
                            BlocProvider.of<SignupBloc>(context)
                              ..add(SignupFindBin(value: value));
                          }
                        },
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      (state.findedBin == '')
                          ? SizedBox()
                          : (state.findedBin == 'null')
                              ? Text(
                                  'Пожалуйста, введите правильный BIN',
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 12),
                                )
                              : Text(
                                  state.findedBin,
                                  style: TextStyle(
                                      color: Colors.green, fontSize: 12),
                                ),
                      SizedBox(
                        height: 7,
                      ),
                      Text(LocaleKeys.password.tr()),
                      SizedBox(
                        height: 7,
                      ),
                      CustomTextField(
                        controller: password,
                        hintText: '********',
                        isPassword: true,
                        passwordShow: pShow,
                        onTapIcon: () {
                          if (pShow) {
                            pShow = false;
                          } else {
                            pShow = true;
                          }
                          setState(() {});
                        },
                      ),
                      (passwordValidator == '' || passwordValidator == null)
                          ? SizedBox()
                          : Text(
                              passwordValidator.toString(),
                              style: TextStyle(fontSize: 12, color: Colors.red),
                            ),
                      SizedBox(
                        height: 7,
                      ),
                      Text(LocaleKeys.repeat_password.tr()),
                      SizedBox(
                        height: 7,
                      ),
                      CustomTextField(
                        controller: rpassword,
                        hintText: '********',
                        isPassword: true,
                        passwordShow: rpShow,
                        onTapIcon: () {
                          if (rpShow) {
                            rpShow = false;
                          } else {
                            rpShow = true;
                          }
                          setState(() {});
                        },
                      ),
                      (passwordMatchValidator == '' ||
                              passwordMatchValidator == null)
                          ? SizedBox()
                          : Text(
                              passwordMatchValidator.toString(),
                              style: TextStyle(fontSize: 12, color: Colors.red),
                            ),
                      SizedBox(
                        height: 7,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 1.2,
                            child: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    style: TextStyle(
                                        color: (Theme.of(context)
                                                    .colorScheme
                                                    .brightness ==
                                                Brightness.dark)
                                            ? Colors.white
                                            : Colors.black),
                                    text: LocaleKeys
                                            .by_continuing_you_agree_to_our
                                            .tr() +
                                        ' ',
                                  ),
                                  TextSpan(
                                    text: LocaleKeys.terms_and_conditions.tr(),
                                    style: TextStyle(color: Colors.blue),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () async {
                                        const privacyUrl =
                                            'https://new.btcpool.kz/rules';
                                        if (await canLaunch(privacyUrl)) {
                                          await launch(privacyUrl);
                                        } else {}
                                      },
                                  ),
                                  TextSpan(
                                    text: ' ' + LocaleKeys.and.tr() + ' ',
                                    style: TextStyle(
                                        color: (Theme.of(context)
                                                    .colorScheme
                                                    .brightness ==
                                                Brightness.dark)
                                            ? Colors.white
                                            : Colors.black),
                                  ),
                                  TextSpan(
                                    text: LocaleKeys.privacy_policy.tr(),
                                    style: TextStyle(color: Colors.blue),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () async {
                                        const privacyUrl =
                                            'https://new.btcpool.kz/policy';
                                        if (await canLaunch(privacyUrl)) {
                                          await launch(privacyUrl);
                                        } else {}
                                      },
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      CustomButton(
                        function: () {
                          BlocProvider.of<SignupBloc>(context).add(
                              SignupRegister(
                                  email: email.text,
                                  username: fio.text,
                                  password: password.text,
                                  organization_bin: bin.text,
                                  phone: phone.text));
                        },
                        text: LocaleKeys.sign_up.tr(),
                        isEnable: (email.text.isEmpty ||
                                state.findedBin == '' ||
                                state.findedBin == 'null' ||
                                emailValidator != '' ||
                                passwordValidator != '' ||
                                passwordMatchValidator != '' ||
                                phone.text.isEmpty ||
                                password.text.isEmpty ||
                                rpassword.text.isEmpty)
                            ? false
                            : true,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(LocaleKeys.already_have_an_account.tr()),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen()),
                              );
                            },
                            child: Text(
                              LocaleKeys.log_in.tr(),
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          )
                        ],
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
