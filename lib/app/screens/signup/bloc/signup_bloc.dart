import 'package:bloc/bloc.dart';
import 'package:btcpool_app/api/api.dart';
import 'package:btcpool_app/api/api_utils.dart';
import 'package:meta/meta.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc() : super(SignupInitial()) {
    String findedBin = '';
    final bool isLoading = false;
    on<SignupEvent>((event, emit) async {
      if (event is SignupLoad) {
        emit(SignupLoaded(findedBin: findedBin, isLoading: isLoading));
      }

      if (event is SignupFindBin) {
        var data = await ApiClient.getUnAuth(
            'api/v1/users/check_bin/?bin=' + event.value);
        if (data != null) {
          findedBin = data['name_ru'];
        } else {
          findedBin = 'null';
        }
        emit(SignupLoaded(findedBin: findedBin, isLoading: isLoading));
      }

      if (event is SignupRegister) {
        var data = await AuthUtils.register(
            event.username,
            event.email,
            event.password,
            event.password,
            event.organization_bin,
            event.phone);
        print(data);
        if (data.containsKey('title')) {
          emit(SignupError(message: data['title']));
        } else if (data.containsKey('id')) {
          var getCode = await AuthUtils.auth(event.email);

          if (getCode) {
            emit(SignupVerifyOpen());
          }
        }
        emit(SignupLoaded(findedBin: findedBin, isLoading: isLoading));
      }
      if (event is SignupVerify) {
        var data = await AuthUtils.verify(event.email, event.value);
        if (data) {
          emit(SignupSuccess());
        } else {
          emit(SignupError(message: data['title']));
        }
      }
      if (event is SignupSendCode) {
        var getCode = await AuthUtils.auth(event.email);
        if (getCode) {
          emit(SignupMessage(message: 'Sended new code to your email!'));
        }
      }
    });
  }
}
