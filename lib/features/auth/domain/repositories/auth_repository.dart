import '../entities/user.dart';

/// Contrato abstracto del repositorio de autenticación.
/// El dominio define QUÉ se puede hacer; la capa de datos implementa CÓMO.
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
