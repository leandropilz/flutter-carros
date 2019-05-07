import 'package:shared_preferences/shared_preferences.dart';

class Prefs {
  static Future<bool> getBool(String key) async {
    return SharedPreferences.getInstance().then((prefs) {
      return prefs.getBool(key) ?? false;
    });
  }

  static void setBool(String key, bool value) async {
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool(key, value);
    });
  }

  static Future<int> getInt(String key) async {
    return SharedPreferences.getInstance().then((prefs) {
      return prefs.getInt(key) ?? 0;
    });
  }

  static void setInt(String key, int value) async {
    SharedPreferences.getInstance().then((prefs) {
      prefs.setInt(key, value);
    });
  }

  static Future<String> getString(String key) async {
    return SharedPreferences.getInstance().then((prefs) {
      return prefs.getInt(key) ?? "";
    });
  }

  static void setString(String key, String value) async {
    SharedPreferences.getInstance().then((prefs) {
      prefs.setString(key, value);
    });
  }
}
