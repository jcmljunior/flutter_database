import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  final Future<SharedPreferences> _sharedPreferencesService =
      SharedPreferences.getInstance();

  Future<void> setInt(String key, int value) async {
    return await _sharedPreferencesService.then((SharedPreferences prefs) {
      prefs.setInt(key, value);
    });
  }

  Future<int?> getInt(String key) async {
    return await _sharedPreferencesService.then((SharedPreferences prefs) {
      return prefs.getInt(key);
    });
  }

  Future<void> setBool(String key, bool value) async {
    return await _sharedPreferencesService.then((SharedPreferences prefs) {
      prefs.setBool(key, value);
    });
  }

  Future<bool?> getBool(String key) async {
    return await _sharedPreferencesService.then((SharedPreferences prefs) {
      return prefs.getBool(key);
    });
  }

  Future<void> setString(String key, String value) async {
    return await _sharedPreferencesService.then((SharedPreferences prefs) {
      prefs.setString(key, value);
    });
  }

  Future<String?> getString(String key) async {
    return await _sharedPreferencesService.then((SharedPreferences prefs) {
      return prefs.getString(key);
    });
  }

  Future<void> remove(String key) async {
    return await _sharedPreferencesService.then((SharedPreferences prefs) {
      prefs.remove(key);
    });
  }

  Future<void> clear() async {
    return await _sharedPreferencesService.then((SharedPreferences prefs) {
      prefs.clear();
    });
  }

  Future<bool> containsKey(String key) async {
    return await _sharedPreferencesService.then((SharedPreferences prefs) {
      return prefs.containsKey(key);
    });
  }
}
