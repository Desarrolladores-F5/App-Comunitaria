// 📦 Importaciones necesarias
import 'package:flutter/material.dart';

class MenuSugerenciasScreen extends StatefulWidget {
  const MenuSugerenciasScreen({super.key});

  @override
  State<MenuSugerenciasScreen> createState() => _MenuSugerenciasScreenState();
}

class _MenuSugerenciasScreenState extends State<MenuSugerenciasScreen> {
  final TextEditingController _controladorMensaje = TextEditingController();
  bool _enviado = false;

  // 📨 Simula el envío del mensaje
  void _enviarSugerencia() {
    final texto = _controladorMensaje.text.trim();
    if (texto.isEmpty) return;

    setState(() => _enviado = true);

    // 🧪 Aquí podrías agregar lógica real para enviar la sugerencia (ej. Firestore, correo, etc.)
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _enviado = false;
        _controladorMensaje.clear();
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('✅ ¡Gracias por tu sugerencia!')),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sugerencias o Feedback'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              '¿Tienes alguna sugerencia o comentario? Escríbenos aquí:',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _controladorMensaje,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: 'Escribe tu mensaje... 📝',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _enviado ? null : _enviarSugerencia,
              icon: const Icon(Icons.send),
              label: const Text('Enviar'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
            )
          ],
        ),
      ),
    );
  }
}
