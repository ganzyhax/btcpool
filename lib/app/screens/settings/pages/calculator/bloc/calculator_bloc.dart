import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:btcpool_app/api/api.dart';

part 'calculator_event.dart';
part 'calculator_state.dart';

class CalculatorBloc extends Bloc<CalculatorEvent, CalculatorState> {
  CalculatorBloc() : super(CalculatorInitial()) {
    int selectedType = 0;
    Map<String, dynamic> data = {};
    Map<String, dynamic> res = {};
    String dropDownValue = 'kW';
    calculate({required th, required power, required powerCost, required fee}) {
      double res = (24 *
              60 *
              60 *
              (3.125 + data['average']) *
              th *
              1000000000000 /
              4294967296 /
              data['difficulty']) *
          (1 - fee / 100);
      var resPower = power * 24 * powerCost;
      var result = {
        'price_in_usd': res * data['btcPrice'],
        'btcPrice': data['btcPrice'],
        'amount': res,
        'powerCost': resPower,
        'profit': (res * data['btcPrice']) - resPower
      };
      return result;
    }

    on<CalculatorEvent>((event, emit) async {
      if (event is CalculatorLoad) {
        emit(CalculatorLoaded(
            res: res,
            selectedType: selectedType,
            dropdownValue: dropDownValue));
        data = await ApiClient.get(
            'api/v1/statistic/profitability_calculator/?hashrate=1000&fee=1');
        data['btcPrice'] = await ApiClient().fetchBTCPrice();

        res = calculate(th: 0, power: 0, powerCost: 0, fee: 0);

        emit(CalculatorLoaded(
            res: res,
            selectedType: selectedType,
            dropdownValue: dropDownValue));
      }
      if (event is CalculatorSwitch) {
        selectedType = event.value;
        emit(CalculatorLoaded(
            res: res,
            selectedType: selectedType,
            dropdownValue: dropDownValue));
      }
      if (event is CalculatorCalculate) {
        String hashrate = (event.hashrate == '') ? '0' : event.hashrate;
        String power = (event.power == '') ? '0' : event.power;
        String powerCost = (event.powerCost == '') ? '0' : event.powerCost;
        String percentage = (event.percentage == '') ? '0' : event.percentage;
        if (data == null) {
          emit(CalculatorLoaded(
              res: res,
              selectedType: selectedType,
              dropdownValue: dropDownValue));
          data = await ApiClient.get(
              'api/v1/statistic/profitability_calculator/?hashrate=$hashrate&fee=$percentage');
          data['btcPrice'] = await ApiClient().fetchBTCPrice();
          emit(CalculatorLoaded(
              res: res,
              selectedType: selectedType,
              dropdownValue: dropDownValue));
        } else {
          res = calculate(
            th: double.parse(hashrate.toString().replaceAll(',', '.')),
            power: (dropDownValue == 'kW')
                ? double.parse(power.toString().replaceAll(',', '.'))
                : double.parse(power.toString().replaceAll(',', '.')) / 1000,
            powerCost: double.parse(powerCost.toString().replaceAll(',', '.')),
            fee: double.parse(percentage.toString().replaceAll(',', '.')),
          );
          emit(CalculatorLoaded(
              res: res,
              selectedType: selectedType,
              dropdownValue: dropDownValue));
        }
      }
      if (event is CalculatorChangeDropdownValue) {
        dropDownValue = event.value;
        emit(CalculatorLoaded(
            res: res,
            selectedType: selectedType,
            dropdownValue: dropDownValue));
      }
    });
  }
}
