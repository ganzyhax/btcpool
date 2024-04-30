part of 'api_bloc.dart';

@immutable
sealed class ApiState {}

final class ApiInitial extends ApiState {}

final class ApiLoaded extends ApiState {
  final data;
  ApiLoaded({required this.data});
}
