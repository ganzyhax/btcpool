import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:btcpool_app/api/api.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationBloc() : super(NotificationInitial()) {
    on<NotificationEvent>((event, emit) async {
      final data;
      if (event is NotificationLoad) {
        data = await ApiClient.get('api/v1/telegram_notification/token/');
        log(data.toString());
        emit(NotificationLoaded(data: data));
      }
    });
  }
}
