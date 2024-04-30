import 'package:btcpool_app/app/screens/reset/bloc/reset_bloc.dart';
import 'package:btcpool_app/app/screens/signup/components/verify_code_page.dart';
import 'package:btcpool_app/app/widgets/appbar/custom_appbar.dart';
import 'package:btcpool_app/app/widgets/buttons/custom_button.dart';
import 'package:btcpool_app/app/widgets/custom_snackbar.dart';
import 'package:btcpool_app/app/widgets/textfields/custom_textfiled.dart';
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
        emailValidator = 'Please enter a valid email address.';
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
                    'Reset password',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text('Email'),
                SizedBox(
                  height: 7,
                ),
                CustomTextField(
                  hintText: 'Email',
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
                  text: 'Confirm',
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
