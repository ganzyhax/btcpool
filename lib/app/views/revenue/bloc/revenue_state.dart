part of 'revenue_bloc.dart';

@immutable
sealed class RevenueState {}

final class RevenueInitial extends RevenueState {}

final class RevenueLoaded extends RevenueState {
  final List displayEarningsDate;
  final earningsData;
  final payoutsData;
  final List displayPayoutsDate;
  final bool isRLoading;
  final bool isELoading;
  RevenueLoaded(
      {required this.displayEarningsDate,
      required this.displayPayoutsDate,
      required this.earningsData,
      required this.isRLoading,
      required this.isELoading,
      required this.payoutsData});
}

final class Revenue extends RevenueState {}
