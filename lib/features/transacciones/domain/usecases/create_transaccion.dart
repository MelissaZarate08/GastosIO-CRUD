import '../entities/transaccion.dart';
import '../repositories/transaccion_repository.dart';

class CreateTransaccion {
  final TransaccionRepository _repository;

  CreateTransaccion(this._repository);

  Future<Transaccion> call({
    required String token,
    required String tipo,
    required double monto,
    required String categoria,
    String? descripcion,
  }) {
    return _repository.create(
      token: token,
      tipo: tipo,
      monto: monto,
      categoria: categoria,
      descripcion: descripcion,
    );
  }
}
