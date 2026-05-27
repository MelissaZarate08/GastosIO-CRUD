import '../../domain/entities/transaccion.dart';

/// Model de datos — extiende la Entity Transaccion y agrega serialización.
class TransaccionModel extends Transaccion {
  const TransaccionModel({
    required super.id,
    required super.tipo,
    required super.monto,
    required super.categoria,
    super.descripcion,
    required super.fecha,
  });

  factory TransaccionModel.fromJson(Map<String, dynamic> json) {
    return TransaccionModel(
      id: json['id'] as int,
      tipo: json['tipo'] as String,
      monto: (json['monto'] as num).toDouble(),
      categoria: json['categoria'] as String,
      descripcion: json['descripcion'] as String?,
      fecha: DateTime.parse(json['fecha'] as String),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'tipo': tipo,
    'monto': monto,
    'categoria': categoria,
    'descripcion': descripcion,
    'fecha': fecha.toIso8601String(),
  };
}
