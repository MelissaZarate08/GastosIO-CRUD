import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/entities/user.dart';
import '../../domain/usecases/login_user.dart';
import '../../domain/usecases/register_user.dart';

/// AuthProvider — capa de presentación.
/// Gestiona el estado de autenticación usando Provider (ChangeNotifier).
/// Solo conoce los UseCases del dominio, nunca el DataSource ni el Repository.
class AuthProvider extends ChangeNotifier {
  final RegisterUser _registerUser;
  final LoginUser _loginUser;

  AuthProvider({
    required RegisterUser registerUser,
    required LoginUser loginUser,
  })  : _registerUser = registerUser,
        _loginUser = loginUser;

  User? _currentUser;
  bool _isLoading = false;
  String? _errorMessage;

  // ── Getters públicos ─────────────────────────────────────────────────────
  User? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isAuthenticated => _currentUser != null;

  // ── Acciones ─────────────────────────────────────────────────────────────

  Future<bool> register({
    required String nombre,
    required String email,
    required String password,
  }) async {
    _setLoading(true);
    _clearError();
    try {
      await _registerUser(nombre: nombre, email: email, password: password);
      return true;
    } catch (e) {
      _errorMessage = e.toString().replaceFirst('Exception: ', '');
      notifyListeners();
      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> login({
    required String email,
    required String password,
  }) async {
    _setLoading(true);
    _clearError();
    try {
      final user = await _loginUser(email: email, password: password);
      _currentUser = user;
      await _saveSession(user);
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString().replaceFirst('Exception: ', '');
      notifyListeners();
      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<void> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final userId = prefs.getInt('usuario_id');
    final nombre = prefs.getString('nombre');

    if (token != null && userId != null && nombre != null) {
      _currentUser = User(
        id: userId,
        nombre: nombre,
        email: '',
        token: token,
      );
      notifyListeners();
    }
  }

  Future<void> logout() async {
    _currentUser = null;
    await _clearSession();
    notifyListeners();
  }

  void clearError() => _clearError();

  // ── Helpers privados ─────────────────────────────────────────────────────
  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _clearError() {
    _errorMessage = null;
  }

  Future<void> _saveSession(User user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', user.token);
    await prefs.setInt('usuario_id', user.id);
    await prefs.setString('nombre', user.nombre);
  }

  Future<void> _clearSession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.remove('usuario_id');
    await prefs.remove('nombre');
  }
}
