import 'dart:convert';
import 'package:http/http.dart' as http;

class HttpClient {
  final http.Client _client;

  HttpClient({http.Client? client}) : _client = client ?? http.Client();

  Map<String, String> _baseHeaders({String? token}) {
    final headers = {'Content-Type': 'application/json'};
    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }
    return headers;
  }

  Future<http.Response> get(String url, {String? token}) async {
    return _client.get(
      Uri.parse(url),
      headers: _baseHeaders(token: token),
    );
  }

  Future<http.Response> post(
      String url,
      Map<String, dynamic> body, {
        String? token,
      }) async {
    return _client.post(
      Uri.parse(url),
      headers: _baseHeaders(token: token),
      body: jsonEncode(body),
    );
  }

  Future<http.Response> put(
      String url,
      Map<String, dynamic> body, {
        String? token,
      }) async {
    return _client.put(
      Uri.parse(url),
      headers: _baseHeaders(token: token),
      body: jsonEncode(body),
    );
  }

  Future<http.Response> delete(String url, {String? token}) async {
    return _client.delete(
      Uri.parse(url),
      headers: _baseHeaders(token: token),
    );
  }
}
