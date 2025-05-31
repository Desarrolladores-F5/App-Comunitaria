import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? nombre;
  String? direccion;
  bool cargando = true;

  // 📦 Método para obtener los datos del usuario desde Firestore usando su UID
  Future<void> cargarDatosUsuario() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;

    if (uid != null) {
      try {
        final doc = await FirebaseFirestore.instance
            .collection('usuarios')
            .doc(uid)
            .get();

        if (doc.exists) {
          // ✅ Si el documento existe, actualizamos los datos para mostrar en pantalla
          setState(() {
            nombre = doc.data()?['nombre'];
            direccion = doc.data()?['direccion'];
            cargando = false;
          });
        }
      } catch (e) {
        print('❌ Error al cargar los datos del usuario: $e');
        setState(() {
          cargando = false;
        });
      }
    }
  }

  // 🔁 Se llama al iniciar el widget para cargar datos del usuario
  @override
  void initState() {
    super.initState();
    cargarDatosUsuario();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bienvenido'),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Cerrar sesión',
            onPressed: () async {
              // 🔐 Cierra la sesión del usuario
              await FirebaseAuth.instance.signOut();

              // 🚪 Redirige al login limpiando la navegación
              if (context.mounted) {
                Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
              }
            },
          ),
        ],
      ),

      // ⏳ Si los datos aún se están cargando, muestra un loader
      body: cargando
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 👋 Bienvenida personalizada
                  Text(
                    'Hola, $nombre 👋',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),

                  // 📍 Dirección
                  Text(
                    'Dirección: $direccion',
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 30),

                  // 📌 Aviso sobre el muro de publicaciones
                  const Text(
                    '🧱 Muro de publicaciones (proximamente)',
                    style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
                  ),
                ],
              ),
            ),
    );
  }
}
