// 📦 Importaciones necesarias
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart'; // 📦 Para obtener versión de la app

class MenuAcercaDeScreen extends StatefulWidget {
  const MenuAcercaDeScreen({super.key});

  @override
  State<MenuAcercaDeScreen> createState() => _MenuAcercaDeScreenState();
}

class _MenuAcercaDeScreenState extends State<MenuAcercaDeScreen> {
  String version = 'Cargando...'; // 🌀 Valor inicial mientras se obtiene la versión

  @override
  void initState() {
    super.initState();
    cargarVersion(); // 🔁 Llama a la función para obtener versión de la app
  }

  // 🔍 Obtiene la información de la versión desde el sistema
  Future<void> cargarVersion() async {
    final info = await PackageInfo.fromPlatform(); // 📦 Usa el paquete info_plus
    setState(() {
      version = info.version; // ✅ Asigna la versión real
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Acerca de la App'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 📱 Título principal
            const Text(
              'App Comunitaria',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            // 🔢 Versión de la app
            Text('Versión: $version', style: const TextStyle(fontSize: 16)),

            const SizedBox(height: 20),

            // ℹ️ Descripción breve
            const Text(
              'Esta app fue creada para fortalecer la comunicación entre vecinos. '
              'Permite compartir publicaciones, sugerencias y mantenerse informados de todo lo que ocurre en la comunidad.',
              style: TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 20),

            // 🧑‍💻 Info desarrollador
            const Text('🛠 Desarrollada por: Equipo Desarrolladores-F5'),
            const SizedBox(height: 10),
            const Text('📧 Contacto: contacto@comunidadf5.cl'),

            const Spacer(), // 🔽 Empuja el siguiente texto al fondo de la pantalla

            // 📄 Derechos reservados
            const Text(
              '© 2025 Todos los derechos reservados',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
