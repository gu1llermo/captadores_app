import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/services/services.dart';
import '../../../../core/services/storage/key_value_storage_service.dart';
import '../../data/models/user_model.dart';
import '../../domain/domain.dart';
import 'auth_repository_provider.dart';


part 'auth_provider.g.dart';

@Riverpod(
  keepAlive: true,
  dependencies: [
    keyValueStorageService,
    authRepository,
    InternetConnectionNotifier,
  ],
)
class AuthNotifier extends _$AuthNotifier {
  late final KeyValueStorageService _storage;
  late final AuthRepository _authRepository;

  @override
  Future<AuthState> build() async {
    _storage = ref.read(keyValueStorageServiceProvider);
    _authRepository = ref.read(authRepositoryProvider);
    final user = await _getLocalUser();

    return AuthState(
      status:
          user != null ? AuthStatus.authenticated : AuthStatus.unauthenticated,
      user: user,
    );
  }

  Future<UserEntity?> _getLocalUser() async {
    final userString = await _storage.getValue<String>('_secure_user');
    return userString != null ? UserModel.fromString(userString) : null;
  }

  Future<void> _saveLocalUser(UserModel user) async {
    final userString = user.toString();
    await _storage.setKeyValue<String>('_secure_user', userString);
  }

  // Future<void> _saveLocalToken(String token) async {
  //   await _storage.setKeyValue<String>('_secure_token', token);
  // }

  // Future<String?> _getLocalToken() async {
  //   final token = await _storage.getValue<String>('_secure_token');
  //   return token;
  // }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    if (!_isConnected()) {
      throw Exception('No hay conexión a internet');
    }
    // state = const AsyncValue.loading();

    try {
      //final token = await _getLocalToken();
      final user = await _authRepository.login(
        email: email,
        password: password,
        
      );
      
      state = AsyncValue.data(
        state.value!.copyWith(status: AuthStatus.authenticated, user: user),
      );
      await _saveLocalUser(user);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
      rethrow;
    }
  }

  Future<void> logout() async {
    final user = state.value?.user;
    if (user == null) return;
    await _storage.removeKey('_secure_user');
    state = AsyncValue.data(
      state.value!.copyWith(status: AuthStatus.unauthenticated, user: null),
    );

   
  }

  bool _isConnected() {
    final internetConnection = ref.read(internetConnectionNotifierProvider);
    return internetConnection.isConnected;
  }

  Future<void> changePassword({
    required String newPassword,
    required String token,
  }) async {
    if (!_isConnected()) {
      throw Exception('No hay conexión a internet');
    }
    try {
      await _authRepository.changePassword(
        newPassword: newPassword,
        token: token,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> recoveryPassword({required String email}) async {
    if (!_isConnected()) {
      throw Exception('No hay conexión a internet');
    }
    try {
      await _authRepository.recoveryPassword(email: email);
    } catch (e) {
      rethrow;
    }
  }
}

enum AuthStatus { initial, authenticated, unauthenticated }

class AuthState {
  final AuthStatus status;
  final String? errorMessage;

  final UserEntity? user;

  const AuthState({
    this.status = AuthStatus.initial,
    this.errorMessage,
    this.user,
  });

  AuthState copyWith({
    AuthStatus? status,
    String? errorMessage,
    UserEntity? user,
  }) {
    return AuthState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      user: user ?? this.user,
    );
  }
}
