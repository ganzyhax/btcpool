import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:btcpool_app/app/screens/settings/pages/calculator/bloc/calculator_bloc.dart';
import 'package:btcpool_app/data/const.dart';
import 'package:btcpool_app/generated/locale_keys.g.dart';

class CalculatorSwitcher extends StatelessWidget {
  final int value;

  const CalculatorSwitcher({Key? key, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Theme.of(context).colorScheme.background,
      ),
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () {
              BlocProvider.of<CalculatorBloc>(context)
                  .add(CalculatorSwitch(value: 0));
            },
            child: _buildSwitchItem(LocaleKeys.daily.tr(), 0 == value, context),
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: () {
              BlocProvider.of<CalculatorBloc>(context)
                  .add(CalculatorSwitch(value: 1));
            },
            child:
                _buildSwitchItem(LocaleKeys.monthly.tr(), 1 == value, context),
          ),
        ],
      ),
    );
  }

  Widget _buildSwitchItem(String text, bool isSelected, context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      decoration: BoxDecoration(
        color: isSelected
            ? Theme.of(context).colorScheme.secondary
            : Theme.of(context).colorScheme.background,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: isSelected
              ? (Theme.of(context).brightness == Brightness.light)
                  ? Colors.black
                  : Colors.white
              : (Theme.of(context).brightness == Brightness.dark)
                  ? Colors.white
                  : Colors.black,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
