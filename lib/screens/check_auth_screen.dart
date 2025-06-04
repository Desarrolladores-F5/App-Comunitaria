import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

// ✅ Librería para animaciones suaves
import 'package:animated_text_kit/animated_text_kit.dart';

class CheckAuthScreen extends StatelessWidget {
  const CheckAuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    print('🧠 CheckAuthScreen: build ejecutado');

    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(), // 🔄 Escucha cambios de sesión
      builder: (context, snapshot) {
        print('📡 Estado conexión: ${snapshot.connectionState}');
        print('📦 Datos de sesión?: ${snapshot.hasData}');

        if (snapshot.connectionState == ConnectionState.waiting) {
          // ⏳ Mientras espera respuesta de Firebase, muestra splash
          return const SplashPantalla();
        }

        // ✅ Si está autenticado
        if (snapshot.hasData && snapshot.data != null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pushReplacementNamed(context, '/home');
          });
        } else {
          // ❌ No autenticado
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pushReplacementNamed(context, '/login');
          });
        }

        // 🔄 Retorno temporal para evitar errores de render
        return const SizedBox.shrink();
      },
    );
  }
}

// 🎨 Widget de Splash con logo + animación
class SplashPantalla extends StatelessWidget {
  const SplashPantalla({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 🔷 Logo temporal (puedes reemplazarlo con una imagen de assets si quieres)
            const Icon(
              Icons.flutter_dash,
              size: 100,
              color: Colors.blue,
            ),
            const SizedBox(height: 20),

            // 🔠 Texto animado "Cargando sesión..."
            DefaultTextStyle(
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Colors.black54,
              ),
              child: AnimatedTextKit(
                isRepeatingAnimation: true,
                animatedTexts: [
                  TyperAnimatedText('Verificando sesión...'),
                  TyperAnimatedText('Cargando datos...'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
