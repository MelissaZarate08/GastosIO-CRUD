import 'package:flutter/foundation.dart';

class ApiConstants {
  ApiConstants._();

  // En web → localhost, en Android (emulador) → 10.0.2.2
  static String get _host {
    if (kIsWeb) return 'localhost:8000';
    return '10.0.2.2:8000';
  }

  static String get baseUrl => 'http://$_host';

  // Auth
  static String get register => '$baseUrl/api/auth/register';
  static String get login    => '$baseUrl/api/auth/login';

  // Transacciones
  static String get transacciones => '$baseUrl/api/transacciones';
  static String transaccionById(int id) => '$transacciones/$id';
}