

import '../../data/models/user_model.dart';

abstract class AuthDataSource {
  Future<UserModel> login({required String email, required String password});
  Future<void> logout();
  Future<void> changePassword({required String newPassword, required String token});
  Future<void> recoveryPassword({required String email});
}
