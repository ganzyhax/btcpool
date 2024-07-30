import 'package:bloc/bloc.dart';
import 'package:btcpool_app/api/api_utils.dart';
import 'package:flutter/material.dart';
part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc(BuildContext context) : super(ThemeLoading()) {
    _initializeTheme(context);
    on<ThemeEvent>((event, emit) async {
      if (event is ThemeChange) {
        await AuthUtils.setThemeMode(event.value.toString());

        emit(ThemeLoaded(isDark: event.value));
      }
    });
  }

  Future<void> _initializeTheme(BuildContext context) async {
    final isDark = await AuthUtils.getThemeMode();
    emit(ThemeLoaded(isDark: isDark == true));
  }
}
