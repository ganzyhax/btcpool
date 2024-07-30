part of 'subaccount_bloc.dart';

@immutable
sealed class SubaccountEvent {}

class SubaccountLoad extends SubaccountEvent {}

class SubaccountCreate extends SubaccountEvent {
  final String name;
  final String wallet;
  SubaccountCreate({required this.name, required this.wallet});
}

class SubaccountNewCreate extends SubaccountEvent {
  final String name;
  final String wallet;
  SubaccountNewCreate({required this.name, required this.wallet});
}

class SubaccountSetMethod extends SubaccountEvent {
  final String method;

  SubaccountSetMethod({required this.method});
}

class SubaccountCheckSplit extends SubaccountEvent {
  final bool value;
  SubaccountCheckSplit({required this.value});
}

final class SubaccountAddSubAccount extends SubaccountEvent {
  final data;
  SubaccountAddSubAccount({required this.data});
}

final class SubaccountDeleteSubAccount extends SubaccountEvent {
  int index;
  SubaccountDeleteSubAccount({required this.index});
}

final class SubaccountShowSplitField extends SubaccountEvent {}

final class SubaccountSearch extends SubaccountEvent {
  var data;
  var searchValue;
  SubaccountSearch({required this.data, required this.searchValue});
}

final class SubaccountSplittedAccountUpdate extends SubaccountEvent {
  var data;
  SubaccountSplittedAccountUpdate({required this.data});
}

final class SubaccountWalletAccountUpdate extends SubaccountEvent {
  var data;
  SubaccountWalletAccountUpdate({required this.data});
}
