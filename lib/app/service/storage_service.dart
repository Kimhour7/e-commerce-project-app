import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class StorageService extends GetxService {
  static final FlutterSecureStorage _storage = FlutterSecureStorage();

  static Future<void> write({
    required String key,
    required String value,
  }) async {
    await _storage.write(key: key, value: value);
  }

  static Future<String?> read({required String key}) async {
    return await _storage.read(key: key);
  }

  static Future<void> delete({required String key}) async {
    await _storage.delete(key: key);
  }

  static Future<Map<String, String>> readAllValue() async {
    Map<String, String> allValues = await _storage.readAll();
    print(allValues);
    return allValues;
  }
}
