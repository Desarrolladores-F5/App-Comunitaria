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

  // Método para obtener los datos del usuario desde Firestore
  Future<void> cargarDatosUsuario() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;

    if (uid != null) {
      try {
        final doc =
            await FirebaseFirestore.instance.collection('usuarios').doc(uid).get();

        if (doc.exists) {
          setState(() {
            nombre = doc.data()?['nombre'];
            direccion = doc.data()?['direccion'];
            cargando = false;
          });
        }
      } catch (e) {
        print('Error al cargar los datos del usuario: $e');
        setState(() {
          cargando = false;
        });
      }
    }
  }

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
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              if (context.mounted) {
                Navigator.pushReplacementNamed(context, '/login');
              }
            },
          ),
        ],
      ),
      body: cargando
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hola, $nombre 👋',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Dirección: $direccion',
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 30),
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
