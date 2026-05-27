import '../entities/transaccion.dart';
import '../repositories/transaccion_repository.dart';

/// Caso de uso: obtener todas las transacciones del usuario.
class GetTransacciones {
  final TransaccionRepository _repository;

  GetTransacciones(this._repository);

  Future<List<Transaccion>> call({required String token}) {
    return _repository.getAll(token: token);
  }
}
