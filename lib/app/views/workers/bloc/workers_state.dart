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
  WorkersLoaded(
      {required this.selectedTab,
      required this.tabs,
      required this.sortingIndex,
      required this.isLoading,
      required this.dashboardData});
}
