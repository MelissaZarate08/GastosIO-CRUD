import 'package:flutter/foundation.dart';

class ApiConstants {
  ApiConstants._();

  static const String _ec2Host = '32.196.151.130:8000';

  static String get _host {
    if (kIsWeb) return 'localhost:8000';
    return _ec2Host;
  }

  static String get baseUrl => 'http://$_host';

  static String get register => '$baseUrl/api/auth/register';
  static String get login    => '$baseUrl/api/auth/login';
  static String get transacciones => '$baseUrl/api/transacciones';
  static String transaccionById(int id) => '$transacciones/$id';
}