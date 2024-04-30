part of 'workers_bloc.dart';

@immutable
sealed class WorkersEvent {}

class WorkersLoad extends WorkersEvent {}

class WorkersChangeIndex extends WorkersEvent {
  int index;
  WorkersChangeIndex({required this.index});
}
