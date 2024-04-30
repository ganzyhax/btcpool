import 'package:btcpool_app/app/screens/login/bloc/login_bloc.dart';
import 'package:btcpool_app/app/screens/login/login_screen.dart';
import 'package:btcpool_app/app/screens/navigator/main_navigator.dart';
import 'package:btcpool_app/app/screens/signup/bloc/signup_bloc.dart';
import 'package:btcpool_app/app/screens/signup/components/verify_code_page.dart';
import 'package:btcpool_app/app/widgets/buttons/custom_button.dart';
import 'package:btcpool_app/app/widgets/custom_snackbar.dart';
import 'package:btcpool_app/app/widgets/textfields/custom_textfiled.dart';
import 'package:btcpool_app/data/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';

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
        emailValidator = 'Please enter a valid email address.';
      });
    }
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

  void _onTextChangedPhone() {
    setState(() {});
    if (phone.text.length != 11) {
      phoneValidator = 'Incorrect format phone.';
    } else {
      phoneValidator = '';
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
                          'Sign Up',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 18),
                        ),
                      ),
                      Text('User name'),
                      SizedBox(
                        height: 7,
                      ),
                      CustomTextField(
                        hintText: 'Username',
                        controller: username,
                      ),
                      SizedBox(
                        height: 7,
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
                        height: 7,
                      ),
                      Text('Full name'),
                      SizedBox(
                        height: 7,
                      ),
                      CustomTextField(
                        hintText: 'Full name',
                        controller: fio,
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      Text('Phone'),
                      SizedBox(
                        height: 7,
                      ),
                      CustomTextField(
                        hintText: 'Phone',
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
                      Text('BIN'),
                      SizedBox(
                        height: 7,
                      ),
                      CustomTextField(
                        maxLength: 12,
                        hintText: 'BIN',
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
                      Text('Password'),
                      SizedBox(
                        height: 7,
                      ),
                      CustomTextField(
                        controller: password,
                        hintText: '********',
                        isPassword: true,
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
                          Text(
                            'I agree to the Terms & Conditions and Privacy Policy',
                            style: TextStyle(fontSize: 12),
                          ),
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
                                  username: username.text,
                                  password: password.text,
                                  organization_bin: bin.text,
                                  phone: phone.text));
                        },
                        text: 'Sign Up',
                        isEnable:
                            (email.text.isEmpty && username.text.isEmpty ||
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
                          Text('Already have an account?  '),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen()),
                              );
                            },
                            child: Text(
                              'Log In',
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
