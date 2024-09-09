part of 'personal_bloc.dart';

@immutable
sealed class PersonalState {}

final class PersonalInitial extends PersonalState {}

final class PersonalLoaded extends PersonalState {
  final data;
  final bool isLoading;
  PersonalLoaded({required this.data, required this.isLoading});
}

final class PersonalSuccess extends PersonalState {
  String message;
  PersonalSuccess({required this.message});
}

final class PersonalError extends PersonalState {
  String message;
  PersonalError({required this.message});
}
