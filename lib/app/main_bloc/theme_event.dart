part of 'theme_bloc.dart';

sealed class ThemeEvent {}

final class ThemeChange extends ThemeEvent {
  bool value;
  ThemeChange({required this.value});
}
