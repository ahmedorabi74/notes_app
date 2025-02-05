import 'package:local_auth/local_auth.dart';

class LocalAuthService {
  final LocalAuthentication _localAuth = LocalAuthentication();

  /// Check if biometric authentication is available
  Future<bool> isBiometricAvailable() async {
    try {
      return await _localAuth.canCheckBiometrics || await _localAuth.isDeviceSupported();
    } catch (e) {
      return false;
    }
  }

  /// Get available biometric types (Fingerprint, Face ID, etc.)
  Future<List<BiometricType>> getAvailableBiometrics() async {
    try {
      return await _localAuth.getAvailableBiometrics();
    } catch (e) {
      return [];
    }
  }

  /// Authenticate the user using biometrics
  Future<bool> authenticate() async {
    try {
      bool isAuthenticated = await _localAuth.authenticate(
        localizedReason: "Authenticate to proceed",
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: false,
        ),
      );
      return isAuthenticated;
    } catch (e) {
      return false;
    }
  }
}
