import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';

class DeviceLocalAuth {
  final LocalAuthentication _auth = LocalAuthentication();

  Future<bool> isBiometricAvailable() async {
    final List<BiometricType> availableBiometrics =
        await _auth.getAvailableBiometrics();
    return availableBiometrics.isNotEmpty;
  }

  Future<bool> authenticateUser({bool verify = true}) async {
    try {
      return await _auth.authenticate(
          localizedReason: "lock_hint_text".tr,
          options: const AuthenticationOptions(
              stickyAuth: true, useErrorDialogs: false),
          authMessages: <AuthMessages>[
            AndroidAuthMessages(
              signInTitle: "unlock_app".tr,
              biometricHint: '',
            ),
          ]);

      // return authorized;
    } catch (e) {
      return false;
    }
  }
}

final deviceLocalAuth = DeviceLocalAuth();
