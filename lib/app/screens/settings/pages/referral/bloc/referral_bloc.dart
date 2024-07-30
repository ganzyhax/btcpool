import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:btcpool_app/api/api.dart';

part 'referral_event.dart';
part 'referral_state.dart';

class ReferralBloc extends Bloc<ReferralEvent, ReferralState> {
  ReferralBloc() : super(ReferralInitial()) {
    bool isStarted = false;
    bool isLoading = false;
    var referralDetail;
    var referralEarnings;
    var referralUsers;
    var referralProgram;
    double selectedPoolFee = 0.8;
    on<ReferralEvent>((event, emit) async {
      if (event is ReferralLoad) {
        var request = await ApiClient.get('api/v1/referral_program/all/');
        if (request.length != 0) {
          isStarted = true;
          referralDetail =
              await ApiClient.get('api/v1/referral_program/issuer_detail/');
          referralEarnings = await ApiClient.get(
              'api/v1/referral_program/issuer_referral_earnings/');
          referralUsers = await ApiClient.get(
              'api/v1/referral_program/issuer_referral_users/');
          referralProgram = await ApiClient.get('api/v1/referral_program/all/');
        }
        emit(ReferralLoaded(
            isStarted: isStarted,
            selectedPoolFee: selectedPoolFee,
            isLoading: isLoading,
            referralDetail: referralDetail,
            referralEarnings: referralEarnings,
            referralProgram: referralProgram,
            referralUsers: referralUsers));
      }
      if (event is ReferralCreate) {
        isLoading = true;
        emit(ReferralLoaded(
            referralProgram: referralProgram,
            isStarted: isStarted,
            isLoading: isLoading,
            referralDetail: referralDetail,
            selectedPoolFee: selectedPoolFee,
            referralEarnings: referralEarnings,
            referralUsers: referralUsers));
        var request = await ApiClient.post('api/v1/referral_program/create/',
            {'wallet_address': event.walletAddress});
        isLoading = false;
        if (request.containsKey('title')) {
          emit(ReferralError(message: request['title']));
          emit(ReferralLoaded(
              isStarted: isStarted,
              isLoading: isLoading,
              selectedPoolFee: selectedPoolFee,
              referralProgram: referralProgram,
              referralDetail: referralDetail,
              referralEarnings: referralEarnings,
              referralUsers: referralUsers));
        } else {
          emit(ReferralSuccess(message: 'Created successfully!'));
          add(ReferralLoad());
        }
      }
      if (event is ReferralSelectPoolFee) {
        selectedPoolFee = event.value;
        emit(ReferralLoaded(
            referralProgram: referralProgram,
            isStarted: isStarted,
            isLoading: isLoading,
            referralDetail: referralDetail,
            selectedPoolFee: selectedPoolFee,
            referralEarnings: referralEarnings,
            referralUsers: referralUsers));
      }
      if (event is ReferralGenerateLink) {
        var data = {
          "pool_fee": selectedPoolFee,
          "wallet_address": event.wallet,
        };
        var res = await ApiClient.post('api/v1/referral_program/create/', data);
        if (res.containsKey('title')) {
          emit(ReferralError(message: res['title']));
          emit(ReferralLoaded(
              isStarted: isStarted,
              isLoading: isLoading,
              selectedPoolFee: selectedPoolFee,
              referralProgram: referralProgram,
              referralDetail: referralDetail,
              referralEarnings: referralEarnings,
              referralUsers: referralUsers));
        } else {
          emit(ReferralSuccess(message: 'Created successfully!'));
          add(ReferralLoad());
        }
      }
    });
  }
}
