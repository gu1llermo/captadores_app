import 'dart:convert';

import '../../../../core/config/environment_config.dart';

class EncryptionHelper {
  // La misma clave secreta que en Apps Script

  static final EncryptionHelper _instance = EncryptionHelper._internal();
  factory EncryptionHelper() => _instance;
  EncryptionHelper._internal();

  final _secretKey = EnvironmentConfig().secretPassword;
  
  /// Encripta usando XOR y codifica en base64
   String simpleEncrypt(String text) {
    final encrypted = _xorEncryptDecrypt(text, _secretKey);
    return base64Encode(utf8.encode(encrypted));
  }
  
  /// Decodifica de base64 y desencripta usando XOR
   String simpleDecrypt(String encryptedText) {
    final decoded = utf8.decode(base64Decode(encryptedText));
    return _xorEncryptDecrypt(decoded, _secretKey);
  }
  
  /// Implementación XOR para encriptación/desencriptación
   String _xorEncryptDecrypt(String text, String key) {
    final result = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      final textChar = text.codeUnitAt(i);
      final keyChar = key.codeUnitAt(i % key.length);
      result.writeCharCode(textChar ^ keyChar);
    }
    return result.toString();
  }
  
  /// Determina si los parámetros contienen información sensible
   bool containsSensitiveData(Map<String, dynamic> parametros) {
    const sensitiveKeys = ['password', 'token', 'new_password', 'email'];
    return parametros.keys.any((key) => 
      sensitiveKeys.any((sensitive) => 
        key.toLowerCase().contains(sensitive.toLowerCase())
      )
    );
  }
}