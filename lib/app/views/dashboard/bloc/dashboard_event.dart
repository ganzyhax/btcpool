part of 'dashboard_bloc.dart';

sealed class DashboardEvent {}

class DashboardLoad extends DashboardEvent {}

class DashboardTest extends DashboardEvent {}

class DashboardChooseSubAccount extends DashboardEvent {
  int index;
  DashboardChooseSubAccount({required this.index});
}

class DashboardChooseInterval extends DashboardEvent {
  int index;
  DashboardChooseInterval({required this.index});
}

class DashboardLoadCache extends DashboardEvent {}

class DashboardUpdateSubaccounts extends DashboardEvent {
  String subAccount;
  DashboardUpdateSubaccounts({required this.subAccount});
}

class DashboardSubAccountCreateShowModal extends DashboardEvent {}

class DashboardClear extends DashboardEvent {}

class DashboardRefresh extends DashboardEvent {}

class DashboardShowEvent extends DashboardEvent {}
