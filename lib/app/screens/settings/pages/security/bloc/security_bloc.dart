import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:btcpool_app/api/api_utils.dart';

part 'security_event.dart';
part 'security_state.dart';

class SecurityBloc extends Bloc<SecurityEvent, SecurityState> {
  SecurityBloc() : super(SecurityInitial()) {
    on<SecurityEvent>((event, emit) async {
      bool isSecured = false;
      if (event is SecurityLoad) {
        isSecured = await AuthUtils.getIsSecure() ?? false;

        emit(SecurityLoaded(
          isSecured: isSecured,
        ));
      }
      if (event is SecurtiyOn) {
        isSecured = true;
        await AuthUtils.setIsSecure(true);
        emit(SecurityLoaded(
          isSecured: isSecured,
        ));
      }
      if (event is SecurtiyOff) {
        await AuthUtils.setIsSecure(false);
        isSecured = false;
        emit(SecurityLoaded(
          isSecured: isSecured,
        ));
      }
    });
  }
}
