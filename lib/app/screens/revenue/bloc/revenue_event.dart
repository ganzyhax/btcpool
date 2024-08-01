part of 'revenue_bloc.dart';

@immutable
sealed class RevenueEvent {}

class RevenueLoad extends RevenueEvent {}

class RevenueSetEarningsPickedDates extends RevenueEvent {
  final List data;
  RevenueSetEarningsPickedDates({required this.data});
}

class RevenueSetPayoutsPickedDates extends RevenueEvent {
  final List data;
  RevenueSetPayoutsPickedDates({required this.data});
}

class RevenueSubAccountIndexChange extends RevenueEvent {
  int index;
  RevenueSubAccountIndexChange({required this.index});
}

class RevenueLoadPayouts extends RevenueEvent {}

class RevenueLoadEarnings extends RevenueEvent {}

class RevenueClear extends RevenueEvent {}

class RevenueUpdateSubaccount extends RevenueEvent {}
