
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/datasources/registros_data_source_impl.dart';
import '../../data/repositories/registros_repository_impl.dart';
import '../../domain/repositories/registros_repository.dart';

part 'registros_repository_provider.g.dart';

@Riverpod(dependencies: [])
RegistrosRepository registrosRepository(Ref ref) {
  final datasource = RegistrosDataSourceImpl();
  return RegistrosRepositoryImpl(datasource);
}