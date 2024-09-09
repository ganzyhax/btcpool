part of 'subaccount_bloc.dart';

@immutable
sealed class SubaccountState {}

final class SubaccountInitial extends SubaccountState {}

final class SubaccountLoaded extends SubaccountState {
  final bool isCheck;
  final bool isLoading;
  final bool isShowAddField;
  var filteredSubAccounts;
  var accountsData;

  final List selectedSubAccounts;
  SubaccountLoaded(
      {required this.isCheck,
      required this.filteredSubAccounts,
      required this.accountsData,
      required this.isShowAddField,
      required this.selectedSubAccounts,
      required this.isLoading});
}

final class SubaccountError extends SubaccountState {
  final String message;
  SubaccountError({required this.message});
}

final class SubaccountNewError extends SubaccountState {
  final String message;
  SubaccountNewError({required this.message});
}

final class SubaccountSuccess extends SubaccountState {
  final String message;
  final String? newSubAccount;

  SubaccountSuccess({
    required this.message,
    this.newSubAccount,
  });
}

final class SubaccountNewSuccess extends SubaccountState {
  final String message;
  final String newSubAccount;

  SubaccountNewSuccess({
    required this.message,
    required this.newSubAccount,
  });
}

final class SubaccountUpdateSplittedSuccess extends SubaccountState {
  final String message;
  final String subAccount;

  SubaccountUpdateSplittedSuccess({
    required this.message,
    required this.subAccount,
  });
}
