import 'package:bloc/bloc.dart';
import 'package:btcpool_app/api/api.dart';
import 'package:meta/meta.dart';

part 'subaccount_event.dart';
part 'subaccount_state.dart';

class SubaccountBloc extends Bloc<SubaccountEvent, SubaccountState> {
  SubaccountBloc() : super(SubaccountInitial()) {
    String method = 'FPPS';
    final bool isLoading = false;
    on<SubaccountEvent>((event, emit) async {
      if (event is SubaccountLoad) {
        emit(SubaccountLoaded());
      }

      if (event is SubaccountSetMethod) {
        method = event.method;
      }
      if (event is SubaccountCreate) {
        var data = await ApiClient.post(
            'api/v1/pools/sub_account/create/',
            {
              'crypto_currency': "BTC",
              'earning_scheme_id': (method == 'FPPS') ? 1 : 2,
              'name': event.name,
              'wallet_address': event.wallet
            },
            withBadRequest: true);

        if (data.containsKey('title')) {
          emit(SubaccountError(message: data['title']));
        } else {
          emit(SubaccountSuccess(message: 'Created successfully!'));
        }

        emit(SubaccountLoaded());
      }
    });
  }
}
