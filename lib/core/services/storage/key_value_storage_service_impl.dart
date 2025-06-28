import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'key_value_storage_service.dart';

class KeyValueStorageServiceImpl extends KeyValueStorageService {
  final SharedPreferencesAsync _asyncPrefs;
  final FlutterSecureStorage _secureStorage;

  KeyValueStorageServiceImpl({
    SharedPreferencesAsync? asyncPrefs,
    FlutterSecureStorage? secureStorage,
  })  : _asyncPrefs = asyncPrefs ?? SharedPreferencesAsync(),
        _secureStorage = secureStorage ?? const FlutterSecureStorage();

  @override
  Future<T?> getValue<T>(String key) async {
    try {
      if (key.startsWith('_secure')) {
        final value = await _secureStorage.read(key: key);
        if (value == null) return null;

        switch (T) {
          case const (String):
            return value as T;
          case const (int):
            return int.tryParse(value) as T?;
          case const (bool):
            return (value.toLowerCase() == 'true') as T?;
          default:
            throw UnimplementedError(
                'Secure get not implemented for type ${T.runtimeType}');
        }
      } else {
        switch (T) {
          case const (int):
            return await _asyncPrefs.getInt(key) as T?;
          case const (String):
            return await _asyncPrefs.getString(key) as T?;
          case const (bool):
            return await _asyncPrefs.getBool(key) as T?;
          case const (List<String>):
            return await _asyncPrefs.getStringList(key) as T?;
          case const (double):
            return await _asyncPrefs.getDouble(key) as T?;
          default:
            throw UnimplementedError(
                'Get not implemented for type ${T.runtimeType}');
        }
      }
    } catch (e) {
      return null;
    }
  }

  @override
  Future<bool> removeKey(String key) async {
    if (key.startsWith('_secure')) {
      await _secureStorage.delete(key: key);
      return await getValue(key) == null;
    } else {
      await _asyncPrefs.remove(key);
      return await getValue(key) == null;
    }
  }

  @override
  Future<void> setKeyValue<T>(String key, T value) async {
    if (key.startsWith('_secure')) {
      switch (T) {
        case const (String):
          await _secureStorage.write(key: key, value: value as String);
          // break;
        case const (int):
          await _secureStorage.write(key: key, value: value.toString());
          // break;
        case const (bool):
          await _secureStorage.write(key: key, value: value.toString());
          // break;
        default:
          throw UnimplementedError(
              'Secure set not implemented for type ${T.runtimeType}');
      }
    } else {
      switch (T) {
        case const (int):
          await _asyncPrefs.setInt(key, value as int);
          break;
        case const (String):
          await _asyncPrefs.setString(key, value as String);
          break;
        case const (bool):
          await _asyncPrefs.setBool(key, value as bool);
          break;
        case const (List<String>):
          await _asyncPrefs.setStringList(key, value as List<String>);
          break;
        case const (double):
          await _asyncPrefs.setDouble(key, value as double);
          break;
        default:
          throw UnimplementedError(
              'Set not implemented for type ${T.runtimeType}');
      }
    }
  }
}
