import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Asegura que todo esté listo antes de iniciar Firebase
  await Firebase.initializeApp();            // Inicializa Firebase
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Comunitaria',
      debugShowCheckedModeBanner: false,
      home: const LoginScreen(),
    );
  }
}
