
import '../entities/registro_entity.dart';

abstract class RegistrosDataSource {
  Future<List<RegistroEntity>> getAllRecords({required String sheetName, required String apiBaseUrl});
  Future<List<String>> getAbogadosName({ required String apiBaseUrl});
}