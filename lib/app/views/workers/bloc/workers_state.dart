part of 'workers_bloc.dart';

@immutable
sealed class WorkersState {}

final class WorkersInitial extends WorkersState {}

final class WorkersLoaded extends WorkersState {
  int selectedTab = 0;
  final tabs;
  bool isLoading;
  final sortingIndex;
  final dashboardData;
  final String selectedSubAccountCurrency;
  WorkersLoaded(
      {required this.selectedTab,
      required this.selectedSubAccountCurrency,
      required this.tabs,
      required this.sortingIndex,
      required this.isLoading,
      required this.dashboardData});
}
