import 'package:btcpool_app/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:local_auth/local_auth.dart';

class LocalAuth {
  final LocalAuthentication _localAuth = LocalAuthentication();

  Future<bool> authenticate() async {
    final bool canAuthenticateWithBiometrics =
        await _localAuth.canCheckBiometrics;
    if (canAuthenticateWithBiometrics) {
      try {
        bool isAuthenticated = await _localAuth.authenticate(
            localizedReason: LocaleKeys.auth_with_faceid.tr(),
            options: AuthenticationOptions(biometricOnly: true));
        return isAuthenticated;
      } catch (e) {
        return false;
      }
    } else {
      try {
        bool isAuthenticated = await _localAuth.authenticate(
            localizedReason: LocaleKeys.auth_with_faceid.tr(),
            options: AuthenticationOptions(biometricOnly: false));
        return isAuthenticated;
      } catch (e) {
        return false;
      }
    }
  }
}
