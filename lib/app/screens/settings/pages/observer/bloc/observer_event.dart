part of 'observer_bloc.dart';

@immutable
sealed class ObserverEvent {}

class ObserverChangeSwitchValue extends ObserverEvent {
  int index;
  ObserverChangeSwitchValue({required this.index});
}

class ObserverLoad extends ObserverEvent {}

class ObserverCreate extends ObserverEvent {
  String name;
  ObserverCreate({required this.name});
}

class ObserverChooseSubAccount extends ObserverEvent {
  List data;
  ObserverChooseSubAccount({required this.data});
}
