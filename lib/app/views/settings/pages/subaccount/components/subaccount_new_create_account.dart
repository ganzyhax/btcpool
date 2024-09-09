import 'package:btcpool_app/app/views/dashboard/bloc/dashboard_bloc.dart';
import 'package:btcpool_app/app/views/navigator/main_navigator.dart';
import 'package:btcpool_app/app/views/settings/pages/api/bloc/api_bloc.dart';
import 'package:btcpool_app/app/views/settings/pages/subaccount/bloc/subaccount_bloc.dart';
import 'package:btcpool_app/app/components/appbar/custom_appbar.dart';
import 'package:btcpool_app/app/components/buttons/custom_button.dart';
import 'package:btcpool_app/app/components/buttons/custom_checkbox.dart';
import 'package:btcpool_app/app/components/buttons/custom_dropdown_button.dart';
import 'package:btcpool_app/app/components/custom_snackbar.dart';
import 'package:btcpool_app/app/components/textfields/custom_textfiled.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:btcpool_app/generated/locale_keys.g.dart';

class SubAccountCreateNewAccount extends StatefulWidget {
  const SubAccountCreateNewAccount({
    super.key,
  });

  @override
  State<SubAccountCreateNewAccount> createState() =>
      _SubAccountCreateNewAccountState();
}

class _SubAccountCreateNewAccountState
    extends State<SubAccountCreateNewAccount> {
  TextEditingController name = TextEditingController();
  TextEditingController wallet = TextEditingController();
  TextEditingController h1 = TextEditingController();
  TextEditingController h2 = TextEditingController();
  TextEditingController h3 = TextEditingController();
  TextEditingController empty = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);
    name.addListener(_onTextChanged);
    wallet.addListener(_onTextChanged);
    h1.addListener(_onTextChanged);
    h2.addListener(_onTextChanged);
    h3.addListener(_onTextChanged);
  }

  void _onFocusChange() {
    if (_focusNode.hasFocus) {
      // Remove '%' symbol when the text field gets focused
      if (h3.text.endsWith('%')) {
        h3.text = h3.text.substring(0, h3.text.length - 1);
      }
    } else {
      // Add '%' symbol when the text field loses focus
      if (!h3.text.endsWith('%') && h3.text.isNotEmpty) {
        h3.text = '${h3.text}%';
      }
    }
  }

  void _onTextChanged() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: CustomAppBar(
            withArrow: true,
            withSubAccount: false,
            title: LocaleKeys.create_new_subaccount.tr(),
          )),
      body: BlocListener<SubaccountBloc, SubaccountState>(
        listener: (context, state) {
          if (state is SubaccountNewSuccess) {
            BlocProvider.of<DashboardBloc>(context).add(
                DashboardUpdateSubaccounts(subAccount: state.newSubAccount));

            BlocProvider.of<ApiBloc>(context).add(ApiSubAccountUpdate());
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => CustomNavigationBar()),
                (Route<dynamic> route) => false);
          }
          if (state is SubaccountNewError) {
            CustomSnackbar().showCustomSnackbar(context, state.message, false);
          }
        },
        child: BlocBuilder<SubaccountBloc, SubaccountState>(
          builder: (context, state) {
            if (state is SubaccountLoaded) {
              return SingleChildScrollView(
                child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 7,
                        ),
                        Text(LocaleKeys.name.tr()),
                        const SizedBox(
                          height: 14,
                        ),
                        CustomTextField(
                            hintText: LocaleKeys.name.tr(), controller: name),
                        const SizedBox(
                          height: 14,
                        ),
                        Text(LocaleKeys.wallet_address.tr()),
                        const SizedBox(
                          height: 14,
                        ),
                        CustomTextField(
                            hintText: LocaleKeys.wallet.tr(),
                            controller: wallet),
                        const SizedBox(
                          height: 14,
                        ),
                        Text(LocaleKeys.method.tr()),
                        const SizedBox(
                          height: 14,
                        ),
                        CustomDropdownButton(
                            function: (value) {},
                            selectedValue: 'FPPS',
                            items: [
                              const DropdownMenuItem(
                                value: 'FPPS',
                                child: Text(
                                  'FPPS',
                                ),
                              ),
                            ]),
                        const SizedBox(
                          height: 24,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(LocaleKeys.reward_split.tr()),
                            const SizedBox(
                              width: 10,
                            ),
                            CircleCheckbox(
                              value: state
                                  .isCheck, // Change this to false to see the white color
                              onChanged: (value) {
                                BlocProvider.of<SubaccountBloc>(context)
                                    .add(SubaccountCheckSplit(value: value!));
                              },
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        (state.isCheck == true)
                            ? Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              5,
                                          child: Text(LocaleKeys.split.tr())),
                                      SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              4,
                                          child: Text(LocaleKeys.account.tr())),
                                      SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2.6,
                                          child: Text(LocaleKeys.wallet.tr())),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Column(
                                    children:
                                        state.selectedSubAccounts.map((e) {
                                      int index =
                                          state.selectedSubAccounts.indexOf(e);
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 10.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    5,
                                                child: CustomTextField(
                                                    focusNode: _focusNode,
                                                    isEnabled: false,
                                                    hintText:
                                                        '${e['percentage']}%',
                                                    controller: empty)),
                                            SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    4,
                                                child: CustomTextField(
                                                    isEnabled: false,
                                                    hintText: e['name'],
                                                    controller: empty)),
                                            SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    2.8,
                                                child: CustomTextField(
                                                  hintText: e['wallet_address'],
                                                  controller: empty,
                                                  isEnabled: false,
                                                )),
                                            InkWell(
                                              onTap: () {
                                                BlocProvider.of<SubaccountBloc>(
                                                        context)
                                                    .add(
                                                        SubaccountDeleteSubAccount(
                                                            index: index));
                                              },
                                              child: const Icon(
                                                Icons.delete,
                                                color: Colors.red,
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                  (state.isShowAddField == true)
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    5,
                                                child: CustomTextField(
                                                    hintText: '100%',
                                                    isNumber: true,
                                                    controller: h1)),
                                            SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    4,
                                                child: CustomTextField(
                                                    hintText:
                                                        LocaleKeys.name.tr(),
                                                    controller: h2)),
                                            SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    2.8,
                                                child: CustomTextField(
                                                    hintText:
                                                        LocaleKeys.wallet.tr(),
                                                    controller: h3)),
                                            InkWell(
                                              onTap: () {
                                                BlocProvider.of<SubaccountBloc>(
                                                        context)
                                                    .add(
                                                        SubaccountShowSplitField());
                                              },
                                              child: const Icon(
                                                Icons.delete,
                                                color: Colors.red,
                                              ),
                                            ),
                                          ],
                                        )
                                      : const SizedBox(),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              4,
                                          child: CustomButton(
                                            function: () {
                                              if (state.isShowAddField ==
                                                  false) {
                                                BlocProvider.of<SubaccountBloc>(
                                                        context)
                                                    .add(
                                                        SubaccountShowSplitField());
                                              } else {
                                                BlocProvider.of<SubaccountBloc>(
                                                        context)
                                                    .add(
                                                        SubaccountAddSubAccount(
                                                            data: {
                                                      'name': h2.text,
                                                      'percentage':
                                                          int.parse(h1.text),
                                                      'wallet_address': h3.text
                                                    }));
                                                h1.text = '';
                                                h2.text = '';
                                                h3.text = '';
                                                setState(() {});
                                                BlocProvider.of<SubaccountBloc>(
                                                        context)
                                                    .add(
                                                        SubaccountShowSplitField());
                                              }
                                            },
                                            text: LocaleKeys.add.tr(),
                                          )),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 25,
                                  )
                                ],
                              )
                            : const SizedBox(),
                        CustomButton(
                          text: LocaleKeys.create.tr(),
                          isLoading: state.isLoading,
                          isEnable: (name.text.isEmpty || wallet.text.isEmpty)
                              ? false
                              : true,
                          function: () {
                            BlocProvider.of<SubaccountBloc>(context).add(
                                SubaccountNewCreate(
                                    name: name.text, wallet: wallet.text));
                          },
                        ),
                      ],
                    )),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
