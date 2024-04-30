import 'package:bloc/bloc.dart';
import 'package:btcpool_app/api/api.dart';
import 'package:btcpool_app/api/api_utils.dart';
import 'package:meta/meta.dart';

part 'api_event.dart';
part 'api_state.dart';

class ApiBloc extends Bloc<ApiEvent, ApiState> {
  ApiBloc() : super(ApiInitial()) {
    var accountsData;
    on<ApiEvent>((event, emit) async {
      if (event is ApiLoad) {
        accountsData = await ApiClient.get('api/v1/pools/sub_account/all/');
        int selectedSubAccount = await AuthUtils.getIndexSubAccount();

        final data = await ApiClient.get(
            'api/v1/pools/sub_account/api_key/all/?sub_account_name=' +
                accountsData[selectedSubAccount]['name']);
        emit(ApiLoaded(data: data));
      }
      if (event is ApiSubAccountChange) {
        if (accountsData == null) {
          accountsData = await ApiClient.get('api/v1/pools/sub_account/all/');
        }
        print('asdasdads');
        int selectedSubAccount = await AuthUtils.getIndexSubAccount();
        final data = await ApiClient.get(
            'api/v1/pools/sub_account/api_key/all/?sub_account_name=' +
                accountsData[selectedSubAccount]['name']);
        emit(ApiLoaded(data: data));
      }
      if (event is ApiCreate) {
        int selectedSubAccount = await AuthUtils.getIndexSubAccount();
        await ApiClient.post('api/v1/pools/sub_account/api_key/create/',
            {'sub_account_name': accountsData[selectedSubAccount]['name']});
        add(ApiLoad());
      }
      if (event is ApiDelete) {
        int selectedSubAccount = await AuthUtils.getIndexSubAccount();
        await ApiClient.del('api/v1/pools/sub_account/api_key/delete/', {
          'sub_account_name': accountsData[selectedSubAccount]['name'],
          'api_key': event.apiKey
        });
        add(ApiLoad());
      }
    });
  }
}
