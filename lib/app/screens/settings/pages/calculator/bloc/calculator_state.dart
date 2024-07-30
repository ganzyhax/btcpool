part of 'calculator_bloc.dart';

@immutable
sealed class CalculatorState {}

final class CalculatorInitial extends CalculatorState {}

final class CalculatorLoaded extends CalculatorState {
  Map<String, dynamic> res;
  int selectedType;
  String dropdownValue;
  CalculatorLoaded(
      {required this.res,
      required this.selectedType,
      required this.dropdownValue});
}
