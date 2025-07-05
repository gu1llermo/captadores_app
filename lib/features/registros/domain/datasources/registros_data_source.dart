
import '../entities/registro_entity.dart';

abstract class RegistrosDataSource {
  Future<List<RegistroEntity>> getAllRecords({
    required String sheetName,
    required String databaseUrl,
    });
  Future<List<String>> getAbogadosName({ required String apiBaseUrl});

  Future<RegistroEntity?> getRecordById({ 
    required String sheetName,
    required String databaseUrl, 
    required String idRegistro,
    });

  Future<String?> addNewRecord({ 
    required String sheetName,
    required String databaseUrl, 
    required RegistroEntity record,
    });
}