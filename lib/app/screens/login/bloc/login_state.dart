part of 'login_bloc.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

final class LoginLoaded extends LoginState {
  final bool isLoading;
  LoginLoaded({required this.isLoading});
}

final class LoginSuccess extends LoginState {}

final class LoginError extends LoginState {
  final String message;
  LoginError({required this.message});
}

final class LoginOtp extends LoginState {
  String oathToken;
  LoginOtp({required this.oathToken});
}

final class LoginUpdateShow extends LoginState {}

final class LoginUnVerifiedEmail extends LoginState {
  final String email;
  LoginUnVerifiedEmail({required this.email});
}
