part of 'theme_bloc.dart';

sealed class ThemeState {}

final class ThemeInitial extends ThemeState {}

final class ThemeLoaded extends ThemeState {
  bool isDark;
  ThemeLoaded({required this.isDark});
}

final class ThemeLoading extends ThemeState {}
