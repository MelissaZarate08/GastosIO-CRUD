import '../../domain/entities/user.dart';

/// Model de datos — extiende la Entity y agrega serialización JSON.
/// Vive en la capa de datos, no en el dominio.
class UserModel extends User {
  const UserModel({
    required super.id,
    required super.nombre,
    required super.email,
    required super.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['usuario_id'] as int,
      nombre: json['nombre'] as String,
      email: json['email'] ?? '',
      token: json['token'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    'usuario_id': id,
    'nombre': nombre,
    'email': email,
    'token': token,
  };
}
