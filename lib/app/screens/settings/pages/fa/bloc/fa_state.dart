part of 'fa_bloc.dart';

@immutable
sealed class FaState {}

final class FaInitial extends FaState {}

final class FaLoaded extends FaState {
  final String svgImage;
  final String secretCode;
  final bool isTurnedFa;
  FaLoaded(
      {required this.secretCode,
      required this.svgImage,
      required this.isTurnedFa});
}
