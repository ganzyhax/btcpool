part of 'language_bloc.dart';

@immutable
sealed class LanguageState {}

final class LanguageInitial extends LanguageState {}

final class LanguageLoaded extends LanguageState {
  int selectedIndex;
  LanguageLoaded({required this.selectedIndex});
}
