import 'main.dart';

class Constant {
  static String getLanguage() {
    return sharedPref.getString('Language') ?? 'en'; // Ensure correct key
  }
}
