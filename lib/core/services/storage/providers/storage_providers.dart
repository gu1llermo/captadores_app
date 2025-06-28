import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../key_value_storage_service.dart';
import '../key_value_storage_service_impl.dart';

part 'storage_providers.g.dart';

@Riverpod(dependencies: [])
KeyValueStorageService keyValueStorageService(Ref ref) {
  return KeyValueStorageServiceImpl();
}

// Provider for KeyValueStorageService
// final keyValueStorageServiceProvider = Provider<KeyValueStorageService>((ref) {
//   return KeyValueStorageServiceImpl(
//     asyncPrefs: SharedPreferencesAsync(),
//     secureStorage: const FlutterSecureStorage(),
//   );
// });
