import 'package:bloc/bloc.dart';
import 'package:btcpool_app/api/api.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

part 'fa_event.dart';
part 'fa_state.dart';

class FaBloc extends Bloc<FaEvent, FaState> {
  FaBloc() : super(FaInitial()) {
    on<FaEvent>((event, emit) async {
      if (event is FaLoad) {
        var qrCode = await ApiClient.get('api/v1/otp/qr_code/', isJson: false);
        var isEnabled = await ApiClient.get('api/v1/otp/is_enabled/');

        var secretCode = await ApiClient.get('api/v1/otp/secret_key/');

        emit(FaLoaded(
            isTurnedFa: isEnabled['is_otp_enabled'],
            secretCode: secretCode['secret_key']
                .toString()
                .replaceAll('<?xml version="1.0" encoding="UTF-8"?>', ''),
            svgImage: qrCode));
      }
    });
  }
}
