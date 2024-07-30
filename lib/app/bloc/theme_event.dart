part of 'theme_bloc.dart';

@immutable
sealed class ThemeEvent {}

final class ThemeChange extends ThemeEvent {
  bool value;
  ThemeChange({required this.value});
}
