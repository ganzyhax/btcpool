part of 'api_bloc.dart';

@immutable
sealed class ApiEvent {}

final class ApiLoad extends ApiEvent {}

final class ApiCreate extends ApiEvent {}

final class ApiDelete extends ApiEvent {
  final String apiKey;
  ApiDelete({required this.apiKey});
}

final class ApiSubAccountChange extends ApiEvent {
  final int index;
  ApiSubAccountChange({required this.index});
}

final class ApiSubAccountUpdate extends ApiEvent {}
