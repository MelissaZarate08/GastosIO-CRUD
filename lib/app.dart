import 'package:crudflutter/core/http/http_client.dart';
import 'package:crudflutter/features/auth/di/auth_di.dart';
import 'package:crudflutter/features/auth/presentation/providers/auth_provider.dart';
import 'package:crudflutter/features/auth/presentation/view/login_view.dart';
import 'package:crudflutter/features/auth/presentation/view/register_view.dart';
import 'package:crudflutter/features/transacciones/di/transacciones_di.dart';
import 'package:crudflutter/features/transacciones/presentation/providers/transaccion_provider.dart';
import 'package:crudflutter/features/transacciones/presentation/view/home_view.dart';
import 'package:crudflutter/shared/theme/theme.dart';
import 'package:crudflutter/shared/theme/util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// App — raíz de la aplicación.
/// MultiProvider construido usando los DI de cada feature (inyección manual).
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    // Única instancia compartida del cliente HTTP
    final httpClient = HttpClient();

    final brightness = View.of(context).platformDispatcher.platformBrightness;
    final TextTheme textTheme = createTextTheme(context, 'Roboto', 'Outfit');
    final MaterialTheme theme = MaterialTheme(textTheme);

    return MultiProvider(
      providers: [
        // Cada feature construye su propio árbol de dependencias
        ChangeNotifierProvider<AuthProvider>(
          create: (_) => AuthDI.buildAuthProvider(httpClient: httpClient),
        ),
        ChangeNotifierProvider<TransaccionProvider>(
          create: (_) =>
              TransaccionesDI.buildTransaccionProvider(httpClient: httpClient),
        ),
      ],
      child: MaterialApp(
        title: 'GastosIO',
        debugShowCheckedModeBanner: false,
        theme: brightness == Brightness.light ? theme.light() : theme.dark(),
        initialRoute: '/',
        routes: {
          '/': (_) => const _AuthGate(),
          '/login': (_) => const LoginView(),
          '/register': (_) => const RegisterView(),
          '/home': (_) => const HomeView(),
        },
      ),
    );
  }
}

/// Guarda de navegación: verifica sesión antes de mostrar la app.
class _AuthGate extends StatefulWidget {
  const _AuthGate();

  @override
  State<_AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<_AuthGate> {
  bool _checking = true;

  @override
  void initState() {
    super.initState();
    _checkSession();
  }

  Future<void> _checkSession() async {
    await context.read<AuthProvider>().tryAutoLogin();
    if (!mounted) return;
    setState(() => _checking = false);
  }

  @override
  Widget build(BuildContext context) {
    if (_checking) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final isAuth = context.watch<AuthProvider>().isAuthenticated;
    if (isAuth) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacementNamed(context, '/home');
      });
      return const Scaffold(
          body: Center(child: CircularProgressIndicator()));
    }

    return const LoginView();
  }
}
