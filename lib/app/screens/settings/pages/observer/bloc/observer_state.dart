part of 'observer_bloc.dart';

@immutable
sealed class ObserverState {}

final class ObserverInitial extends ObserverState {}

final class ObserverLoaded extends ObserverState {
  final List<bool> switches;
  final List observerLinks;
  ObserverLoaded({required this.switches, required this.observerLinks});
}

final class ObserverError extends ObserverState {
  final String message;
  ObserverError({required this.message});
}

final class ObserverSuccess extends ObserverState {
  final String message;
  ObserverSuccess({required this.message});
}
