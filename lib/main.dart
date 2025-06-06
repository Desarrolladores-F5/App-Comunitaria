import 'package:flutter/material.dart'; // 🧱 Flutter para UI
import 'package:firebase_core/firebase_core.dart'; // 🔥 Firebase Core
import 'firebase_options.dart'; // ⚙️ Configuración de Firebase
import 'package:intl/date_symbol_data_local.dart'; // 📅 Soporte de fechas en español
import 'package:flutter_localizations/flutter_localizations.dart'; // 🌐 Localizaciones Flutter
import 'l10n/app_localizations.dart'; // 🌐 Traducciones generadas

// 🖼️ Pantallas
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'screens/check_auth_screen.dart'; // ✅ Pantalla splash/check

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ✅ Inicializa Firebase
  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  // 📅 Inicializar soporte para fechas en español (Chile) 
  await initializeDateFormatting('es_CL', null);

  // 🚀 Inicia la app
  runApp(MyApp());
}

// 🧠 Clase para controlar y cambiar el idioma dinámicamente
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  // 🔁 Permite acceder al estado desde otras pantallas (como MenuIdiomaScreen)
  static _MyAppState? of(BuildContext context) => context.findAncestorStateOfType<_MyAppState>();

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale = const Locale('es'); // 🌍 Idioma inicial por defecto

  // 🔄 Método para cambiar el idioma
  void setLocale(Locale newLocale) {
    setState(() => _locale = newLocale);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Comunitaria',
      debugShowCheckedModeBanner: false,

      // 🌐 Configuración de idioma
      locale: _locale,
      supportedLocales: const [
        Locale('es'), // Español
        Locale('en'), // Inglés
      ],
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

      // 🧭 Pantalla inicial
      home: const CheckAuthScreen(),

      // 🛣️ Rutas nombradas
      routes: {
        '/login': (context) => const LoginScreen(),
        '/home': (context) => const HomeScreen(),
      },
    );
  }
}
