import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:btcpool_app/app/screens/settings/pages/calculator/bloc/calculator_bloc.dart';
import 'package:btcpool_app/app/screens/settings/pages/calculator/components/calculator_switcher.dart';
import 'package:btcpool_app/app/screens/settings/pages/calculator/components/calculator_textfiled.dart';
import 'package:btcpool_app/app/widgets/appbar/custom_appbar.dart';
import 'package:btcpool_app/app/widgets/buttons/custom_button.dart';
import 'package:btcpool_app/app/widgets/custom_indicator.dart';
import 'package:btcpool_app/data/const.dart';
import 'package:btcpool_app/generated/locale_keys.g.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  TextEditingController hashrate = TextEditingController();
  TextEditingController percentage = TextEditingController();
  TextEditingController powerCost = TextEditingController();
  TextEditingController power = TextEditingController();
  @override
  void initState() {
    super.initState();

    // Add listeners to your TextEditingControllers
    hashrate.addListener(_onTextEditiongChanged);
    percentage.addListener(_onTextEditiongChanged);
    powerCost.addListener(_onTextEditiongChanged);
    power.addListener(_onTextEditiongChanged);
  }

  @override
  void dispose() {
    // Clean up the listeners when the widget is disposed
    hashrate.dispose();
    percentage.dispose();
    powerCost.dispose();
    power.dispose();
    super.dispose();
  }

  void _onTextEditiongChanged() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: CustomAppBar(
          title: LocaleKeys.calculator.tr(),
          withArrow: true,
          withSubAccount: false,
        ),
      ),
      body: SingleChildScrollView(
        child: BlocProvider(
          create: (context) => CalculatorBloc()..add(CalculatorLoad()),
          child: BlocBuilder<CalculatorBloc, CalculatorState>(
            builder: (context, state) {
              if (state is CalculatorLoaded) {
                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    padding: const EdgeInsets.all(40),
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondary,
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(LocaleKeys.profitability_calculator.tr(),
                            style: const TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 18)),
                        const SizedBox(
                          height: 20,
                        ),
                        Column(children: [
                          CalculatorTextField(
                            title: 'TH/s',
                            hintText: '0',
                            controller: hashrate,
                          ),
                          CalculatorTextField(
                            controller: powerCost,
                            hintText: '0',
                            title: LocaleKeys.power_cost_per_kwh.tr() + ' (\$)',
                          ),
                          CalculatorTextField(
                            controller: power,
                            hintText: '0',
                            title: LocaleKeys.power_consumption.tr(),
                            dropdownData: ['kW', 'W'],
                            dropdownValue: state.dropdownValue,
                          ),
                          CalculatorTextField(
                            hintText: '0',
                            controller: percentage,
                            title: LocaleKeys.pool_fee.tr() + ' (%)',
                          ),
                        ]),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomButton(
                          color:
                              (Theme.of(context).brightness == Brightness.light)
                                  ? Colors.black
                                  : Colors.white,
                          function: () {
                            BlocProvider.of<CalculatorBloc>(context).add(
                                CalculatorCalculate(
                                    power: power.text,
                                    powerCost: powerCost.text,
                                    hashrate: hashrate.text,
                                    percentage: percentage.text));
                          },
                          text: LocaleKeys.calculate.tr(),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CalculatorSwitcher(
                          value: state.selectedType,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        (!state.res.isEmpty)
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'BTC ' + LocaleKeys.price.tr(),
                                    style: TextStyle(
                                        color: Colors.grey[400], fontSize: 15),
                                  ),
                                  Text('\$${state.res['btcPrice']}',
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700))
                                ],
                              )
                            : Text(LocaleKeys.loading.tr() + '...',
                                style: TextStyle(
                                    color: AppColors().kPrimaryGreen,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700)),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          (state.selectedType == 0)
                              ? LocaleKeys.estimated_24_hour_revenue
                                  .tr()
                                  .toUpperCase()
                              : LocaleKeys.estimated_30_day_revenue
                                  .tr()
                                  .toUpperCase(),
                          style: TextStyle(
                              color: AppColors().kPrimaryGreen, fontSize: 16),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        (!state.res.isEmpty)
                            ? Row(
                                children: [
                                  Text(
                                    (state.selectedType == 0)
                                        ? state.res['amount']
                                                .toStringAsFixed(8) +
                                            ' BTC'
                                        : (state.res['amount'] * 30.4)
                                                .toStringAsFixed(8) +
                                            ' BTC',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                        color: (Theme.of(context).brightness ==
                                                Brightness.light)
                                            ? Colors.black
                                            : Colors.white),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  (!state.res.isEmpty)
                                      ? Text(
                                          (state.selectedType == 0)
                                              ? '${'(\$' + state.res['price_in_usd'].toStringAsFixed(2)})'
                                              : '${'(\$' + (state.res['price_in_usd'] * 30.4).toStringAsFixed(2)})',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600,
                                              color: (Theme.of(context)
                                                          .brightness ==
                                                      Brightness.light)
                                                  ? Colors.black
                                                  : Colors.white),
                                        )
                                      : Text(LocaleKeys.loading.tr() + '...',
                                          style: TextStyle(
                                              color: (Theme.of(context)
                                                          .brightness ==
                                                      Brightness.light)
                                                  ? Colors.black
                                                  : Colors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w700)),
                                ],
                              )
                            : Text(LocaleKeys.loading.tr() + '...',
                                style: TextStyle(
                                    color: AppColors().kPrimaryGreen,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700)),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          (state.selectedType == 0)
                              ? LocaleKeys.power_cost_per_day.tr().toUpperCase()
                              : LocaleKeys.power_cost_per_month
                                  .tr()
                                  .toUpperCase(),
                          style: TextStyle(
                              color: AppColors().kPrimaryGreen, fontSize: 16),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        (!state.res.isEmpty)
                            ? Text(
                                (state.selectedType == 0)
                                    ? '${'(\$' + (state.res['powerCost']).toStringAsFixed(2)})'
                                    : '${'(\$' + ((state.res['powerCost']) * 30.4).toStringAsFixed(2)})',
                                style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w600,
                                    color: (Theme.of(context).brightness ==
                                            Brightness.light)
                                        ? Colors.black
                                        : Colors.white),
                              )
                            : Text(LocaleKeys.loading.tr() + '...',
                                style: TextStyle(
                                    color: AppColors().kPrimaryGreen,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700)),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          (state.selectedType == 0)
                              ? LocaleKeys.profit_cost_per_day
                                  .tr()
                                  .toUpperCase()
                              : LocaleKeys.profit_cost_per_month
                                  .tr()
                                  .toUpperCase(),
                          style: TextStyle(
                              color: AppColors().kPrimaryGreen, fontSize: 16),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        (!state.res.isEmpty)
                            ? Text(
                                (state.selectedType == 0)
                                    ? '${'(\$' + (state.res['profit']).toStringAsFixed(2)})'
                                    : '${'(\$' + ((state.res['profit']) * 30.4).toStringAsFixed(2)})',
                                style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w600,
                                    color: (state.res['profit']
                                            .toString()
                                            .contains('-'))
                                        ? Colors.red
                                        : (Theme.of(context).brightness ==
                                                Brightness.light)
                                            ? Colors.black
                                            : Colors.white),
                              )
                            : Text(LocaleKeys.loading.tr() + '...',
                                style: TextStyle(
                                    color: AppColors().kPrimaryGreen,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700)),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          LocaleKeys.revenue_change_info.tr(),
                          style:
                              TextStyle(color: Colors.grey[400], fontSize: 15),
                        ),
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
      ),
    );
  }
}
