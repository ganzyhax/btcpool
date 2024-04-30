part of 'dashboard_bloc.dart';

@immutable
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

class DashboardUpdateSubaccounts extends DashboardEvent {}
