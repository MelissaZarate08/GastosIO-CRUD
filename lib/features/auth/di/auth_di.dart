import 'package:crudflutter/core/http/http_client.dart';
import '../data/datasources/auth_remote_datasource.dart';
import '../data/repositories/auth_repository_impl.dart';
import '../domain/repositories/auth_repository.dart';
import '../domain/usecases/login_user.dart';
import '../domain/usecases/register_user.dart';
import '../presentation/providers/auth_provider.dart';

class AuthDI {
  AuthDI._();

  static AuthProvider buildAuthProvider({required HttpClient httpClient}) {

    final dataSource = AuthRemoteDataSource(httpClient: httpClient);
    final AuthRepository repository =
    AuthRepositoryImpl(dataSource: dataSource);

    final registerUser = RegisterUser(repository);
    final loginUser = LoginUser(repository);

    return AuthProvider(
      registerUser: registerUser,
      loginUser: loginUser,
    );
  }
}
