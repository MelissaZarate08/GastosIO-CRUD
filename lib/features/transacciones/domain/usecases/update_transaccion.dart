import '../repositories/transaccion_repository.dart';

/// Caso de uso: actualizar una transacción existente.
class UpdateTransaccion {
  final TransaccionRepository _repository;

  UpdateTransaccion(this._repository);

  Future<void> call({
    required String token,
    required int id,
    double? monto,
    String? categoria,
    String? descripcion,
  }) {
    return _repository.update(
      token: token,
      id: id,
      monto: monto,
      categoria: categoria,
      descripcion: descripcion,
    );
  }
}
