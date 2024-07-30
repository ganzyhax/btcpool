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
  double btcPrice;
  int selectedInterval;
  DashboardLoaded(
      {required this.subAccounts,
      required this.strumUrls,
      required this.btcPrice,
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

final class DashboardCreateSubAccountModal extends DashboardState {}

final class DashboardShowingSubAccountModal extends DashboardState {}

final class DashboardInternetException extends DashboardState {}

final class DashboardShowUpdate extends DashboardState {
  final bool withSkip;
  DashboardShowUpdate({required this.withSkip});
}
