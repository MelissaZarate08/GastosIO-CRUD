import '../repositories/transaccion_repository.dart';

/// Caso de uso: eliminar una transacción.
class DeleteTransaccion {
  final TransaccionRepository _repository;

  DeleteTransaccion(this._repository);

  Future<void> call({required String token, required int id}) {
    return _repository.delete(token: token, id: id);
  }
}
