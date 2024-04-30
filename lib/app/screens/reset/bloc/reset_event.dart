part of 'reset_bloc.dart';

@immutable
sealed class ResetEvent {}

class ResetLoad extends ResetEvent {}

class ResetSendCode extends ResetEvent {
  final String email;
  ResetSendCode({required this.email});
}

class ResetConfirm extends ResetEvent {
  final String email;
  final String code;
  ResetConfirm({required this.code, required this.email});
}

class ResetSetPassword extends ResetEvent {
  final String password;
  ResetSetPassword({required this.password});
}
