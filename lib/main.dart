import 'package:flutter/material.dart'; // 🧱 Flutter para UI
import 'package:firebase_core/firebase_core.dart'; // 🔥 Firebase Core
// 🔐 Firebase Auth
import 'firebase_options.dart'; // ⚙️ Configuración de Firebase
import 'package:intl/date_symbol_data_local.dart';


// 🖼️ Pantallas
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'screens/check_auth_screen.dart'; // ✅ Nueva pantalla tipo splash/check

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ✅ Inicializa Firebase
  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  // 📅 Inicializar soporte para fechas en español (Chile) 
  await initializeDateFormatting('es_CL', null); // 📅 Esto es clave 

  // 🧪 Puedes comentar esto si no quieres cerrar sesión automáticamente al iniciar
  // await FirebaseAuth.instance.signOut();

  // 🚀 Inicia la app
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Comunitaria',
      debugShowCheckedModeBanner: false,

      // 🧭 Pantalla inicial → CheckAuthScreen (muestra splash y decide a dónde ir)
      home: const CheckAuthScreen(),

      // 🛣️ Rutas nombradas para navegación
      routes: {
        '/login': (context) => const LoginScreen(),
        '/home': (context) => const HomeScreen(),        
      },
    );
  }
}
