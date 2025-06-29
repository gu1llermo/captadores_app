import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import '../../../../core/config/environment_config.dart';
import '../../domain/datasources/auth_data_source.dart';
import '../models/google_sheet_response.dart';
import '../models/user_model.dart';

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
    final response = await doPost({
      "comando": "login",
      "parametros": {"email": email, "password": password},
    });

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
    final response = await doPost({
      "comando": "change_password",
      "parametros": {"token": token, "new_password": newPassword},
    });

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
    final response = await doPost({
      "comando": "recovery_password",
      "parametros": {"email": email},
    });

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

  Future<Response<dynamic>?> doPost(Map<String, dynamic> body) async {
    Response<dynamic>? response;

    try {
      // Convertir el body a JSON string
      final bodyJson = jsonEncode(body);
      
      // Crear FormData para evitar preflight CORS
      final formData = FormData.fromMap({
        'data': bodyJson,
      });

      response = await dio.post(
        baseUrl,
        options: Options(
          headers: {
            // NO incluir Content-Type, Dio lo maneja automáticamente para FormData
            'Accept': 'application/json',
          },
          validateStatus: (status) {
            return status! < 500;
          },
        ),
        data: formData, // Usar FormData en lugar de JSON directo
      );
    } on DioException catch (e) {
      print('Error en petición: ${e.message}');
      if (e.response != null) {
        print('Status code: ${e.response?.statusCode}');
        print('Response data: ${e.response?.data}');
        
        if (e.response?.statusCode == 403 || e.response?.statusCode == 401) {
          print('Posible problema de CORS o permisos en Apps Script');
        }
      }
      rethrow;
    }

    return response;
  }
}