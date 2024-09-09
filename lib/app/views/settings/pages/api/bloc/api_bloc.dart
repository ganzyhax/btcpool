import 'package:bloc/bloc.dart';
import 'package:btcpool_app/api/api.dart';
import 'package:btcpool_app/api/api_utils.dart';
import 'package:meta/meta.dart';

part 'api_event.dart';
part 'api_state.dart';

class ApiBloc extends Bloc<ApiEvent, ApiState> {
  ApiBloc() : super(ApiInitial()) {
    var accountsData;
    var data = [];
    bool isLoading = false;
    on<ApiEvent>((event, emit) async {
      if (event is ApiLoad) {
        isLoading = true;
        emit(ApiLoaded(data: data, isLoading: isLoading));

        accountsData = await ApiClient.get('api/v1/pools/sub_account/all/');
        int selectedSubAccount = await AuthUtils.getIndexSubAccount();

        try {
          data = await ApiClient.get(
              'api/v1/pools/sub_account/api_key/all/?sub_account_name=' +
                  accountsData[selectedSubAccount]['name']);
        } catch (e) {}
        isLoading = false;
        emit(ApiLoaded(data: data, isLoading: isLoading));
      }

      if (event is ApiCreate) {
        isLoading = true;
        emit(ApiLoaded(data: data, isLoading: isLoading));
        int selectedSubAccount = await AuthUtils.getIndexSubAccount();
        await ApiClient.post('api/v1/pools/sub_account/api_key/create/',
            {'sub_account_name': accountsData[selectedSubAccount]['name']});
        add(ApiLoad());
      }
      if (event is ApiDelete) {
        isLoading = true;
        emit(ApiLoaded(data: data, isLoading: isLoading));
        int selectedSubAccount = await AuthUtils.getIndexSubAccount();
        await ApiClient.del('api/v1/pools/sub_account/api_key/delete/', {
          'sub_account_name': accountsData[selectedSubAccount]['name'],
          'api_key': event.apiKey
        });
        add(ApiLoad());
      }
      if (event is ApiSubAccountChange) {
        accountsData ??= await ApiClient.get('api/v1/pools/sub_account/all/');

        try {
          data = await ApiClient.get(
              'api/v1/pools/sub_account/api_key/all/?sub_account_name=' +
                  accountsData[event.index]['name']);
        } catch (e) {}
        emit(ApiLoaded(data: data, isLoading: isLoading));
      }

      if (event is ApiSubAccountUpdate) {
        accountsData = await ApiClient.get('api/v1/pools/sub_account/all/');
      }
    });
  }
}
