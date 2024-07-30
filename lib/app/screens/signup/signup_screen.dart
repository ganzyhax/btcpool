import 'package:btcpool_app/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:btcpool_app/app/screens/login/bloc/login_bloc.dart';
import 'package:btcpool_app/app/screens/login/login_screen.dart';
import 'package:btcpool_app/app/screens/navigator/main_navigator.dart';
import 'package:btcpool_app/app/screens/signup/bloc/signup_bloc.dart';
import 'package:btcpool_app/app/screens/signup/components/verify_code_page.dart';
import 'package:btcpool_app/app/widgets/buttons/custom_button.dart';
import 'package:btcpool_app/app/widgets/buttons/custom_dropdown_button.dart';
import 'package:btcpool_app/app/widgets/custom_indicator.dart';
import 'package:btcpool_app/app/widgets/custom_snackbar.dart';
import 'package:btcpool_app/app/widgets/textfields/custom_textfiled.dart';
import 'package:btcpool_app/data/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:btcpool_app/generated/locale_keys.g.dart';
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
  bool passwordShow = true;
  bool passwordrShow = true;

  String? phoneValidator;
  @override
  void initState() {
    super.initState();
    // Setup a listener to update the UI based on text changes
    username.addListener(_onTextChanged);
    email.addListener(_onTextChangedEmail);
    password.addListener(_onTextChangedPass);

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
        emailValidator = LocaleKeys.please_enter_valid_email_address.tr();
      });
    }
  }

  void _onTextChangedPass() {
    setState(() {});
    if (password.text.length < 8) {
      passwordValidator = LocaleKeys.ensure_at_least_8_characters.tr();
    } else {
      if (rpassword.text.length > 8) {
        if (rpassword.text != password.text) {
          passwordMatchValidator = LocaleKeys.passwords_do_not_match.tr();
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
      passwordMatchValidator = LocaleKeys.passwords_do_not_match.tr();
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

  final MultiSelectController<String> controller = MultiSelectController();

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
        child: BlocBuilder<SignupBloc, SignupState>(
          builder: (context, state) {
            if (state is SignupLoaded) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          LocaleKeys.sign_up.tr(),
                          style: const TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 18),
                        ),
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      Text(LocaleKeys.user_name.tr()),
                      const SizedBox(
                        height: 7,
                      ),
                      CustomTextField(
                        hintText: LocaleKeys.user_name.tr(),
                        controller: username,
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      Text(LocaleKeys.email.tr()),
                      const SizedBox(
                        height: 7,
                      ),
                      CustomTextField(
                        hintText: LocaleKeys.email.tr(),
                        controller: email,
                      ),
                      (emailValidator == '' || emailValidator == null)
                          ? const SizedBox()
                          : Text(
                              emailValidator.toString(),
                              style: const TextStyle(
                                  fontSize: 12, color: Colors.red),
                            ),
                      const SizedBox(
                        height: 7,
                      ),
                      Text(LocaleKeys.choose_country.tr()),
                      const SizedBox(
                        height: 7,
                      ),
                      MultiSelectDropDown<String>(
                        controller: controller,
                        hint: LocaleKeys.select.tr(),
                        onOptionSelected:
                            (List<ValueItem<String>> selectedOptions) {
                          String val = selectedOptions.first.value.toString();

                          BlocProvider.of<SignupBloc>(context).add(
                              SignupSetCountryCode(countryId: int.parse(val)));

                          controller.hideDropdown();
                          controller.hideDropdown();
                        },
                        options:
                            state.countries.map<ValueItem<String>>((countries) {
                          return ValueItem<String>(
                            label: countries['name_official'].toString(),
                            value: countries['id'].toString(),
                          );
                        }).toList(),
                        selectionType: SelectionType.single,
                        chipConfig: const ChipConfig(wrapType: WrapType.wrap),
                        dropdownHeight: 200,
                        searchLabel: LocaleKeys.search.tr(),
                        searchEnabled: true,
                        optionTextStyle: const TextStyle(
                          fontSize: 16,
                        ),
                        selectedOptionTextColor: AppColors().kPrimaryGreen,
                        selectedOptionBackgroundColor:
                            Theme.of(context).colorScheme.secondary,
                        searchBackgroundColor:
                            Theme.of(context).colorScheme.secondary,
                        fieldBackgroundColor:
                            Theme.of(context).colorScheme.secondary,
                        focusedBorderColor:
                            Theme.of(context).colorScheme.secondary,
                        dropdownBackgroundColor:
                            Theme.of(context).colorScheme.secondary,
                        optionsBackgroundColor:
                            Theme.of(context).colorScheme.secondary,
                        selectedOptionIcon: const Icon(Icons.check_circle),
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      Text(LocaleKeys.password.tr()),
                      const SizedBox(
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
                          ? const SizedBox()
                          : Text(
                              passwordValidator.toString(),
                              style: const TextStyle(
                                  fontSize: 12, color: Colors.red),
                            ),
                      const SizedBox(
                        height: 7,
                      ),
                      Text(LocaleKeys.repeat_password.tr()),
                      const SizedBox(
                        height: 7,
                      ),
                      CustomTextField(
                        controller: rpassword,
                        hintText: '********',
                        isPassword: true,
                        passwordShow: passwordrShow,
                        onTapIcon: () {
                          if (passwordrShow) {
                            setState(() {
                              passwordrShow = false;
                            });
                          } else {
                            setState(() {
                              passwordrShow = true;
                            });
                          }
                        },
                      ),
                      (passwordMatchValidator == '' ||
                              passwordMatchValidator == null)
                          ? const SizedBox()
                          : Text(
                              passwordMatchValidator.toString(),
                              style: const TextStyle(
                                  fontSize: 12, color: Colors.red),
                            ),
                      const SizedBox(
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
                                    style: const TextStyle(color: Colors.blue),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () async {
                                        const privacyUrl =
                                            'https://21pool.io/terms-in-use/en';
                                        if (await canLaunch(privacyUrl)) {
                                          await launch(privacyUrl);
                                        } else {}
                                      },
                                  ),
                                  TextSpan(
                                    text: '${' ' + LocaleKeys.and.tr()} ',
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
                                    style: const TextStyle(color: Colors.blue),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () async {
                                        const privacyUrl =
                                            'https://21pool.io/policy/en';
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
                      const SizedBox(
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
                        text: LocaleKeys.sign_up.tr(),
                        isEnable: (email.text.isEmpty ||
                                username.text.isEmpty ||
                                emailValidator != '' ||
                                passwordValidator != '' ||
                                passwordMatchValidator != '' ||
                                password.text.isEmpty ||
                                rpassword.text.isEmpty)
                            ? false
                            : true,
                        isLoading: state.isLoading,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(LocaleKeys.already_have_an_account.tr() + '  '),
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
                              style:
                                  const TextStyle(fontWeight: FontWeight.w600),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              );
            }
            return Center(
              child: CustomIndicator(),
            );
          },
        ),
      ),
    );
  }
}
