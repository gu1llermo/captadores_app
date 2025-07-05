
import 'package:captadores_app/core/extensions/strings_utils_extension.dart';

class UserEntity {
  final int id;
  final String email;
  final String nombreAsesor;
  final String codigoAsesor;
  // final String apiBaseUrl;
  final String token;

  const UserEntity({
    required this.id,
    required this.email,
    required this.nombreAsesor,
    required this.codigoAsesor,
    // required this.apiBaseUrl,
    required this.token,
  });

  // get iniciales del usuario
  String get initials => nombreAsesor.getInitials();
  String get idNewRegistro {
    final timeStamp = DateTime.now().millisecondsSinceEpoch;
    return '$codigoAsesor.$timeStamp';
  }

  String get sheetName => '$codigoAsesor-$token';
  String get dataBaseUrl => 'api de google';
  

}