import 'package:captadores_app/features/registros/domain/entities/registro_entity.dart';

import '../../domain/datasources/registros_data_source.dart';
import '../../domain/repositories/registros_repository.dart';

class RegistrosRepositoryImpl extends RegistrosRepository {
  final RegistrosDataSource datasource;
  RegistrosRepositoryImpl(this.datasource);

  @override
  Future<List<String>> getAbogadosName({required String apiBaseUrl}) {
    return datasource.getAbogadosName(apiBaseUrl: apiBaseUrl);
  }

  @override
  Future<List<RegistroEntity>> getAllRecords({
    required String sheetName,
    required String databaseUrl,
  }) {
    return datasource.getAllRecords(
      sheetName: sheetName,
      databaseUrl: databaseUrl,
    );
  }

  @override
  Future<RegistroEntity?> getRecordById({
    required String databaseUrl,
    required String idRegistro,
    required String sheetName,
  }) {
    return datasource.getRecordById(
      databaseUrl: databaseUrl, 
      sheetName: sheetName,
      idRegistro: idRegistro);
  }

  @override
  Future<String?> addNewRecord({
    required String sheetName,
    required String databaseUrl,
    required RegistroEntity record,
  }) {
    return datasource.addNewRecord(
      sheetName: sheetName,
      databaseUrl: databaseUrl,
      record: record,
    );
  }
}
