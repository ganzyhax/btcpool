part of 'workers_bloc.dart';

@immutable
sealed class WorkersState {}

final class WorkersInitial extends WorkersState {}

final class WorkersLoaded extends WorkersState {
  int selectedTab = 0;
  WorkersLoaded({required this.selectedTab});
}
