import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/data.dart';
import '../../domain/domain.dart';

part 'auth_repository_provider.g.dart';

@Riverpod(dependencies: [])
AuthDataSource authDataSource(Ref ref) {
  return AuthDataSourceImpl();
}

@Riverpod(dependencies: [authDataSource])
AuthRepository authRepository(Ref ref) {
  final authDataSource = ref.read(authDataSourceProvider);
  return AuthRepositoryImpl(authDataSource);
}