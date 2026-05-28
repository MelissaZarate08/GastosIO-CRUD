import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart'; // ← 1. Agrega este import para las fechas
import 'app.dart';

void main() async { // ← 2. Añade 'async' aquí
  // 3. Asegura que Flutter esté listo antes de inicializar el idioma
  WidgetsFlutterBinding.ensureInitialized();

  // 4. Inicializa el formato en español ('es')
  await initializeDateFormatting('es', null);

  runApp(
    DevicePreview(
      enabled: kIsWeb,
      builder: (context) => const App(),
    ),
  );
}