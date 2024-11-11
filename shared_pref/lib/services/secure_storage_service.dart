import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  static const _storage = FlutterSecureStorage();

  static Future<void> saveSecureData(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  static Future<String?> getSecureData(String key) async {
    return await _storage.read(key: key);
  }

  static Future<void> saveInt(String key, int value) async {
    await _storage.write(key: key, value: value.toString());
  }

  static Future<int?> getInt(String key) async {
    final value = await _storage.read(key: key);
    return value != null ? int.tryParse(value) : null;
  }

  static Future<void> saveDouble(String key, double value) async {
    await _storage.write(key: key, value: value.toString());
  }

  static Future<double?> getDouble(String key) async {
    final value = await _storage.read(key: key);
    return value != null ? double.tryParse(value) : null;
  }

  static Future<void> saveBool(String key, bool value) async {
    await _storage.write(key: key, value: value.toString());
  }

  static Future<bool?> getBool(String key) async {
    final value = await _storage.read(key: key);
    return value == 'true';
  }

  static Future<void> saveStringList(String key, List<String> value) async {
    await _storage.write(key: key, value: value.join(','));
  }

  static Future<List<String>> getStringList(String key) async {
    final value = await _storage.read(key: key);
    return value != null ? value.split(',') : [];
  }

  static Future<void> clearSecureData() async {
    await _storage.deleteAll();
  }
}
