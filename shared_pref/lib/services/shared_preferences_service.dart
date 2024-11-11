import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static Future<SharedPreferences> get _prefs async =>
      await SharedPreferences.getInstance();

  static Future<bool> getIsDarkMode() async {
    final prefs = await _prefs;
    return prefs.getBool('isDarkMode') ?? false;
  }

  static Future<void> setIsDarkMode(bool isDarkMode) async {
    final prefs = await _prefs;
    await prefs.setBool('isDarkMode', isDarkMode);
  }

  static Future<void> savePreferences({
    required int storedInt,
    required double storedDouble,
    required bool storedBool,
    required String storedString,
    required List<String> storedStringList,
  }) async {
    final prefs = await _prefs;
    await prefs.setInt('storedInt', storedInt);
    await prefs.setDouble('storedDouble', storedDouble);
    await prefs.setBool('storedBool', storedBool);
    await prefs.setString('storedString', storedString);
    await prefs.setStringList('storedStringList', storedStringList);
  }

  static Future<Map<String, dynamic>> loadPreferences() async {
    final prefs = await _prefs;
    return {
      'storedInt': prefs.getInt('storedInt') ?? 0,
      'storedDouble': prefs.getDouble('storedDouble') ?? 0.0,
      'storedBool': prefs.getBool('storedBool') ?? false,
      'storedString': prefs.getString('storedString') ?? '',
      'storedStringList': prefs.getStringList('storedStringList') ?? [],
    };
  }

  static Future<void> clearPreferences() async {
    final prefs = await _prefs;
    await prefs.clear();
  }
}
