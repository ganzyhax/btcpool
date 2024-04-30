part of 'signup_bloc.dart';

@immutable
sealed class SignupState {}

final class SignupInitial extends SignupState {}

final class SignupLoaded extends SignupState {
  final String findedBin;
  final bool isLoading;
  SignupLoaded({required this.findedBin, required this.isLoading});
}

final class SignupLoading extends SignupState {}

final class SignupError extends SignupState {
  String message;
  SignupError({required this.message});
}

final class SignupVerifyOpen extends SignupState {}

final class SignupSuccess extends SignupState {}

final class SignupMessage extends SignupState {
  final String message;
  SignupMessage({required this.message});
}
