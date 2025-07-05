import 'dart:convert';

import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.email,
    required super.nombreAsesor,
    required super.codigoAsesor,
    // required super.apiBaseUrl,
    required super.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'],
      nombreAsesor: json['nombre_asesor'],
      codigoAsesor: json['codigo_asesor'],
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'nombre_asesor': nombreAsesor,
      'codigo_asesor': codigoAsesor,
      // 'api_base_url': apiBaseUrl,
      'token': token,
    };
  }

  factory UserModel.fromString(String userString) {
    final json = jsonDecode(userString) as Map<String, dynamic>;
    return UserModel.fromJson(json);
  }

  @override
  String toString() => jsonEncode(toJson());
}
