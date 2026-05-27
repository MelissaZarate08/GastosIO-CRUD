/// Entity pura del dominio.
/// No conoce JSON, API ni Flutter — solo representa el concepto de Usuario.
class User {
  final int id;
  final String nombre;
  final String email;
  final String token;

  const User({
    required this.id,
    required this.nombre,
    required this.email,
    required this.token,
  });

  /// Regla de negocio del dominio
  bool get isValidEmail => email.contains('@');
}
