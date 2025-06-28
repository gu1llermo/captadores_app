import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';


import '../services/services.dart';

part 'theme_provider.g.dart';

@Riverpod(dependencies: [keyValueStorageService])
class ThemeModeNotifier extends _$ThemeModeNotifier {
  static const String _key = 'theme_mode';

  @override
  ThemeMode build() => ThemeMode.system;

  Future<void> setThemeMode(ThemeMode mode) async {
    final prefs = ref.read(keyValueStorageServiceProvider);
    await prefs.setKeyValue(_key, mode.toString());
    state = mode;
  }

  Future<void> loadThemeMode() async {
    final prefs = ref.read(keyValueStorageServiceProvider);
    final savedMode = await prefs.getValue(_key);
    if (savedMode != null) {
      state = ThemeMode.values.firstWhere(
        (mode) => mode.toString() == savedMode,
        orElse: () => ThemeMode.system,
      );
    }
  }
}
    