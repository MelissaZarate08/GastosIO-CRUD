import 'package:flutter/foundation.dart';
import '../../domain/entities/transaccion.dart';
import '../../domain/usecases/get_transacciones.dart';
import '../../domain/usecases/create_transaccion.dart';
import '../../domain/usecases/update_transaccion.dart';
import '../../domain/usecases/delete_transaccion.dart';

class TransaccionProvider extends ChangeNotifier {
  final GetTransacciones _getTransacciones;
  final CreateTransaccion _createTransaccion;
  final UpdateTransaccion _updateTransaccion;
  final DeleteTransaccion _deleteTransaccion;

  TransaccionProvider({
    required GetTransacciones getTransacciones,
    required CreateTransaccion createTransaccion,
    required UpdateTransaccion updateTransaccion,
    required DeleteTransaccion deleteTransaccion,
  })
      : _getTransacciones = getTransacciones,
        _createTransaccion = createTransaccion,
        _updateTransaccion = updateTransaccion,
        _deleteTransaccion = deleteTransaccion;

  List<Transaccion> _transacciones = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Transaccion> get transacciones => List.unmodifiable(_transacciones);

  bool get isLoading => _isLoading;

  String? get errorMessage => _errorMessage;

  double get balance =>
      _transacciones.fold(
          0.0, (sum, t) => t.esIngreso ? sum + t.monto : sum - t.monto);

  double get totalIngresos =>
      _transacciones
          .where((t) => t.esIngreso)
          .fold(0.0, (sum, t) => sum + t.monto);

  double get totalEgresos =>
      _transacciones
          .where((t) => t.esEgreso)
          .fold(0.0, (sum, t) => sum + t.monto);

  Future<void> fetchAll({required String token}) async {
    _setLoading(true);
    _clearError();
    try {
      final resultado = await _getTransacciones(token: token);

      _transacciones = List<Transaccion>.from(resultado);

      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString().replaceFirst('Exception: ', '');
      notifyListeners();
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> addTransaction({
    required String token,
    required String tipo,
    required double monto,
    required String categoria,
    String? descripcion,
  }) async {
    _setLoading(true);
    _clearError();
    try {
      final nueva = await _createTransaccion(
        token: token,
        tipo: tipo,
        monto: monto,
        categoria: categoria,
        descripcion: descripcion,
      );
      _transacciones.insert(0, nueva);
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

  Future<bool> updateTransaction({
    required String token,
    required int id,
    double? monto,
    String? categoria,
    String? descripcion,
  }) async {
    _setLoading(true);
    _clearError();
    try {

      await _updateTransaccion(
        token: token,
        id: id,
        monto: monto,
        categoria: categoria,
        descripcion: descripcion,
      );

      final index = _transacciones.indexWhere((t) => t.id == id);
      if (index != -1) {
        final vieja = _transacciones[index];

        _transacciones[index] = vieja.copyWith(
          monto: monto ?? vieja.monto,
          categoria: categoria ?? vieja.categoria,
          descripcion: descripcion ?? vieja.descripcion,
        );
      }

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

  Future<bool> deleteTransaction({
    required String token,
    required int id,
  }) async {
    _setLoading(true);
    _clearError();
    try {
      await _deleteTransaccion(token: token, id: id);
      _transacciones.removeWhere((t) => t.id == id);
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

  void clearError() => _clearError();

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _clearError() {
    _errorMessage = null;
  }
}