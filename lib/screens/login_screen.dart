import 'package:flutter/material.dart'; // Importamos el paquete de Flutter para construir interfaces gráficas
import 'package:firebase_auth/firebase_auth.dart'; // ✅ Firebase Auth para autenticar
import 'register_screen.dart';
// ✅ Importamos la pantalla principal

// Creamos una clase LoginScreen que extiende StatefulWidget para manejar estado (como loading o validación)
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key}); // Constructor constante

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // ✅ Controladores de texto para recuperar el input del usuario
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // ✅ Clave para el formulario (validación)
  final _formKey = GlobalKey<FormState>();

  // ✅ Variable para mostrar un spinner de carga si se desea
  bool _isLoading = false;

  // ✅ Método para iniciar sesión con Firebase Auth
  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );

        // ✅ Redirige a la pantalla principal al iniciar sesión exitosamente
        Navigator.pushReplacementNamed(context, '/home');

      } on FirebaseAuthException catch (e) {
        String mensaje = 'Ocurrió un error al iniciar sesión.';
        if (e.code == 'user-not-found') {
          mensaje = 'Usuario no encontrado.';
        } else if (e.code == 'wrong-password') {
          mensaje = 'Contraseña incorrecta.';
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(mensaje)),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error inesperado: $e')),
        );
      } finally {
        setState(() => _isLoading = false);
      }
    }
  }

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
            child: Form(
              key: _formKey, // ✅ Formulario con clave para validación
              child: Column( // Organiza los widgets en vertical
                mainAxisAlignment: MainAxisAlignment.center, // Centra el contenido verticalmente
                children: [
                  const Text( // Título principal
                    'Bienvenido, vecino!',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 20), // Espaciado vertical

                  TextFormField( // Campo para ingresar correo
                    controller: _emailController, // ✅ Controlador de email
                    decoration: const InputDecoration(
                      labelText: 'Correo electrónico', // Texto que aparece arriba del input
                      border: OutlineInputBorder(), // Borde redondeado alrededor del campo
                    ),
                    validator: (value) {
                      if (value == null || !value.contains('@')) {
                        return 'Correo inválido';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 20), // Otro espacio

                  TextFormField( // Campo para ingresar contraseña
                    controller: _passwordController, // ✅ Controlador de contraseña
                    obscureText: true, // Oculta el texto (para contraseñas)
                    decoration: const InputDecoration(
                      labelText: 'Contraseña',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.length < 6) {
                        return 'Contraseña muy corta';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 30), // Espacio antes del botón

                  _isLoading
                      ? const CircularProgressIndicator() // ✅ Indicador de carga
                      : ElevatedButton( // Botón principal para iniciar sesión
                          onPressed: _login, // ✅ Ejecuta el login
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
      ),
    );
  }
}
