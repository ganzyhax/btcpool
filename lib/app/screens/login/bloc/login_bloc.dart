import 'package:bloc/bloc.dart';
import 'package:btcpool_app/api/api.dart';
import 'package:btcpool_app/api/api_utils.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginEvent>((event, emit) async {
      if (event is LoginLaod) {
        emit(LoginLoaded(isLoading: false));
      }
      if (event is LoginLog) {
        emit(LoginLoaded(isLoading: true));
        var data =
            await AuthUtils.login(event.login, event.password, event.otp);

        if (data == true) {
          emit(LoginSuccess());
        } else {
          if (data.containsKey('title')) {
            emit(LoginError(message: data['title']));
          }
        }
        emit(LoginLoaded(isLoading: false));
      }
    });
  }
}
