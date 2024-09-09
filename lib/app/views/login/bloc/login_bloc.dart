import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:btcpool_app/api/api.dart';
import 'package:btcpool_app/api/api_utils.dart';

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
        try {
          var data =
              await AuthUtils.login(event.login, event.password, event.otp);
          if (data == true) {
            emit(LoginSuccess());
          } else {
            if (data == false) {
              emit(LoginError(message: 'No internet connection...'));
            } else if (data.containsKey('title')) {
              emit(LoginError(message: data['title']));
            }
          }
          emit(LoginLoaded(isLoading: false));
        } catch (e) {
          log(e.toString());
          emit(LoginError(message: 'No internet connection...'));
        }
        emit(LoginLoaded(isLoading: false));
      }
      if (event is LoginLogWithOtp) {
        try {
          var data = await AuthUtils.loginWithOtp(
            event.oathToken,
            event.otp,
          );

          if (data == true) {
            emit(LoginSuccess());
          } else {
            if (data == false) {
              emit(LoginError(message: 'No internet connection...'));
            }
            if (data.containsKey('title')) {
              emit(LoginError(message: data['title']));
            }
          }
        } catch (e) {
          emit(LoginError(message: 'No internet connection...'));
        }
        emit(LoginLoaded(isLoading: false));
      }
    });
  }
}
