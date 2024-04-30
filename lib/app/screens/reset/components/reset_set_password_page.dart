import 'package:btcpool_app/app/screens/login/login_screen.dart';
import 'package:btcpool_app/app/screens/reset/bloc/reset_bloc.dart';
import 'package:btcpool_app/app/screens/signup/components/verify_code_page.dart';
import 'package:btcpool_app/app/widgets/appbar/custom_appbar.dart';
import 'package:btcpool_app/app/widgets/buttons/custom_button.dart';
import 'package:btcpool_app/app/widgets/textfields/custom_textfiled.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResetSetPasswordScreen extends StatefulWidget {
  const ResetSetPasswordScreen({super.key});

  @override
  State<ResetSetPasswordScreen> createState() => _ResetSetPasswordScreenState();
}

class _ResetSetPasswordScreenState extends State<ResetSetPasswordScreen> {
  String? passwordValidator;
  String? passwordMatchValidator;
  TextEditingController password = TextEditingController();
  TextEditingController rpassword = TextEditingController();
  bool passwordShow = true;

  @override
  void initState() {
    super.initState();
    password.addListener(_onTextChangedPass);
    rpassword.addListener(_onTextChangedRPass);
  }

  void _onTextChangedPass() {
    setState(() {});
    if (password.text.length < 8) {
      passwordValidator = 'Ensure this field has at least 8 characters.';
    } else {
      if (rpassword.text.length > 8) {
        if (rpassword.text != password.text) {
          passwordMatchValidator = 'Passwords are dont math.';
        } else {
          passwordMatchValidator = '';
        }
      }
      passwordValidator = '';
    }
    setState(() {});
  }

  void _onTextChangedRPass() {
    setState(() {});
    if (password.text != rpassword.text) {
      passwordMatchValidator = 'Passwords are dont math.';
    } else {
      passwordMatchValidator = '';
    }
    setState(() {});
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
          if (state is ResetSuccess) {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => LoginScreen()),
                (Route<dynamic> route) => false);
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
                    'New password',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 7,
                ),
                Text('Password'),
                SizedBox(
                  height: 7,
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
                (passwordValidator == '' || passwordValidator == null)
                    ? SizedBox()
                    : Text(
                        passwordValidator.toString(),
                        style: TextStyle(fontSize: 12, color: Colors.red),
                      ),
                SizedBox(
                  height: 7,
                ),
                Text('Repeat password'),
                SizedBox(
                  height: 7,
                ),
                CustomTextField(
                  controller: rpassword,
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
                (passwordMatchValidator == '' || passwordMatchValidator == null)
                    ? SizedBox()
                    : Text(
                        passwordMatchValidator.toString(),
                        style: TextStyle(fontSize: 12, color: Colors.red),
                      ),
                SizedBox(
                  height: 7,
                ),
                SizedBox(
                  height: 20,
                ),
                CustomButton(
                  text: 'Confirm',
                  function: () {
                    if (passwordMatchValidator == '' &&
                        passwordValidator == '') {
                      BlocProvider.of<ResetBloc>(context)
                        ..add(ResetSetPassword(password: password.text));
                    }
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
