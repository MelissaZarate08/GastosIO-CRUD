import '../entities/transaccion.dart';

abstract class TransaccionRepository {
  Future<List<Transaccion>> getAll({required String token});

  Future<Transaccion> create({
    required String token,
    required String tipo,
    required double monto,
    required String categoria,
    String? descripcion,
  });

  Future<Transaccion> update({
    required String token,
    required int id,
    double? monto,
    String? categoria,
    String? descripcion,
  });

  Future<void> delete({
    required String token,
    required int id,
  });
}