import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quicknotes/data/datasources/auth_remote_data_source.dart';
import 'package:quicknotes/domain/repositories/auth_repository.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final remoteDataSource = ref.watch(authRemoteDataSourceProvider);
  return AuthRepositoryImpl(remoteDataSource);
});

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._remoteDataSource);

  final AuthRemoteDataSource _remoteDataSource;

  @override
  Future<bool> signUp(String name, String email, String password) {
    return _remoteDataSource.signUp(name, email, password);
  }

  @override
  Future<bool> signIn(String email, String password) {
    return _remoteDataSource.signIn(email, password);
  }

  @override
  Future<void> logout() {
    return _remoteDataSource.logout();
  }
}
