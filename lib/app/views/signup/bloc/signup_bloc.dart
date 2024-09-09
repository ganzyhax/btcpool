import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:btcpool_app/api/api.dart';
import 'package:btcpool_app/api/api_utils.dart';
import 'package:meta/meta.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc() : super(SignupInitial()) {
    String findedBin = '';
    bool isLoading = false;
    String password = '';
    String username = '';
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
        var data = await AuthUtils.register(event.email, event.username,
            event.phone, event.password, event.organization_bin);
        username = event.username;
        password = event.password;
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
        try {
          var data = await AuthUtils.verify(event.email, event.value);

          if (data is bool && data) {
            if (event.isReVerify) {
              emit(SignupSuccess());
            } else {
              var datas = await AuthUtils.login(username, password, '');
              if (datas == true) {
                emit(SignupSuccess());
              } else {
                if (datas.containsKey('title')) {
                  emit(SignupError(message: datas['title']));
                }
              }
            }
          } else {
            emit(SignupError(message: data['title']));
          }
        } catch (e) {
          emit(SignupError(message: 'No internet connection... '));
        }
        emit(SignupLoaded(
          findedBin: findedBin,
          isLoading: isLoading,
        ));
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
