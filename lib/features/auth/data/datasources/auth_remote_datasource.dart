import 'dart:convert';
import 'package:crudflutter/core/constants/api_constants.dart';
import 'package:crudflutter/core/http/http_client.dart';
import '../models/user_model.dart';

/// DataSource de autenticación.
/// Responsabilidad única: hablar con la API REST y retornar Models.
/// No conoce nada de dominio ni de presentación.
class AuthRemoteDataSource {
  final HttpClient _httpClient;

  AuthRemoteDataSource({required HttpClient httpClient})
      : _httpClient = httpClient;

  Future<void> register({
    required String nombre,
    required String email,
    required String password,
  }) async {
    final response = await _httpClient.post(
      ApiConstants.register,
      {'nombre': nombre, 'email': email, 'password': password},
    );

    if (response.statusCode != 201) {
      final body = jsonDecode(response.body);
      throw Exception(body['detail'] ?? 'Error al registrar usuario');
    }
  }

  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    final response = await _httpClient.post(
      ApiConstants.login,
      {'email': email, 'password': password},
    );

    if (response.statusCode == 200) {
      return UserModel.fromJson(jsonDecode(response.body));
    }

    final body = jsonDecode(response.body);
    throw Exception(body['detail'] ?? 'Credenciales incorrectas');
  }
}
