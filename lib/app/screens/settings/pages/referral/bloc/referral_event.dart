part of 'referral_bloc.dart';

@immutable
sealed class ReferralEvent {}

final class ReferralLoad extends ReferralEvent {}

final class ReferralCreate extends ReferralEvent {
  String walletAddress;
  ReferralCreate({required this.walletAddress});
}

final class ReferralSelectPoolFee extends ReferralEvent {
  double value;
  ReferralSelectPoolFee({required this.value});
}

final class ReferralGenerateLink extends ReferralEvent {
  String wallet;
  ReferralGenerateLink({required this.wallet});
}
