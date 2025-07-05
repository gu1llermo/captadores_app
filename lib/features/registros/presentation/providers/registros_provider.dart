import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/config/environment_config.dart';
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

  final _databaseUrl = EnvironmentConfig().databaseUrl;

  @override
  Future<RegistrosState> build() async {
    _authStateAsync = ref.watch(authNotifierProvider);

    _customScrollController = ScrollController();

    ref.onDispose(() {
      _customScrollController?.dispose();
    });

    List<RegistroEntity> registros = [];

    try {
      if (isAuthenticated()) {
        registros = await getAllRecords();
      }
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
    state = AsyncData(
      currentState.copyWith(
        statusMessage: 'Error: $error, $stackTrace',
        hasError: true,
      ),
    );
    await Future.delayed(const Duration(seconds: 3), () {
      state = AsyncData(
        currentState.copyWith(statusMessage: '', hasError: false),
      );
    });
  }

  Future<void> showMessage({
    required String message,
    int seconds = 3
  }) async {
    final currentState = await future;
    state = AsyncData(
      currentState.copyWith(
        statusMessage: message,
      ),
    );
    await Future.delayed( Duration(seconds: seconds), () {
      state = AsyncData(
        currentState.copyWith(statusMessage: ''),
      );
    });
  }



  bool isAuthenticated() {
    if (_authStateAsync == null) return false;
    if (_authStateAsync!.hasValue) {
      final authState = _authStateAsync!.value!;
      if (authState.isAutenticated) {
        return true;
      }
    }
    return false;
  }

  Future<List<RegistroEntity>> getAllRecords() async {
    try {
      final authState = _authStateAsync!.value!;

      final user = authState.user!;

      final allRecords = await ref
          .read(registrosRepositoryProvider)
          .getAllRecords(
            sheetName: user.sheetName,
            databaseUrl: _databaseUrl,
          );

      return allRecords;
    } catch (error) {
      rethrow;
    }
  }
  
  Future<void> addNewRecord({
    required String sheetName,
    required String apiBaseUrl,
    required RegistroEntity record,

  }) async {
    final currentState = await future;
    if (isAuthenticated()) {
        try {
          
          state = const AsyncLoading();
      final authState = _authStateAsync!.value!;

      final user = authState.user!;

      final idRegistro = await ref
          .read(registrosRepositoryProvider)
          .addNewRecord(
            sheetName: user.sheetName,
            databaseUrl: _databaseUrl,
            record: record,
          );
     
     final newRecords = [...currentState.registros, record];
     state = AsyncData(currentState.copyWith(registros: newRecords));
     

    } catch (error, stackTrace) {
      setError(error: error, stackTrace: stackTrace, currentState: currentState);
      rethrow;
    }
      }
    

    
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
  final bool hasError;
  final String statusMessage;

  final List<RegistroEntity> registros;
  final ScrollController? customScrollController;

  RegistrosState({
    this.statusMessage = '',
    this.hasError = false,

    this.registros = const [], 
    this.customScrollController,
    });

  RegistrosState copyWith({
    String? statusMessage,
    bool? hasError,

    List<RegistroEntity>? registros,
    ScrollController? customScrollController,
  }) => RegistrosState(
    statusMessage: statusMessage ?? this.statusMessage,
    hasError: hasError ?? this.hasError,

    registros: registros ?? this.registros,
    customScrollController:
        customScrollController ?? this.customScrollController,
  );
}
