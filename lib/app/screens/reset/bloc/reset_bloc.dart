import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:btcpool_app/api/api_utils.dart';
import 'package:meta/meta.dart';

part 'reset_event.dart';
part 'reset_state.dart';

class ResetBloc extends Bloc<ResetEvent, ResetState> {
  ResetBloc() : super(ResetInitial()) {
    String resetToken = '';
    String email = '';
    on<ResetEvent>((event, emit) async {
      if (event is ResetSendCode) {
        bool isSuccess = await AuthUtils.reset(event.email);
        if (isSuccess) {
          emit(ResetSendSuccess(email: event.email));
          emit(ResetLoaded());
        }
      }
      if (event is ResetConfirm) {
        email = event.email;
        var data = await AuthUtils.resetConfirmCode(event.email, event.code);
        if (data.containsKey('title')) {
          emit(ResetError(message: data['message']));
          emit(ResetLoaded());
        } else {
          resetToken = data['reset_token'];
          emit(ResetResetPassword());
          emit(ResetLoaded());
        }
      }
      if (event is ResetSetPassword) {
        var data =
            await AuthUtils.resetSetPassword(email, event.password, resetToken);
        print(data);
        emit(ResetSuccess());
        emit(ResetLoaded());
      }
    });
  }
}
