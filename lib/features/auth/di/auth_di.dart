import 'package:crudflutter/core/http/http_client.dart';
import '../data/datasources/auth_remote_datasource.dart';
import '../data/repositories/auth_repository_impl.dart';
import '../domain/repositories/auth_repository.dart';
import '../domain/usecases/login_user.dart';
import '../domain/usecases/register_user.dart';
import '../presentation/providers/auth_provider.dart';

/// Inyección de dependencias manual del feature Auth.
/// Construye el árbol completo: DataSource → Repository → UseCases → Provider.
/// No se usa GetIt ni ningún contenedor externo.
class AuthDI {
  AuthDI._();

  static AuthProvider buildAuthProvider({required HttpClient httpClient}) {
    // Capa de datos
    final dataSource = AuthRemoteDataSource(httpClient: httpClient);
    final AuthRepository repository =
    AuthRepositoryImpl(dataSource: dataSource);

    // Casos de uso
    final registerUser = RegisterUser(repository);
    final loginUser = LoginUser(repository);

    // Provider (presentación)
    return AuthProvider(
      registerUser: registerUser,
      loginUser: loginUser,
    );
  }
}
