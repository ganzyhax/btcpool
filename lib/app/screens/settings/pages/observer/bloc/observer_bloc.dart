import 'package:bloc/bloc.dart';
import 'package:btcpool_app/api/api.dart';
import 'package:btcpool_app/app/screens/settings/pages/api/bloc/api_bloc.dart';
import 'package:meta/meta.dart';

part 'observer_event.dart';
part 'observer_state.dart';

class ObserverBloc extends Bloc<ObserverEvent, ObserverState> {
  ObserverBloc() : super(ObserverInitial()) {
    List<bool> switches = [false, false, false, false, false];
    List selectedSubIds = [];
    List observerLinks = [];
    on<ObserverEvent>((event, emit) async {
      if (event is ObserverLoad) {
        selectedSubIds = [];
        switches = [false, false, false, false, false];
        observerLinks =
            await ApiClient.get('api/v1/pools/sub_account/observer_link/all/');
        for (var data in observerLinks) {
          print(data);
        }
        emit(ObserverLoaded(switches: switches, observerLinks: observerLinks));
      }
      if (event is ObserverChangeSwitchValue) {
        if (switches[event.index] == true) {
          switches[event.index] = false;
        } else {
          switches[event.index] = true;
        }
        emit(ObserverLoaded(switches: switches, observerLinks: observerLinks));
      }
      if (event is ObserverChooseSubAccount) {
        selectedSubIds = event.data;
      }
      if (event is ObserverCreate) {
        var res = await ApiClient.post(
            'api/v1/pools/sub_account/observer_link/create/',
            {
              'balance_enabled': switches[0],
              'earnings_enabled': switches[2],
              'hashrate_chart_enabled': switches[4],
              'name': event.name,
              'payouts_enabled': switches[3],
              'statistics_enabled': switches[1],
              'sub_account_ids': selectedSubIds
            },
            withBadRequest: true);
        if (res.containsKey('title')) {
          emit(ObserverError(message: res['title']));
        } else {
          emit(ObserverSuccess(message: 'Created successfully'));
        }
        add(ObserverLoad());
      }
    });
  }
}
