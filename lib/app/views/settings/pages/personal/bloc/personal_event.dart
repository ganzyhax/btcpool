part of 'personal_bloc.dart';

@immutable
sealed class PersonalEvent {}

final class PersonalLoad extends PersonalEvent {}

final class PersonalChange extends PersonalEvent {
  final String username;
  final String email;
  final String currentPassword;
  final String newPassword;
  final String repeatPassword;
  PersonalChange(
      {required this.currentPassword,
      required this.email,
      required this.newPassword,
      required this.repeatPassword,
      required this.username});
}
