import 'package:get_storage/get_storage.dart';

class CacheService {

  final GetStorage _box = GetStorage();

  /// ===============================
  /// SAVE CACHE
  /// ===============================

  Future<void> saveCache(String key, dynamic value) async {
    await _box.write(key, value);
  }

  /// ===============================
  /// GET CACHE
  /// ===============================

  T? getCache<T>(String key) {
    return _box.read<T>(key);
  }

  /// ===============================
  /// REMOVE CACHE
  /// ===============================

  Future<void> removeCache(String key) async {
    await _box.remove(key);
  }

  /// ===============================
  /// CLEAR ALL CACHE
  /// ===============================

  Future<void> clearAll() async {
    await _box.erase();
  }
}