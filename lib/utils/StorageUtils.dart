import 'package:shared_preferences/shared_preferences.dart';

class StorageUtils {
  static const String CONFIGURATION_KEY = "configuration";

  static Future<SharedPreferences> _getInstance() async {
    return await SharedPreferences.getInstance();
  }

  static Future<void> writeString(String key, String value) async {
    SharedPreferences sharedPreferences = await _getInstance();
    await sharedPreferences.setString(key, value);
  }

  static Future<String> readString(String key) async {
    SharedPreferences sharedPreferences = await _getInstance();
    return sharedPreferences.getString(key);
  }
}
