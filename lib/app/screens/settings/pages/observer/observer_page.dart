import 'package:btcpool_app/app/screens/dashboard/bloc/dashboard_bloc.dart';
import 'package:btcpool_app/app/screens/settings/pages/observer/bloc/observer_bloc.dart';
import 'package:btcpool_app/app/widgets/appbar/custom_appbar.dart';
import 'package:btcpool_app/app/widgets/buttons/custom_button.dart';
import 'package:btcpool_app/app/widgets/buttons/custom_dropdown_button.dart';
import 'package:btcpool_app/app/widgets/custom_indicator.dart';
import 'package:btcpool_app/app/widgets/custom_snackbar.dart';
import 'package:btcpool_app/app/widgets/textfields/custom_textfiled.dart';
import 'package:btcpool_app/data/const.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';

class ObserverPage extends StatelessWidget {
  const ObserverPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> labels = [
      'Balance',
      'Statistics',
      'Earnings',
      'Payouts',
      'Hashrate graphics'
    ];

    TextEditingController name = TextEditingController();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: CustomAppBar(
          title: 'Observer',
          withArrow: true,
          withSubAccount: false,
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: BlocListener<ObserverBloc, ObserverState>(
        listener: (context, state) {
          if (state is ObserverError) {
            CustomSnackbar().showCustomSnackbar(context, state.message, false);
          }
          if (state is ObserverSuccess) {
            CustomSnackbar().showCustomSnackbar(context, state.message, true);
          }
        },
        child: BlocProvider(
          create: (context) => ObserverBloc()..add(ObserverLoad()),
          child: BlocBuilder<DashboardBloc, DashboardState>(
            builder: (context, state) {
              if (state is DashboardLoaded) {
                return BlocBuilder<ObserverBloc, ObserverState>(
                  builder: (context, state2) {
                    double localHeight = double.parse(
                        (state.subAccounts.length * 50).toString());
                    if (state2 is ObserverLoaded) {
                      return SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 7,
                              ),
                              Text('Name'),
                              SizedBox(
                                height: 14,
                              ),
                              CustomTextField(
                                  hintText: 'Name', controller: name),
                              SizedBox(
                                height: 14,
                              ),
                              Text('Choose subaccounts'),
                              SizedBox(
                                height: 14,
                              ),
                              MultiSelectDropDown<String>(
                                onOptionSelected:
                                    (List<ValueItem<String>> selectedOptions) {
                                  List<dynamic> valuesList = selectedOptions
                                      .map((item) =>
                                          int.parse(item.value.toString()))
                                      .toList();
                                  BlocProvider.of<ObserverBloc>(context)
                                    ..add(ObserverChooseSubAccount(
                                        data: valuesList));
                                  name.clear();
                                },
                                options: state.subAccounts
                                    .map<ValueItem<String>>((subAccount) {
                                  return ValueItem<String>(
                                    label: subAccount['name'],
                                    value: subAccount['id'].toString(),
                                  );
                                }).toList(),
                                selectionType: SelectionType.multi,
                                chipConfig: ChipConfig(wrapType: WrapType.wrap),
                                dropdownHeight: localHeight,
                                optionTextStyle: const TextStyle(fontSize: 16),
                                selectedOptionTextColor:
                                    AppColors().kPrimaryGreen,
                                selectedOptionBackgroundColor:
                                    Colors.grey.shade300,
                                searchBackgroundColor:
                                    AppColors().kPrimaryGreen,
                                selectedOptionIcon:
                                    const Icon(Icons.check_circle),
                              ),
                              SizedBox(
                                height: 14,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: labels.map<Widget>((e) {
                                    int index = labels.indexOf(e);
                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        CupertinoSwitch(
                                          activeColor:
                                              AppColors().kPrimaryGreen,
                                          value: state2.switches[index],
                                          onChanged: (value) {
                                            BlocProvider.of<ObserverBloc>(
                                                context)
                                              ..add(ObserverChangeSwitchValue(
                                                  index: index));
                                          },
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(e),
                                      ],
                                    );
                                  }).toList(),
                                ),
                              ),
                              SizedBox(
                                height: 14,
                              ),
                              CustomButton(
                                text: 'Create observer url',
                                function: () {
                                  BlocProvider.of<ObserverBloc>(context)
                                    ..add(ObserverCreate(name: name.text));
                                },
                              ),
                              SizedBox(
                                height: 14,
                              ),
                              Divider(
                                thickness: 1,
                                color: AppColors().kPrimaryGreen,
                              ),
                              SizedBox(
                                height: 14,
                              ),
                              DataTable(
                                  headingRowColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.blue),
                                  dividerThickness: 1,
                                  horizontalMargin: 0,
                                  columnSpacing: 7,
                                  showBottomBorder: true,
                                  dataRowMaxHeight: 90,
                                  headingTextStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                  columns: [
                                    DataColumn(
                                      label: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 5.0),
                                        child: Text('Name'),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Text('Rights'),
                                    ),
                                    DataColumn(
                                      label: Text('SubAccounts'),
                                    ),
                                    DataColumn(
                                      label: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 5.0),
                                        child: Text('URL'),
                                      ),
                                    ),
                                  ],
                                  rows: state2.observerLinks.map((e) {
                                    String rights = '';
                                    if (e['balance_enabled'] == true) {
                                      rights = rights + 'Balance,';
                                    }
                                    if (e['statistics_enabled'] == true) {
                                      rights = rights + 'Statistics,';
                                    }
                                    if (e['hashrate_chart_enabled'] == true) {
                                      rights = rights + 'Hasrate,';
                                    }
                                    if (e['payouts_enabled'] == true) {
                                      rights = rights + 'Payouts,';
                                    }
                                    if (e['earnings_enabled'] == true) {
                                      rights = rights + 'Earnings,';
                                    }
                                    return DataRow(cells: [
                                      DataCell(SizedBox(
                                          width: (MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              7),
                                          child: Text(e['name']))),
                                      DataCell(SizedBox(
                                          width: (MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              3),
                                          child: Text(rights))),
                                      DataCell(SizedBox(
                                          width: (MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              3),
                                          child: Text(e['sub_accounts']
                                              .toString()
                                              .replaceAll('[', '')
                                              .replaceAll(']', '')))),
                                      DataCell(InkWell(
                                        onTap: () {
                                          print(
                                              'https://new.btcpool.kz/observer-link/' +
                                                  e['link']
                                                      .toString()
                                                      .split('/')[7]);
                                        },
                                        child: Icon(
                                          Icons.open_in_new_rounded,
                                          color: AppColors().kPrimaryGreen,
                                        ),
                                      )),
                                    ]);
                                  }).toList())
                            ],
                          ),
                        ),
                      );
                    }
                    return Center(
                      child: CustomIndicator(),
                    );
                  },
                );
              }
              return Center(
                child: CustomIndicator(),
              );
            },
          ),
        ),
      ),
    );
  }
}
