import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';

/// Implementación concreta del AuthRepository.
/// Conecta el dominio con la fuente de datos.
/// El dominio solo conoce la interfaz abstracta, nunca esta clase.
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _dataSource;

  AuthRepositoryImpl({required AuthRemoteDataSource dataSource})
      : _dataSource = dataSource;

  @override
  Future<void> register({
    required String nombre,
    required String email,
    required String password,
  }) {
    return _dataSource.register(
      nombre: nombre,
      email: email,
      password: password,
    );
  }

  @override
  Future<User> login({
    required String email,
    required String password,
  }) {
    return _dataSource.login(email: email, password: password);
  }
}
