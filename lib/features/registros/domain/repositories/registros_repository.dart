

import '../entities/registro_entity.dart';

abstract class RegistrosRepository {
  Future<List<RegistroEntity>> getAllRecords({
    required String sheetName,
    required String apiBaseUrl,
    });
  Future<List<String>> getAbogadosName({ required String apiBaseUrl});

  Future<RegistroEntity?> getRecordById({ 
    required String sheetName,
    required String apiBaseUrl, 
    required String id,
    });
    
  Future<String?> addNewRecord({ 
    required String sheetName,
    required String apiBaseUrl, 
    required RegistroEntity record,
    });
}