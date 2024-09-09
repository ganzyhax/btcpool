part of 'signup_bloc.dart';

@immutable
sealed class SignupEvent {}

class SignupRegister extends SignupEvent {
  final String username;
  final String email;
  final String password;
  final String organization_bin;
  final String phone;
  SignupRegister(
      {required this.username,
      required this.password,
      required this.email,
      required this.organization_bin,
      required this.phone});
}

class SignupLoad extends SignupEvent {}

class SignupFindBin extends SignupEvent {
  final String value;
  SignupFindBin({required this.value});
}

class SignupVerify extends SignupEvent {
  final String value;
  final String email;
  final bool isReVerify;
  SignupVerify(
      {required this.value, required this.email, required this.isReVerify});
}

class SignupSendCode extends SignupEvent {
  String email;
  SignupSendCode({required this.email});
}
