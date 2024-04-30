part of 'revenue_bloc.dart';

@immutable
sealed class RevenueState {}

final class RevenueInitial extends RevenueState {}

final class RevenueLoaded extends RevenueState {
  final List displayEarningsDate;
  final earningsData;
  final payoutsData;
  final List displayPayoutsDate;
  final bool isLoading;
  RevenueLoaded(
      {required this.displayEarningsDate,
      required this.displayPayoutsDate,
      required this.earningsData,
      required this.isLoading,
      required this.payoutsData});
}
