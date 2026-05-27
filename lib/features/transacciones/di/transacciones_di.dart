import 'package:crudflutter/core/http/http_client.dart';
import '../data/datasources/transaccion_remote_datasource.dart';
import '../data/repositories/transaccion_repository_impl.dart';
import '../domain/repositories/transaccion_repository.dart';
import '../domain/usecases/get_transacciones.dart';
import '../domain/usecases/create_transaccion.dart';
import '../domain/usecases/update_transaccion.dart';
import '../domain/usecases/delete_transaccion.dart';
import '../presentation/providers/transaccion_provider.dart';

/// Inyección de dependencias manual del feature Transacciones.
/// Construye: DataSource → Repository → UseCases → Provider.
class TransaccionesDI {
  TransaccionesDI._();

  static TransaccionProvider buildTransaccionProvider({
    required HttpClient httpClient,
  }) {
    // Capa de datos
    final dataSource =
    TransaccionRemoteDataSource(httpClient: httpClient);
    final TransaccionRepository repository =
    TransaccionRepositoryImpl(dataSource: dataSource);

    // Casos de uso
    final getTransacciones = GetTransacciones(repository);
    final createTransaccion = CreateTransaccion(repository);
    final updateTransaccion = UpdateTransaccion(repository);
    final deleteTransaccion = DeleteTransaccion(repository);

    // Provider (presentación)
    return TransaccionProvider(
      getTransacciones: getTransacciones,
      createTransaccion: createTransaccion,
      updateTransaccion: updateTransaccion,
      deleteTransaccion: deleteTransaccion,
    );
  }
}
