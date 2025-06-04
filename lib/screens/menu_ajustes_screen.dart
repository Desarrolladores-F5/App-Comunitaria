// 📄 menu_ajustes_screen.dart
import 'package:flutter/material.dart';

class MenuAjustesScreen extends StatefulWidget {
  const MenuAjustesScreen({super.key});

  @override
  State<MenuAjustesScreen> createState() => _MenuAjustesScreenState();
}

class _MenuAjustesScreenState extends State<MenuAjustesScreen> {
  bool notificacionesActivas = true; // 🔔 Estado del switch de notificaciones

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ajustes'),
        backgroundColor: Colors.blue,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // 🔧 Switch de ejemplo
          SwitchListTile(
            title: const Text('Activar notificaciones'),
            subtitle: const Text('Recibe alertas de la comunidad'),
            value: notificacionesActivas,
            onChanged: (bool value) {
              setState(() {
                notificacionesActivas = value;
              });
              // 🧠 Aquí podrías guardar el estado en Firestore o localmente
            },
            secondary: const Icon(Icons.notifications_active),
          ),
        ],
      ),
    );
  }
}
