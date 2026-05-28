import 'dart:convert';
import 'package:crudflutter/core/constants/api_constants.dart';
import 'package:crudflutter/core/http/http_client.dart';
import '../models/transaccion_model.dart';

class TransaccionRemoteDataSource {
  final HttpClient _httpClient;

  TransaccionRemoteDataSource({required HttpClient httpClient})
      : _httpClient = httpClient;

  Future<List<TransaccionModel>> getAll({required String token}) async {
    final response = await _httpClient.get(
      ApiConstants.transacciones,
      token: token,
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data
          .map((json) =>
          TransaccionModel.fromJson(json as Map<String, dynamic>))
          .toList();
    }

    throw Exception(
        'Error al cargar transacciones (${response.statusCode})');
  }

  Future<TransaccionModel> create({
    required String token,
    required String tipo,
    required double monto,
    required String categoria,
    String? descripcion,
  }) async {
    final body = {
      'tipo': tipo,
      'monto': monto,
      'categoria': categoria,
      if (descripcion != null) 'descripcion': descripcion,
    };

    final response = await _httpClient.post(
      ApiConstants.transacciones,
      body,
      token: token,
    );

    if (response.statusCode == 201) {
      return TransaccionModel.fromJson(jsonDecode(response.body));
    }

    final errorBody = jsonDecode(response.body);
    throw Exception(errorBody['detail'] ??
        'Error al crear transacción (${response.statusCode})');
  }

  Future<TransaccionModel> update({
    required String token,
    required int id,
    double? monto,
    String? categoria,
    String? descripcion,
  }) async {
    final body = <String, dynamic>{
      if (monto != null) 'monto': monto,
      if (categoria != null) 'categoria': categoria,
      if (descripcion != null) 'descripcion': descripcion,
    };

    final response = await _httpClient.put(
      ApiConstants.transaccionById(id),
      body,
      token: token,
    );

    if (response.statusCode == 200) {
      return TransaccionModel.fromJson(jsonDecode(response.body));
    }

    final errorBody = jsonDecode(response.body);
    throw Exception(errorBody['detail'] ??
        'Error al actualizar (${response.statusCode})');
  }

  Future<void> delete({required String token, required int id}) async {
    final response = await _httpClient.delete(
      ApiConstants.transaccionById(id),
      token: token,
    );

    if (response.statusCode == 200 || response.statusCode == 204) return;

    throw Exception(
        'Error al eliminar transacción (${response.statusCode})');
  }
}
