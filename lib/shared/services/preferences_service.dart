import 'package:shared_preferences/shared_preferences.dart';

/// Typed wrapper around [SharedPreferences] for non-sensitive local settings.
class PreferencesService {
  const PreferencesService(this._preferences);

  final SharedPreferences _preferences;

  bool containsKey(String key) => _preferences.containsKey(key);

  Set<String> getKeys() => _preferences.getKeys();

  Object? get(String key) => _preferences.get(key);

  String? getString(String key) => _preferences.getString(key);

  int? getInt(String key) => _preferences.getInt(key);

  double? getDouble(String key) => _preferences.getDouble(key);

  bool? getBool(String key) => _preferences.getBool(key);

  List<String>? getStringList(String key) => _preferences.getStringList(key);

  Future<bool> setString(String key, String value) {
    return _preferences.setString(key, value);
  }

  Future<bool> setInt(String key, int value) {
    return _preferences.setInt(key, value);
  }

  Future<bool> setDouble(String key, double value) {
    return _preferences.setDouble(key, value);
  }

  Future<bool> setBool(String key, bool value) {
    return _preferences.setBool(key, value);
  }

  Future<bool> setStringList(String key, List<String> value) {
    return _preferences.setStringList(key, value);
  }

  Future<bool> remove(String key) => _preferences.remove(key);

  Future<bool> clear() => _preferences.clear();
}
