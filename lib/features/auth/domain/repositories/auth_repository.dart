import '../entities/user.dart';

abstract class AuthRepository {
  Future<void> register({
    required String nombre,
    required String email,
    required String password,
  });

  Future<User> login({
    required String email,
    required String password,
  });
}
