import 'package:flutter/material.dart'; // 🧱 Flutter para UI
import 'package:firebase_core/firebase_core.dart'; // 🔥 Firebase Core
import 'package:firebase_auth/firebase_auth.dart'; // 🔐 Firebase Auth
import 'firebase_options.dart'; // ⚙️ Configuración de Firebase

// 🖼️ Pantallas
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'screens/check_auth_screen.dart'; // 🧪 Sigue disponible si la quieres usar más adelante

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ✅ Inicializa Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // 🚪 Cierra sesión cada vez que se inicia la app (ideal para pruebas)
  await FirebaseAuth.instance.signOut();

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

      // 🧭 Pantalla inicial → Login (siempre, porque cerramos sesión antes)
      home: const LoginScreen(),

      // 🛣️ Rutas nombradas para navegación
      routes: {
        '/login': (context) => const LoginScreen(),
        '/home': (context) => const HomeScreen(),
        // '/check': (context) => const CheckAuthScreen(), // 💡 Si decides usarla después
      },
    );
  }
}
