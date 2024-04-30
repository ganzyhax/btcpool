part of 'subaccount_bloc.dart';

@immutable
sealed class SubaccountEvent {}

class SubaccountLoad extends SubaccountEvent {}

class SubaccountCreate extends SubaccountEvent {
  final String name;
  final String wallet;
  SubaccountCreate({required this.name, required this.wallet});
}

class SubaccountSetMethod extends SubaccountEvent {
  final String method;

  SubaccountSetMethod({required this.method});
}
