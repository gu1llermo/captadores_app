
import '../../domain/datasources/auth_data_source.dart';
import '../../domain/repositories/auth_repository.dart';
import '../models/user_model.dart';


class AuthRepositoryImpl extends AuthRepository {
  final AuthDataSource datasource;

  AuthRepositoryImpl(this.datasource);

  @override
  Future<UserModel> login({required String email, required String password}) async {
    return await datasource.login(email: email, password: password);
  }

  @override
  Future<void> logout() async {
    return await datasource.logout();
  }

  @override
  Future<void> changePassword({required String newPassword, required String token}) async {
    return await datasource.changePassword(newPassword: newPassword, token: token);
  }

  @override
  Future<void> recoveryPassword({required String email}) async {
    return await datasource.recoveryPassword(email: email);
  }

}