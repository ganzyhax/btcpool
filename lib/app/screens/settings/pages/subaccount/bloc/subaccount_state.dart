part of 'subaccount_bloc.dart';

@immutable
sealed class SubaccountState {}

final class SubaccountInitial extends SubaccountState {}

final class SubaccountLoaded extends SubaccountState {}

final class SubaccountError extends SubaccountState {
  final String message;
  SubaccountError({required this.message});
}

final class SubaccountSuccess extends SubaccountState {
  final String message;
  SubaccountSuccess({required this.message});
}
