import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static LocalStorage instance = LocalStorage();
  Future saveData(String key, String json) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, json);
  }

  Future<String?> getMonitoring() async {
    final prefs = await SharedPreferences.getInstance();
    final datane = prefs.getString('monitoring');
    return datane;
  }
}
