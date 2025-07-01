import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:captadores_app/features/registros/domain/entities/registro_entity.dart';

import '../../../authentication/data/models/google_sheet_response.dart';
import '../../domain/datasources/registros_data_source.dart';
import '../models/registro_model.dart';

class RegistrosDataSourceImpl extends RegistrosDataSource {
  final dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
    ),
  );

  @override
  Future<List<String>> getAbogadosName({required String apiBaseUrl}) async {
    // TODO: implement getAbogadosName
    throw UnimplementedError();
  }

  @override
  Future<List<RegistroEntity>> getAllRecords({
    required String sheetName,
    required String apiBaseUrl,
  }) async {
    final response = await doRequest({
      "comando": "get_all_records",
      "parametros": {"sheet_name": sheetName},
    }, apiBaseUrl);

    try {
      if (response?.data == null) {
        throw Exception('No se pudo obtener la respuesta');
      }

      final dataResponse = response!.data;
      final googleSheetResponse = GoogleSheetResponse.fromJson(dataResponse);

      if (googleSheetResponse.hasError) {
        throw Exception(googleSheetResponse.msg);
      }

      // googleSheetResponse.data! es una lista de RegistroModel
      if (googleSheetResponse.data == null) return [];
      
      final listResponse = googleSheetResponse.data!['records'] as List;

      final records =
          listResponse
              .map((record) => RegistroModel.fromJson(record))
              .toList();
      return records;
      
    } catch (e) {
      rethrow;
    }
  }

  Future<Response<dynamic>?> doRequest(Map<String, dynamic> body, String apiBaseUrl) async {
    Response<dynamic>? response;

    try {
      // Convertir el body a JSON string y codificarlo para URL
      final bodyJson = jsonEncode(body);
      final encodedData = Uri.encodeComponent(bodyJson);

      // Construir URL con parámetros
      final url = '$apiBaseUrl?data=$encodedData';

      response = await dio.get(
        url,
        options: Options(
          headers: {'Accept': 'application/json'},
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );
    } on DioException catch (e) {
      print('Error en petición: ${e.message}');
      if (e.response != null) {
        print('Status code: ${e.response?.statusCode}');
        print('Response data: ${e.response?.data}');
      }
      rethrow;
    }

    return response;
  }
}
