import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

import '../../../../core/config/environment_config.dart';
import '../../domain/datasources/auth_data_source.dart';
import '../models/google_sheet_response.dart';
import '../models/user_model.dart';
import 'encryption_helper.dart';

class AuthDataSourceImpl implements AuthDataSource {
  final dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
    ),
  );

  final baseUrl = EnvironmentConfig().authBaseUrl;

  @override
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    final response = await doGet(
      comando: "login",
      parametros: {"email": email, "password": password},
    );

    try {
      if (response?.data == null) {
        throw Exception('No se pudo obtener la respuesta');
      }
      final dataResponse = response!.data;
      final googleSheetResponse = GoogleSheetResponse.fromJson(dataResponse);
      if (googleSheetResponse.hasError) {
        throw Exception(googleSheetResponse.msg);
      }
      return UserModel.fromJson(googleSheetResponse.data!);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> logout() async {}

  @override
  Future<void> changePassword({
    required String newPassword,
    required String token,
  }) async {
    final response = await doGet(
      comando: "change_password",
      parametros: {"token": token, "new_password": newPassword},
    );

    try {
      if (response?.data == null) {
        throw Exception('No se pudo obtener la respuesta');
      }
      final dataResponse = response!.data;
      final googleSheetResponse = GoogleSheetResponse.fromJson(dataResponse);
      if (googleSheetResponse.hasError) {
        throw Exception(googleSheetResponse.msg);
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> recoveryPassword({required String email}) async {
    final response = await doGet(
      comando: "recovery_password",
      parametros: {"email": email},
    );

    try {
      if (response?.data == null) {
        throw Exception('No se pudo obtener la respuesta');
      }
      final dataResponse = response!.data;
      final googleSheetResponse = GoogleSheetResponse.fromJson(dataResponse);
      if (googleSheetResponse.hasError) {
        throw Exception(googleSheetResponse.msg);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<Response<dynamic>?> doGet({
    required String comando,
    Map<String, dynamic>? parametros,
  }) async {
    // Construir los parámetros de la URL
    Map<String, String> queryParameters = {
      'comando': comando,
    };

    // Determinar si necesita encriptación y procesar parámetros
    if (parametros != null && parametros.isNotEmpty) {
      final needsEncryption = EncryptionHelper().containsSensitiveData(parametros);
      final parametrosJson = jsonEncode(parametros);
      
      if (needsEncryption) {
        // Encriptar parámetros sensibles
        final encryptedParams = EncryptionHelper().simpleEncrypt(parametrosJson);
        queryParameters['parametros'] = Uri.encodeComponent(encryptedParams);
        queryParameters['encrypted'] = 'true';
      } else {
        // Enviar parámetros sin encriptar
        queryParameters['parametros'] = Uri.encodeComponent(parametrosJson);
        queryParameters['encrypted'] = 'false';
      }
    }

    // Construir la URI con parámetros de consulta
    final uri = Uri.parse(baseUrl).replace(queryParameters: queryParameters);

    Response<dynamic>? response;
    try {
      response = await dio.get(
        uri.toString(),
        options: Options(
          headers: {
            HttpHeaders.contentTypeHeader: "application/json"
          },
        ),
      );
    } on DioException catch (e) {
      /// Handle redirect with code 302
      if (e.response?.statusCode == 302) {
        final url = e.response?.headers['location']!.first;
        response = await dio.get(url!);
      } else {
        rethrow;
      }
    }
    return response;
  }
}