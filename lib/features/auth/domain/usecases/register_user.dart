import '../repositories/auth_repository.dart';

/// Caso de uso: registrar un usuario nuevo.
/// Una clase = un caso de uso (principio del maestro).
class RegisterUser {
  final AuthRepository _repository;

  RegisterUser(this._repository);

  Future<void> call({
    required String nombre,
    required String email,
    required String password,
  }) {
    return _repository.register(
      nombre: nombre,
      email: email,
      password: password,
    );
  }
}
