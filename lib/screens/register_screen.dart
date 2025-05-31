import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nombreController = TextEditingController();
  final _apellidoController = TextEditingController();
  final _direccionController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  // 🧠 FUNCION PRINCIPAL DE REGISTRO
  Future<void> _registerUser() async {
    if (_formKey.currentState!.validate()) {
      final direccion = _direccionController.text.trim();

      try {
        // 🔍 Verificar si ya hay 2 usuarios con esta misma dirección
        final snapshot = await FirebaseFirestore.instance
            .collection('usuarios')
            .where('direccion', isEqualTo: direccion)
            .get();

        if (snapshot.docs.length >= 2) {
          // ❌ Si hay 2 o más, no permitimos el registro
          AwesomeDialog(
            context: context,
            dialogType: DialogType.warning,
            animType: AnimType.rightSlide,
            title: 'Límite alcanzado',
            desc: 'Solo se permiten 2 personas registradas por dirección.',
            btnOkOnPress: () {},
          ).show();
          return;
        }

        // ✅ Si hay menos de 2, registramos al usuario
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );

        // 💾 Guardamos los datos en Firestore
        await FirebaseFirestore.instance
            .collection('usuarios')
            .doc(userCredential.user!.uid)
            .set({
          'nombre': _nombreController.text.trim(),
          'apellido': _apellidoController.text.trim(),
          'direccion': direccion,
          'email': _emailController.text.trim(),
          'uid': userCredential.user!.uid,
          'fecha_registro': Timestamp.now(),
        });

        // 🎉 Éxito: mostrar diálogo bonito
        AwesomeDialog(
          context: context,
          dialogType: DialogType.success,
          animType: AnimType.scale,
          title: 'Registro exitoso',
          desc: 'El usuario fue registrado correctamente.',
          btnOkOnPress: () {
            Navigator.pop(context); // 🔙 Volver al login
          },
        ).show();

      } on FirebaseAuthException catch (e) {
        // ⚠️ Errores conocidos de Firebase Auth
        String mensaje = 'Ocurrió un error con el registro.';
        if (e.code == 'email-already-in-use') {
          mensaje = 'El correo ya está registrado';
        } else if (e.code == 'weak-password') {
          mensaje = 'Contraseña muy débil';
        } else if (e.code == 'invalid-email') {
          mensaje = 'Correo electrónico inválido';
        }

        AwesomeDialog(
          context: context,
          dialogType: DialogType.warning,
          animType: AnimType.bottomSlide,
          title: 'Atención',
          desc: mensaje,
          btnOkOnPress: () {},
        ).show();

      } catch (e) {
        // ⚠️ Otros errores no controlados
        AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          animType: AnimType.topSlide,
          title: 'Error',
          desc: 'Error inesperado: $e',
          btnOkOnPress: () {},
        ).show();
      }
    }
  }

  // 🖼️ UI DEL FORMULARIO
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        title: const Text('Registro de Vecinos'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 👤 Nombre
                TextFormField(
                  controller: _nombreController,
                  decoration: const InputDecoration(
                    labelText: 'Nombre',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => value == null || value.isEmpty ? 'Ingresa tu nombre' : null,
                ),
                const SizedBox(height: 15),

                // 👤 Apellidos
                TextFormField(
                  controller: _apellidoController,
                  decoration: const InputDecoration(
                    labelText: 'Apellidos',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => value == null || value.isEmpty ? 'Ingresa tus apellidos' : null,
                ),
                const SizedBox(height: 15),

                // 🏠 Dirección
                TextFormField(
                  controller: _direccionController,
                  decoration: const InputDecoration(
                    labelText: 'Dirección',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => value == null || value.isEmpty ? 'Ingresa tu dirección' : null,
                ),
                const SizedBox(height: 15),

                // 📧 Correo
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Correo electrónico',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty || !value.contains('@')) {
                      return 'Correo inválido';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),

                // 🔐 Contraseña
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Contraseña',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.length < 6) {
                      return 'Mínimo 6 caracteres';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),

                // 🔐 Confirmar Contraseña
                TextFormField(
                  controller: _confirmPasswordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Confirmar contraseña',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value != _passwordController.text) {
                      return 'Las contraseñas no coinciden';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 25),

                // ✅ Botón registrar
                ElevatedButton(
                  onPressed: _registerUser,
                  child: const Text('Registrarse'),
                ),
                const SizedBox(height: 10),

                // 🔁 Link volver al login
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('¿Ya tienes cuenta? Inicia sesión'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
