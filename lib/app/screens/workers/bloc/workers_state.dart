part of 'workers_bloc.dart';

@immutable
sealed class WorkersState {}

final class WorkersInitial extends WorkersState {}

final class WorkersLoaded extends WorkersState {
  int selectedTab = 0;
  final tabs;
  bool isLoading;
  WorkersLoaded(
      {required this.selectedTab, required this.tabs, required this.isLoading});
}
