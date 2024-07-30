part of 'login_bloc.dart';

@immutable
sealed class LoginEvent {}

class LoginLaod extends LoginEvent {}

class LoginLog extends LoginEvent {
  String login;
  String password;
  String otp;
  LoginLog({required this.login, required this.password, required this.otp});
}

class LoginLogWithOtp extends LoginEvent {
  String oathToken;
  String otp;
  LoginLogWithOtp({required this.oathToken, required this.otp});
}
