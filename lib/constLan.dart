import 'main.dart';

class Constant {
  static String getLanguage() {
    return sharedPref.getString('Language') ?? 'en'; // Ensure correct key
  }

  static bool fingerPrintValue() {
    return sharedPref.getBool('fingerprint') ?? false; // Default to false
  }
}
