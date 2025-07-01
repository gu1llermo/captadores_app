import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/services/services.dart';
import '../../../authentication/presentation/providers/auth_provider.dart';
import '../../domain/entities/registro_entity.dart';
import 'registros_repository_provider.dart';

part 'registros_provider.g.dart';

@Riverpod(
  keepAlive: true,
  dependencies: [registrosRepository, AuthNotifier, internetConnectionService],
)
class RegistrosNotifier extends _$RegistrosNotifier {
  ScrollController? _customScrollController;
  double? _savedScrollPosition;
  AsyncValue<AuthState>? _authStateAsync;

  @override
  Future<RegistrosState> build() async {
    _authStateAsync = ref.watch(authNotifierProvider);

    _customScrollController = ScrollController();

    ref.onDispose(() {
      // _customScrollController.removeListener(_scrollListener);
      _customScrollController?.dispose();
    });

    List<RegistroEntity> registros = [];

    try {
      registros = await getAllRecords();
    } catch (error, stackTrace) {
      debugPrint('Error: $error, $stackTrace');
      //await setError(error: error, stackTrace: stackTrace, currentState: currentState)
    }

    return RegistrosState(
      customScrollController: _customScrollController,
      registros: registros,
    );
  }

  Future<void> refreshFromServer() async {
    final currentState = await future;

    state = const AsyncLoading();
    try {
      final registros = await getAllRecords();
      state = AsyncData(currentState.copyWith(registros: registros));
    } catch (error, stackTrace) {
      // qué te parece si hacemos éste error que sea temporal 3 segundos
      await setError(
        error: error,
        stackTrace: stackTrace,
        currentState: currentState,
      );
    }
  }

  Future<void> setError({
    required Object error,
    required StackTrace stackTrace,
    required RegistrosState currentState,
  }) async {
    state = AsyncError(error, stackTrace);
    await Future.delayed(const Duration(seconds: 3), () {
      // una vez pasados los 3 segundos
      state = AsyncData(currentState);
    });
  }

  Future<List<RegistroEntity>> getAllRecords() async {
    if (_authStateAsync == null) return [];
    if (_authStateAsync!.hasValue) {
      final authState = _authStateAsync!.value!;
      if (authState.isAutenticated) {
        final user = authState.user!;

        final allRecords = await ref
            .read(registrosRepositoryProvider)
            .getAllRecords(
              sheetName: user.sheetName,
              apiBaseUrl: user.apiBaseUrl,
            );

        return allRecords;
      }
    }

    return [];
  }

  Future<void> logout() async {
    final currentState = await future;
    try {
      await ref.read(authNotifierProvider.notifier).logout();
    } catch (error, stackTrace) {
      setError(
        error: error,
        stackTrace: stackTrace,
        currentState: currentState,
      );
    }
  }

  void saveScrollPosition() {
    if (_customScrollController?.hasClients ?? false) {
      _savedScrollPosition = _customScrollController?.offset;
    }
  }

  void restoreScrollPosition() {
    if (_savedScrollPosition != null &&
        (_customScrollController?.hasClients ?? false)) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _customScrollController?.jumpTo(_savedScrollPosition!);
      });
    }
  }
}

class RegistrosState {
  final List<RegistroEntity> registros;
  final ScrollController? customScrollController;

  RegistrosState({this.registros = const [], this.customScrollController});

  RegistrosState copyWith({
    List<RegistroEntity>? registros,
    ScrollController? customScrollController,
  }) => RegistrosState(
    registros: registros ?? this.registros,
    customScrollController:
        customScrollController ?? this.customScrollController,
  );
}
