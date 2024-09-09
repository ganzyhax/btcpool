part of 'language_bloc.dart';

@immutable
sealed class LanguageEvent {}

final class LanguageLoad extends LanguageEvent {}

final class LanguageChangeIndex extends LanguageEvent {
  int index;
  LanguageChangeIndex({required this.index});
}

final class LanguageBack extends LanguageEvent {}
