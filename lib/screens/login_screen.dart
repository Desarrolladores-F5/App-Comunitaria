import 'package:flutter/material.dart'; // Importamos el paquete de Flutter para construir interfaces gráficas
import 'register_screen.dart';


// Creamos una clase LoginScreen que extiende StatelessWidget porque no necesitamos manejar estado aún
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key}); // Constructor constante

  @override
  Widget build(BuildContext context) {
    return Scaffold( // Scaffold es la base visual de la pantalla (estructura tipo app)
      backgroundColor: Colors.blue[50], // Color de fondo suave (azul claro)

      // Padding: agrega espacio interno en los bordes
      body: Padding(
        padding: const EdgeInsets.all(20.0), // 20 píxeles de padding por cada lado

        // Center: centra todo verticalmente
        child: Center(
          child: SingleChildScrollView( // Permite hacer scroll si el contenido no cabe (útil con teclado)
            child: Column( // Organiza los widgets en vertical
              mainAxisAlignment: MainAxisAlignment.center, // Centra el contenido verticalmente
              children: [
                const Text( // Título principal
                  'Bienvenido, vecino!',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 20), // Espaciado vertical

                TextField( // Campo para ingresar correo
                  decoration: InputDecoration(
                    labelText: 'Correo electrónico', // Texto que aparece arriba del input
                    border: OutlineInputBorder(), // Borde redondeado alrededor del campo
                  ),
                ),

                const SizedBox(height: 20), // Otro espacio

                TextField( // Campo para ingresar contraseña
                  obscureText: true, // Oculta el texto (para contraseñas)
                  decoration: InputDecoration(
                    labelText: 'Contraseña',
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 30), // Espacio antes del botón

                ElevatedButton( // Botón principal para iniciar sesión
                  onPressed: () {
                    // Aquí va la lógica que validará e iniciará sesión (lo agregaremos con Firebase)
                  },
                  child: const Text('Iniciar sesión'),
                ),

                const SizedBox(height: 15), // Espacio antes del texto de registro

                TextButton( // Botón de texto plano, para redirigir a la pantalla de registro
                  onPressed: () {
                    // Aquí se navegará hacia la pantalla de registro
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RegisterScreen(),
                      ),
                    );
                  },
                  child: const Text('¿No tienes cuenta? Regístrate'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
