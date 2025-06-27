import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

// import '../constants/app_constants.dart';

const authBaseUrlKey = 'AUTH_BASE_URL_KEY';
const urlServerKey = 'github.io';

class EnvironmentConfig {
  
  
  static final EnvironmentConfig _instance = EnvironmentConfig._internal();
  factory EnvironmentConfig() => _instance;
  EnvironmentConfig._internal();

  static bool get isInUrlServer {
    if (kIsWeb) {
      try {
        final host = Uri.base.host;
        return host.contains(urlServerKey);
      } catch (e) {
        return false;
      }
    }
    return false;
  }

  // Mapa constante para valores en GitHub Pages
  static const _urlServerValues = {
    authBaseUrlKey: String.fromEnvironment(authBaseUrlKey),
  };

// ésta solución es más elegante, sin embargo no la uso porque dotEnv tiene problemas
// ya que el key tiene que ser constante y no funciona cuando se pasa así como variable
  // static String _getValue(String key) {
  //   return isInUrlServer ? String.fromEnvironment(key) : dotenv.env[key] ?? '';
  // }

  String get authBaseUrl => _getRequiredValue(authBaseUrlKey);

  static String _getValue(String key) {
    if (isInUrlServer) {
      return _urlServerValues[key] ?? '';
    }
    final value = dotenv.env[key];
    return value ?? '';
  }

  String _getRequiredValue(String key) {
    final value = _getValue(key);
    if (value.isEmpty) throw Exception('$key es requerido');
    return value;
  }

  static Future<void> initialize() async {
    if (!isInUrlServer) {
      await dotenv.load();
    }
  }
}
