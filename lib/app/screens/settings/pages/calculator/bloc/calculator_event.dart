part of 'calculator_bloc.dart';

@immutable
sealed class CalculatorEvent {}

class CalculatorLoad extends CalculatorEvent {}

class CalculatorSwitch extends CalculatorEvent {
  int value;
  CalculatorSwitch({required this.value});
}

class CalculatorCalculate extends CalculatorEvent {
  String hashrate;
  String percentage;
  String powerCost;
  String power;
  CalculatorCalculate(
      {required this.hashrate,
      required this.percentage,
      required this.power,
      required this.powerCost});
}

class CalculatorChangeDropdownValue extends CalculatorEvent {
  String value;
  CalculatorChangeDropdownValue({required this.value});
}
