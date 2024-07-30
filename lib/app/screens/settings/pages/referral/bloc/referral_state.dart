part of 'referral_bloc.dart';

@immutable
sealed class ReferralState {}

final class ReferralInitial extends ReferralState {}

final class ReferralLoaded extends ReferralState {
  bool isStarted;
  bool isLoading;
  double selectedPoolFee;
  var referralDetail;
  var referralEarnings;
  var referralUsers;
  var referralProgram;
  ReferralLoaded(
      {required this.isStarted,
      required this.selectedPoolFee,
      required this.isLoading,
      required this.referralDetail,
      required this.referralEarnings,
      required this.referralProgram,
      required this.referralUsers});
}

final class ReferralSuccess extends ReferralState {
  final String message;
  ReferralSuccess({required this.message});
}

final class ReferralError extends ReferralState {
  final String message;
  ReferralError({required this.message});
}
