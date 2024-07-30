import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:btcpool_app/api/api.dart';
import 'package:btcpool_app/api/api_utils.dart';
import 'package:meta/meta.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc() : super(SignupInitial()) {
    String findedBin = '';
    int selectedCountryId = -1;
    bool isLoading = false;
    List countries = [];
    String username = '';
    String password = '';
    on<SignupEvent>((event, emit) async {
      if (event is SignupLoad) {
        try {
          countries = await ApiClient.getUnAuth(
            'api/v1/users/countries/',
          );
        } catch (e) {
          emit(SignupError(message: 'No internet connection... '));
          countries = [];
        }

        emit(SignupLoaded(
          findedBin: findedBin,
          isLoading: isLoading,
          countries: countries,
        ));
      }

      if (event is SignupSetCountryCode) {
        selectedCountryId = event.countryId;
      }
      if (event is SignupRegister) {
        isLoading = true;
        emit(SignupLoaded(
          findedBin: findedBin,
          isLoading: isLoading,
          countries: countries,
        ));
        try {
          var data = await AuthUtils.register(event.username, event.email,
              event.password, event.password, selectedCountryId);
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
        } catch (e) {
          emit(SignupError(message: 'No internet connection... '));
        }
        isLoading = false;
        emit(SignupLoaded(
          findedBin: findedBin,
          isLoading: isLoading,
          countries: countries,
        ));
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
            log('asdasdasd');
            log(data['title'].toString());
            log(data.toString());
            emit(SignupError(message: data['title']));
          }
        } catch (e) {
          emit(SignupError(message: 'No internet connection... '));
        }
        emit(SignupLoaded(
          findedBin: findedBin,
          isLoading: isLoading,
          countries: countries,
        ));
      }
      if (event is SignupSendCode) {
        try {
          var getCode = await AuthUtils.auth(event.email);
          if (getCode) {
            emit(SignupMessage(message: 'Sended new code to your email!'));
          }
        } catch (e) {
          emit(SignupError(message: 'No internet connection... '));
        }
      }
    });
  }
}
