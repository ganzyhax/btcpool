import 'package:btcpool_app/app/views/reset/bloc/reset_bloc.dart';
import 'package:btcpool_app/app/views/signup/components/verify_code_page.dart';
import 'package:btcpool_app/app/components/appbar/custom_appbar.dart';
import 'package:btcpool_app/app/components/buttons/custom_button.dart';
import 'package:btcpool_app/app/components/custom_snackbar.dart';
import 'package:btcpool_app/app/components/textfields/custom_textfiled.dart';
import 'package:btcpool_app/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResetScreen extends StatefulWidget {
  const ResetScreen({super.key});

  @override
  State<ResetScreen> createState() => _ResetScreenState();
}

class _ResetScreenState extends State<ResetScreen> {
  String? emailValidator;
  TextEditingController email = TextEditingController();
  @override
  void initState() {
    super.initState();
    email.addListener(_onTextChangedEmail);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: BlocListener<ResetBloc, ResetState>(
        listener: (context, state) {
          if (state is ResetError) {
            CustomSnackbar().showCustomSnackbar(context, state.message, false);
          }
          if (state is ResetSendSuccess) {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => VerifyCodePage(
                        email: state.email,
                        isSign: false,
                      )),
            );
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 80,
                ),
                Center(
                  child: Text(
                    LocaleKeys.reset.tr(),
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                  ),
                ),
                SizedBox(
                  height: 20,
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
                  height: 20,
                ),
                CustomButton(
                  text: LocaleKeys.confirm.tr(),
                  function: () {
                    BlocProvider.of<ResetBloc>(context)
                      ..add(ResetSendCode(email: email.text));
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
