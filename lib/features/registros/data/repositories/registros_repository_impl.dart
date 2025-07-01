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
  Future<List<RegistroEntity>> getAllRecords({required String sheetName, required String apiBaseUrl}) {
    return datasource.getAllRecords(sheetName: sheetName, apiBaseUrl: apiBaseUrl);
  }
}
