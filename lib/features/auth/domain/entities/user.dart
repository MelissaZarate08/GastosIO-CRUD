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

  bool get isValidEmail => email.contains('@');
}
