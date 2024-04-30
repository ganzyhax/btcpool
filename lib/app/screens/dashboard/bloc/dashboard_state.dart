part of 'dashboard_bloc.dart';

@immutable
sealed class DashboardState {}

final class DashboardInitial extends DashboardState {}

final class DashboardLoaded extends DashboardState {
  var subAccounts;
  var dashboardData;
  int selectedSubAccout;
  var strumUrls;
  var hashrates;
  int selectedInterval;
  DashboardLoaded(
      {required this.subAccounts,
      required this.strumUrls,
      required this.selectedInterval,
      required this.selectedSubAccout,
      required this.dashboardData,
      required this.hashrates});
}

final class DashboardLoadingSubAccount extends DashboardState {
  int selectedSubAccout;
  var subAccounts;
  DashboardLoadingSubAccount(
      {required this.selectedSubAccout, required this.subAccounts});
}
