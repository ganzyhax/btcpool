part of 'notification_bloc.dart';

@immutable
sealed class NotificationState {}

final class NotificationInitial extends NotificationState {}

final class NotificationLoaded extends NotificationState {
  final data;
  NotificationLoaded({required this.data});
}
