import '../../domain/entities/transaccion.dart';
import '../../domain/repositories/transaccion_repository.dart';
import '../datasources/transaccion_remote_datasource.dart';

class TransaccionRepositoryImpl implements TransaccionRepository {
  final TransaccionRemoteDataSource _dataSource;

  TransaccionRepositoryImpl({required TransaccionRemoteDataSource dataSource})
      : _dataSource = dataSource;

  @override
  Future<List<Transaccion>> getAll({required String token}) {
    return _dataSource.getAll(token: token);
  }

  @override
  Future<Transaccion> create({
    required String token,
    required String tipo,
    required double monto,
    required String categoria,
    String? descripcion,
  }) {
    return _dataSource.create(
      token: token,
      tipo: tipo,
      monto: monto,
      categoria: categoria,
      descripcion: descripcion,
    );
  }


  @override
  Future<Transaccion> update({
    required String token,
    required int id,
    double? monto,
    String? categoria,
    String? descripcion,
  }) {
    return _dataSource.update(
      token: token,
      id: id,
      monto: monto,
      categoria: categoria,
      descripcion: descripcion,
    );
  }

  @override
  Future<void> delete({required String token, required int id}) {
    return _dataSource.delete(token: token, id: id);
  }
}
