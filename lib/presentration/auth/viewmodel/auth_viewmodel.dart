import 'package:flutter_riverpod/legacy.dart';
import 'package:quicknotes/data/repositories/auth_repository_impl.dart';
import 'package:quicknotes/domain/repositories/auth_repository.dart';

final authViewModelProvider =
    StateNotifierProvider<AuthViewModel, bool>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return AuthViewModel(repository);
});

class AuthViewModel extends StateNotifier<bool> {
  AuthViewModel(this._authRepository) : super(false);

  final AuthRepository _authRepository;

  Future<bool> signUp(String name, String email, String password) async {
    try {
      state = true;
      return await _authRepository.signUp(name, email, password);
    } catch (_) {
      return false;
    } finally {
      state = false;
    }
  }

  Future<bool> signIn(String email, String password) async {
    try {
      state = true;
      return await _authRepository.signIn(email, password);
    } catch (_) {
      return false;
    } finally {
      state = false;
    }
  }

  Future<void> logout() async {
    await _authRepository.logout();
  }
}
