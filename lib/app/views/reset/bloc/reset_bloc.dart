import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:btcpool_app/api/api_utils.dart';
import 'package:meta/meta.dart';

part 'reset_event.dart';
part 'reset_state.dart';

class ResetBloc extends Bloc<ResetEvent, ResetState> {
  ResetBloc() : super(ResetInitial()) {
    String resetToken = '';
    String email = '';
    bool isLoading = false;
    on<ResetEvent>((event, emit) async {
      if (event is ResetSendCode) {
        try {
          var data = await AuthUtils.reset(event.email);
          log(data.toString());
          if (data == true) {
            emit(ResetSendSuccess(email: event.email));
          } else if (data.containsKey('title')) {
            emit(ResetError(message: data['message']));
            emit(ResetLoaded(isLoading: isLoading));
          }
        } catch (e) {
          print(e);
          emit(ResetError(message: 'No internet connection...'));
        }

        emit(ResetLoaded(isLoading: isLoading));
      }
      if (event is ResetConfirm) {
        try {
          email = event.email;
          var data = await AuthUtils.resetConfirmCode(event.email, event.code);
          if (data.containsKey('title')) {
            emit(ResetError(message: data['message']));
          } else {
            resetToken = data['reset_token'];
            emit(ResetResetPassword());
          }
        } catch (e) {
          emit(ResetError(message: 'No internet connection...'));
        }
        emit(ResetLoaded(isLoading: isLoading));
      }
      if (event is ResetSetPassword) {
        try {
          var data = await AuthUtils.resetSetPassword(
              email, event.password, resetToken);
          if (data == true) {
            emit(ResetSuccess());
          } else {
            emit(ResetError(message: 'No internet connection...'));
          }
        } catch (e) {
          emit(ResetError(message: 'No internet connection...'));
        }
        emit(ResetLoaded(isLoading: isLoading));
      }
    });
  }
}
