import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../domain/entities/transaccion.dart';
import '../providers/transaccion_provider.dart';
import 'transaction_form_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final NumberFormat _currencyFormat =
  NumberFormat.currency(locale: 'es_MX', symbol: '\$');

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadData());
  }

  Future<void> _loadData() async {
    final token = context.read<AuthProvider>().currentUser?.token;
    if (token != null) {
      await context.read<TransaccionProvider>().fetchAll(token: token);
    }
  }

  Future<void> _openForm({Transaccion? transaccion}) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => TransactionFormView(transaccion: transaccion),
      ),
    );
  }

  Future<void> _confirmDelete(Transaccion t) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Eliminar transacción'),
        content: Text(
            '¿Seguro que quieres eliminar "${t.categoria}" de ${_currencyFormat.format(t.monto)}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );

    if (confirm == true && mounted) {
      final token = context.read<AuthProvider>().currentUser!.token;
      await context
          .read<TransaccionProvider>()
          .deleteTransaction(token: token, id: t.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    // context.watch() — se suscribe a todos los cambios del ViewModel
    final txVM = context.watch<TransaccionProvider>();
    final authVM = context.watch<AuthProvider>();
    final userName = authVM.currentUser?.nombre ?? '';

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _loadData,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 280,
              floating: false,
              pinned: true,
              backgroundColor: colorScheme.primary,
              foregroundColor: colorScheme.onPrimary,
              actions: [
                IconButton(
                  icon: const Icon(Icons.logout_rounded),
                  tooltip: 'Cerrar sesión',
                  onPressed: () async {
                    await context.read<AuthProvider>().logout();
                    if (mounted) {
                      Navigator.pushReplacementNamed(context, '/');
                    }
                  },
                ),
              ],
              flexibleSpace: FlexibleSpaceBar(
                background: _BalanceCard(
                  userName: userName,
                  balance: txVM.balance,
                  totalIngresos: txVM.totalIngresos,
                  totalEgresos: txVM.totalEgresos,
                  currencyFormat: _currencyFormat,
                ),
              ),
            ),

            if (txVM.errorMessage != null)
              SliverToBoxAdapter(
                child: Container(
                  margin: const EdgeInsets.all(16),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: colorScheme.errorContainer,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.error_outline, color: colorScheme.error),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(txVM.errorMessage!,
                            style: TextStyle(
                                color: colorScheme.onErrorContainer)),
                      ),
                    ],
                  ),
                ),
              ),

            if (txVM.isLoading)
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(32),
                  child: Center(child: CircularProgressIndicator()),
                ),
              ),

            if (!txVM.isLoading)
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Movimientos',
                        style: textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${txVM.transacciones.length} registros',
                        style: textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

            if (!txVM.isLoading && txVM.transacciones.isEmpty)
              SliverFillRemaining(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.receipt_long_outlined,
                          size: 64,
                          color: colorScheme.onSurfaceVariant.withOpacity(0.4)),
                      const SizedBox(height: 16),
                      Text(
                        'Sin movimientos aún',
                        style: textTheme.titleMedium?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                      Text(
                        'Toca + para agregar tu primer registro',
                        style: textTheme.bodySmall?.copyWith(
                          color:
                          colorScheme.onSurfaceVariant.withOpacity(0.6),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

            if (!txVM.isLoading && txVM.transacciones.isNotEmpty)
              SliverList(
                delegate: SliverChildBuilderDelegate(
                      (context, index) {
                    final t = txVM.transacciones[index];
                    return _TransaccionTile(
                      transaccion: t,
                      currencyFormat: _currencyFormat,
                      onEdit: () => _openForm(transaccion: t),
                      onDelete: () => _confirmDelete(t),
                    );
                  },
                  childCount: txVM.transacciones.length,
                ),
              ),

            const SliverToBoxAdapter(child: SizedBox(height: 80)),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _openForm(),
        icon: const Icon(Icons.add_rounded),
        label: const Text('Agregar'),
      ),
    );
  }
}

class _BalanceCard extends StatelessWidget {
  final String userName;
  final double balance;
  final double totalIngresos;
  final double totalEgresos;
  final NumberFormat currencyFormat;

  const _BalanceCard({
    required this.userName,
    required this.balance,
    required this.totalIngresos,
    required this.totalEgresos,
    required this.currencyFormat,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            colorScheme.primary,
            colorScheme.primaryContainer.withOpacity(0.8),
          ],
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 60, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hola, $userName 👋',
                style: textTheme.titleMedium?.copyWith(
                  color: colorScheme.onPrimary.withOpacity(0.85),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Tu balance actual',
                style: textTheme.bodySmall?.copyWith(
                  color: colorScheme.onPrimary.withOpacity(0.65),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                currencyFormat.format(balance),
                style: textTheme.displaySmall?.copyWith(
                  color: colorScheme.onPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),

              Row(
                children: [
                  Expanded(
                    child: _SummaryChip(
                      icon: Icons.arrow_upward_rounded,
                      label: 'Ingresos',
                      amount: currencyFormat.format(totalIngresos),
                      color: colorScheme.tertiaryContainer,
                      textColor: colorScheme.onTertiaryContainer,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _SummaryChip(
                      icon: Icons.arrow_downward_rounded,
                      label: 'Egresos',
                      amount: currencyFormat.format(totalEgresos),
                      color: colorScheme.errorContainer,
                      textColor: colorScheme.onErrorContainer,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SummaryChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final String amount;
  final Color color;
  final Color textColor;

  const _SummaryChip({
    required this.icon,
    required this.label,
    required this.amount,
    required this.color,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: color.withOpacity(0.85),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: textColor, size: 18),
          const SizedBox(width: 6),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: TextStyle(
                        color: textColor.withOpacity(0.7), fontSize: 10)),
                Text(amount,
                    style: TextStyle(
                        color: textColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 13),
                    overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TransaccionTile extends StatelessWidget {
  final Transaccion transaccion;
  final NumberFormat currencyFormat;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const _TransaccionTile({
    required this.transaccion,
    required this.currencyFormat,
    required this.onEdit,
    required this.onDelete,
  });

  static const Map<String, IconData> _categoryIcons = {
    'Comida': Icons.restaurant_rounded,
    'Transporte': Icons.directions_bus_rounded,
    'Ocio': Icons.movie_rounded,
    'Salario': Icons.work_rounded,
    'Salud': Icons.local_hospital_rounded,
    'Educación': Icons.school_rounded,
    'Ropa': Icons.checkroom_rounded,
    'Servicios': Icons.receipt_rounded,
    'Ahorro': Icons.savings_rounded,
  };

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final isIngreso = transaccion.esIngreso;
    final dateStr = DateFormat('dd MMM', 'es').format(transaccion.fecha);
    final icon = _categoryIcons[transaccion.categoria] ??
        Icons.attach_money_rounded;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: colorScheme.outlineVariant.withOpacity(0.5)),
      ),
      child: ListTile(
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: isIngreso
                ? colorScheme.tertiaryContainer
                : colorScheme.errorContainer,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: isIngreso
                ? colorScheme.onTertiaryContainer
                : colorScheme.onErrorContainer,
            size: 22,
          ),
        ),
        title: Text(
          transaccion.categoria,
          style: textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (transaccion.descripcion != null &&
                transaccion.descripcion!.isNotEmpty)
              Text(
                transaccion.descripcion!,
                style: textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            Text(
              dateStr,
              style: textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurfaceVariant.withOpacity(0.7)),
            ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '${isIngreso ? '+' : '-'}${currencyFormat.format(transaccion.monto)}',
              style: textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: isIngreso
                    ? colorScheme.tertiary
                    : colorScheme.error,
              ),
            ),
            PopupMenuButton<String>(
              icon: Icon(Icons.more_vert_rounded,
                  color: colorScheme.onSurfaceVariant, size: 18),
              itemBuilder: (_) => [
                const PopupMenuItem(value: 'edit', child: Text('Editar')),
                const PopupMenuItem(
                    value: 'delete', child: Text('Eliminar')),
              ],
              onSelected: (value) {
                if (value == 'edit') onEdit();
                if (value == 'delete') onDelete();
              },
            ),
          ],
        ),
      ),
    );
  }
}
