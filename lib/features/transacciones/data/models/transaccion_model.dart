import '../../domain/entities/transaccion.dart';

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
      id: json['id'] as int? ?? json['_id'] as int? ?? 0,
      tipo: json['tipo'] as String? ?? 'egreso',
      monto: (json['monto'] as num?)?.toDouble() ?? 0.0,
      categoria: json['categoria'] as String? ?? 'Otro',
      descripcion: json['descripcion'] as String?,
      fecha: json['fecha'] != null
          ? DateTime.parse(json['fecha'] as String)
          : DateTime.now(),
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