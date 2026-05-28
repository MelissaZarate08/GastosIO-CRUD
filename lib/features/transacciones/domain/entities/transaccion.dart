class Transaccion {
  final int id;
  final String tipo;
  final double monto;
  final String categoria;
  final String? descripcion;
  final DateTime fecha;

  const Transaccion({
    required this.id,
    required this.tipo,
    required this.monto,
    required this.categoria,
    this.descripcion,
    required this.fecha,
  });

  bool get esIngreso => tipo == 'ingreso';
  bool get esEgreso => tipo == 'egreso';
  bool get montoValido => monto > 0;

  Transaccion copyWith({
    int? id,
    String? tipo,
    double? monto,
    String? categoria,
    String? descripcion,
    DateTime? fecha,
  }) {
    return Transaccion(
      id: id ?? this.id,
      tipo: tipo ?? this.tipo,
      monto: monto ?? this.monto,
      categoria: categoria ?? this.categoria,
      descripcion: descripcion ?? this.descripcion,
      fecha: fecha ?? this.fecha,
    );
  }
}
