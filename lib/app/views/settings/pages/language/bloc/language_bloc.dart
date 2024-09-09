import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:meta/meta.dart';
import 'package:intl/intl.dart';
import 'package:btcpool_app/api/api_utils.dart';

part 'language_event.dart';
part 'language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  LanguageBloc() : super(LanguageInitial()) {
    int selectedIndex = 0;
    on<LanguageEvent>((event, emit) async {
      if (event is LanguageLoad) {
        String locale = '';
        String localLang = await AuthUtils.getLanguage();
        if (localLang != 'null') {
          locale = localLang;
        } else {
          locale = Intl.getCurrentLocale();
        }

        if (locale.contains('ru')) {
          selectedIndex = 0;
        }
        if (locale.contains('kk')) {
          selectedIndex = 1;
        }

        emit(LanguageLoaded(selectedIndex: selectedIndex));
      }
      if (event is LanguageChangeIndex) {
        selectedIndex = event.index;
        if (selectedIndex == 0) {
          await AuthUtils.setLanguage('ru');
        }
        if (selectedIndex == 1) {
          await AuthUtils.setLanguage('kk');
        }

        emit(LanguageLoaded(selectedIndex: selectedIndex));
      }
    });
  }
}
