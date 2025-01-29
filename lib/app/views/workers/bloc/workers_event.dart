part of 'workers_bloc.dart';

@immutable
sealed class WorkersEvent {}

class WorkersLoad extends WorkersEvent {}

class WorkersChangeIndex extends WorkersEvent {
  int index;
  WorkersChangeIndex({required this.index});
}

class WorkersSubAccountIndexChange extends WorkersEvent {
  int index;
  WorkersSubAccountIndexChange({required this.index});
}

class WorkersClear extends WorkersEvent {}

class WorkersSubaccountUpdate extends WorkersEvent {}

class WorkersRefresh extends WorkersEvent {}

class WorkersSearch extends WorkersEvent {
  String value;
  WorkersSearch({required this.value});
}

class WorkersSortByHour extends WorkersEvent {}

class WorkersSortByDay extends WorkersEvent {}
