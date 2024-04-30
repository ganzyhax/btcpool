part of 'reset_bloc.dart';

@immutable
sealed class ResetState {}

final class ResetInitial extends ResetState {}

final class ResetLoaded extends ResetState {}

final class ResetSendSuccess extends ResetState {
  final String email;
  ResetSendSuccess({required this.email});
}

final class ResetResetPassword extends ResetState {
  // final String resetToken;
  // ResetResetPassword({required this.resetToken});
}

final class ResetSuccess extends ResetState {}

final class ResetError extends ResetState {
  final String message;
  ResetError({required this.message});
}
