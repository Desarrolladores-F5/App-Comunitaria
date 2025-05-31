import 'package:flutter/material.dart'; // 🧱 Flutter para UI
import 'package:firebase_auth/firebase_auth.dart'; // 🔐 Firebase Auth

class CheckAuthScreen extends StatelessWidget {
  const CheckAuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    print('🧠 CheckAuthScreen: build ejecutado');
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(), // 🔄 Detecta cambios de sesión

      builder: (context, snapshot) {
        print('📡 Estado de conexión: ${snapshot.connectionState}');
        print('📬 Snapshot tiene datos?: ${snapshot.hasData}');
        print('📦 Usuario: ${snapshot.data}');

        if (snapshot.connectionState == ConnectionState.waiting) {
          print('⏳ Aún esperando respuesta de Firebase (authStateChanges)...');
          return const Scaffold(
            body: Center(child: Text('⏳ Esperando sesión...')),
          );
        }

        // ✅ Usuario autenticado
        if (snapshot.hasData && snapshot.data != null) {
          print('✅ Usuario autenticado: ${snapshot.data!.email}');
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pushReplacementNamed(context, '/home');
          });
        } else {
          // 🚪 Usuario NO autenticado
          print('🚪 Usuario no autenticado');
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pushReplacementNamed(context, '/login');
          });
        }

        // 🔄 Retorno temporal para evitar errores
        return const SizedBox.shrink();
      },
    );
  }
}
