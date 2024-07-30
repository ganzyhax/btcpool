part of 'api_bloc.dart';

@immutable
sealed class ApiState {}

final class ApiInitial extends ApiState {}

final class ApiLoaded extends ApiState {
  final data;
  bool isLoading;
  ApiLoaded({required this.data, required this.isLoading});
}
