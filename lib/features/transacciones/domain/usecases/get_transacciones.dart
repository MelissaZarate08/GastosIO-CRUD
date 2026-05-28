import '../entities/transaccion.dart';
import '../repositories/transaccion_repository.dart';

class GetTransacciones {
  final TransaccionRepository _repository;

  GetTransacciones(this._repository);

  Future<List<Transaccion>> call({required String token}) {
    return _repository.getAll(token: token);
  }
}
