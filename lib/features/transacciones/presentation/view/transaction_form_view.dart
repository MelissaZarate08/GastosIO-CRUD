import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../domain/entities/transaccion.dart';
import '../providers/transaccion_provider.dart';

/// TransactionFormView — formulario para crear o editar una transacción.
/// Si recibe [transaccion] es modo edición; si es null, es modo creación.
class TransactionFormView extends StatefulWidget {
  final Transaccion? transaccion;

  const TransactionFormView({super.key, this.transaccion});

  @override
  State<TransactionFormView> createState() => _TransactionFormViewState();
}

class _TransactionFormViewState extends State<TransactionFormView> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _montoCtrl;
  late final TextEditingController _descripcionCtrl;

  String _tipo = 'egreso';
  String _categoria = 'Comida';

  bool get _isEditing => widget.transaccion != null;

  static const List<String> _categorias = [
    'Comida',
    'Transporte',
    'Ocio',
    'Salario',
    'Salud',
    'Educación',
    'Ropa',
    'Servicios',
    'Ahorro',
    'Otro',
  ];

  @override
  void initState() {
    super.initState();
    final t = widget.transaccion;
    _montoCtrl = TextEditingController(
        text: t != null ? t.monto.toStringAsFixed(2) : '');
    _descripcionCtrl =
        TextEditingController(text: t?.descripcion ?? '');
    if (t != null) {
      _tipo = t.tipo;
      _categoria = t.categoria;
    }
  }

  @override
  void dispose() {
    _montoCtrl.dispose();
    _descripcionCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final token = context.read<AuthProvider>().currentUser!.token;
    final monto = double.parse(_montoCtrl.text);
    final descripcion = _descripcionCtrl.text.trim().isEmpty
        ? null
        : _descripcionCtrl.text.trim();

    bool success;
    if (_isEditing) {
      success = await context.read<TransaccionProvider>().updateTransaction(
        token: token,
        id: widget.transaccion!.id,
        monto: monto,
        categoria: _categoria,
        descripcion: descripcion,
      );
    } else {
      success = await context.read<TransaccionProvider>().addTransaction(
        token: token,
        tipo: _tipo,
        monto: monto,
        categoria: _categoria,
        descripcion: descripcion,
      );
    }

    if (!mounted) return;
    if (success) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final isLoading = context.watch<TransaccionProvider>().isLoading;
    final errorMessage = context.watch<TransaccionProvider>().errorMessage;

    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? 'Editar transacción' : 'Nueva transacción'),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Error message
              if (errorMessage != null) ...[
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: colorScheme.errorContainer,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(errorMessage,
                      style: TextStyle(color: colorScheme.onErrorContainer)),
                ),
                const SizedBox(height: 16),
              ],

              // ── Tipo (Ingreso / Egreso) ───────────────────────────────────
              Text('Tipo de movimiento',
                  style: textTheme.labelLarge?.copyWith(
                      color: colorScheme.onSurfaceVariant)),
              const SizedBox(height: 8),
              SegmentedButton<String>(
                segments: const [
                  ButtonSegment(
                    value: 'ingreso',
                    label: Text('Ingreso'),
                    icon: Icon(Icons.arrow_upward_rounded),
                  ),
                  ButtonSegment(
                    value: 'egreso',
                    label: Text('Egreso'),
                    icon: Icon(Icons.arrow_downward_rounded),
                  ),
                ],
                selected: {_tipo},
                onSelectionChanged: _isEditing
                    ? null // No se puede cambiar el tipo al editar
                    : (value) => setState(() => _tipo = value.first),
              ),
              const SizedBox(height: 24),

              // ── Monto ────────────────────────────────────────────────────
              TextFormField(
                controller: _montoCtrl,
                keyboardType:
                const TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  labelText: 'Monto',
                  prefixIcon: const Icon(Icons.attach_money_rounded),
                  prefixText: '\$ ',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                  filled: true,
                  fillColor: colorScheme.surfaceContainerLow,
                ),
                validator: (v) {
                  if (v == null || v.trim().isEmpty) return 'Ingresa el monto';
                  final parsed = double.tryParse(v);
                  if (parsed == null || parsed <= 0) {
                    return 'Ingresa un monto válido mayor a 0';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // ── Categoría ────────────────────────────────────────────────
              DropdownButtonFormField<String>(
                value: _categoria,
                decoration: InputDecoration(
                  labelText: 'Categoría',
                  prefixIcon: const Icon(Icons.category_outlined),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                  filled: true,
                  fillColor: colorScheme.surfaceContainerLow,
                ),
                items: _categorias
                    .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                    .toList(),
                onChanged: (v) => setState(() => _categoria = v!),
              ),
              const SizedBox(height: 16),

              // ── Descripción (opcional) ───────────────────────────────────
              TextFormField(
                controller: _descripcionCtrl,
                maxLines: 2,
                decoration: InputDecoration(
                  labelText: 'Descripción (opcional)',
                  prefixIcon: const Icon(Icons.notes_rounded),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                  filled: true,
                  fillColor: colorScheme.surfaceContainerLow,
                ),
              ),
              const SizedBox(height: 32),

              // ── Botón guardar ────────────────────────────────────────────
              FilledButton.icon(
                onPressed: isLoading ? null : _submit,
                icon: isLoading
                    ? const SizedBox(
                  height: 18,
                  width: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
                    : Icon(_isEditing
                    ? Icons.save_rounded
                    : Icons.add_circle_rounded),
                label: Text(
                  _isEditing ? 'Guardar cambios' : 'Registrar',
                  style: const TextStyle(fontSize: 16),
                ),
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
