import 'package:btcpool_app/app/screens/dashboard/bloc/dashboard_bloc.dart';
import 'package:btcpool_app/app/screens/navigator/main_navigator.dart';
import 'package:btcpool_app/app/screens/revenue/bloc/revenue_bloc.dart';
import 'package:btcpool_app/app/screens/settings/pages/api/bloc/api_bloc.dart';
import 'package:btcpool_app/app/screens/settings/pages/subaccount/bloc/subaccount_bloc.dart';
import 'package:btcpool_app/app/screens/settings/pages/subaccount/components/subaccount_card.dart';
import 'package:btcpool_app/app/screens/settings/pages/subaccount/components/subaccount_create_modal.dart';
import 'package:btcpool_app/app/screens/workers/bloc/workers_bloc.dart';
import 'package:btcpool_app/app/widgets/appbar/custom_appbar.dart';
import 'package:btcpool_app/app/widgets/buttons/custom_button.dart';
import 'package:btcpool_app/app/widgets/custom_indicator.dart';
import 'package:btcpool_app/app/widgets/custom_snackbar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:btcpool_app/app/widgets/textfields/custom_textfiled.dart';
import 'package:btcpool_app/data/const.dart';
import 'package:btcpool_app/generated/locale_keys.g.dart';

class SubAccountPage extends StatefulWidget {
  const SubAccountPage({
    super.key,
  });

  @override
  State<SubAccountPage> createState() => _SubAccountPageState();
}

class _SubAccountPageState extends State<SubAccountPage> {
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
      if (h3.text.endsWith('%')) {
        h3.text = h3.text.substring(0, h3.text.length - 1);
      }
    } else {
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
          if (state is SubaccountError) {
            CustomSnackbar().showCustomSnackbar(context, state.message, false);
          }
          if (state is SubaccountUpdateSplittedSuccess) {
            CustomSnackbar().showCustomSnackbar(context, state.message, true);
            BlocProvider.of<DashboardBloc>(context).add(
                DashboardUpdateSubaccounts(
                    subAccount: state.subAccount.toString()));
            Navigator.pop(context);
          }
          if (state is SubaccountSuccess) {
            CustomSnackbar().showCustomSnackbar(context, state.message, true);
            BlocProvider.of<DashboardBloc>(context).add(
                DashboardUpdateSubaccounts(
                    subAccount: state.newSubAccount.toString()));
            BlocProvider.of<RevenueBloc>(context)
                .add(RevenueUpdateSubaccount());
            BlocProvider.of<WorkersBloc>(context)
                .add(WorkersSubaccountUpdate());
            BlocProvider.of<ApiBloc>(context).add(ApiSubAccountUpdate());
            Navigator.pop(context);
          }
        }, child: BlocBuilder<SubaccountBloc, SubaccountState>(
                builder: (context, state) {
          if (state is SubaccountLoaded) {
            return SingleChildScrollView(
              child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: CustomTextField(
                                onChanged: (val) {
                                  BlocProvider.of<SubaccountBloc>(context).add(
                                      SubaccountSearch(
                                          data: state.accountsData,
                                          searchValue: val));
                                },
                                hintText: LocaleKeys.search_by_name.tr(),
                                controller: name),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return BlocProvider.value(
                                    value: BlocProvider.of<SubaccountBloc>(
                                        context),
                                    child: SubaccountCreateModal(),
                                  );
                                },
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.only(
                                  left: 12, right: 12, top: 10, bottom: 10),
                              decoration: BoxDecoration(
                                color: AppColors().kPrimaryGreen,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Center(
                                child: Text(
                                  '${LocaleKeys.create_new_subaccount.tr().toString().split(' ')[0]} ${LocaleKeys.create_new_subaccount.tr().toString().split(' ')[2]}',
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 14,
                            child: Text(
                              'ID',
                              style: const TextStyle(fontSize: 13),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 9,
                            child: Text(
                              LocaleKeys.name.tr(),
                              style: const TextStyle(fontSize: 13),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 12,
                            child: Text(
                              LocaleKeys.commission.tr(),
                              style: const TextStyle(fontSize: 13),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 8,
                            child: Text(
                              LocaleKeys.currency.tr(),
                              style: const TextStyle(fontSize: 13),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 4,
                            child: Text(
                              LocaleKeys.wallet.tr(),
                              style: const TextStyle(fontSize: 13),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 10,
                            child: Text(
                              LocaleKeys.calculate_scheme.tr(),
                              style: const TextStyle(fontSize: 13),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Column(
                          children: (name.text == '')
                              ? state.accountsData.map<Widget>((e) {
                                  return SubaccountCard(data: e);
                                }).toList()
                              : state.filteredSubAccounts.map<Widget>((e) {
                                  return SubaccountCard(data: e);
                                }).toList()),
                    ],
                  )),
            );
          }
          return Center(
            child: CustomIndicator(),
          );
        })));
  }
}
