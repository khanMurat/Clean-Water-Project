import 'package:final_project_ala/core/constants/enum/cache_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheManager {
  SharedPreferences? _preferences;

  CacheManager._init() {
    SharedPreferences.getInstance().then((value) {
      _preferences = value;
    });
  }

  static final CacheManager _instance = CacheManager._init();
  static CacheManager get instance => _instance;

  static Future preferencesInit() async {
    _instance._preferences ??= await SharedPreferences.getInstance();
  }

  Future<void> saveString(CacheKeys key, String value) async {
    await _preferences?.setString(key.toString(), value);
  }

  String getString(CacheKeys key) {
    return _preferences?.getString(key.toString()) ?? '';
  }

  Future<void> clearAll() async {
    await _preferences?.clear();
  }

  Future<void> saveBool(CacheKeys key, bool value) async {
    await _preferences!.setBool(key.toString(), value);
  }

  bool? getBool(CacheKeys key) {
    return _preferences!.getBool(CacheKeys.rememberMe.toString());
  }
}
