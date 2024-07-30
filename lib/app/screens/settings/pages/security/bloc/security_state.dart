part of 'security_bloc.dart';

@immutable
sealed class SecurityState {}

final class SecurityInitial extends SecurityState {}

final class SecurityLoaded extends SecurityState {
  final bool isSecured;

  SecurityLoaded({
    required this.isSecured,
  });
}
