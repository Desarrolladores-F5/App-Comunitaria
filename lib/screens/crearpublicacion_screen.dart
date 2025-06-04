// 📦 Importaciones necesarias
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // 📷 Para seleccionar imágenes
import 'dart:io';
import '../services/publicacion_service.dart'; // 🧠 Servicio para subir publicaciones

class CrearPublicacionScreen extends StatefulWidget {
  const CrearPublicacionScreen({super.key});

  @override
  State<CrearPublicacionScreen> createState() => _CrearPublicacionScreenState();
}

class _CrearPublicacionScreenState extends State<CrearPublicacionScreen> {
  final TextEditingController _mensajeController = TextEditingController();
  File? _imagenSeleccionada;
  bool _publicando = false;

  // 🖼 Método para seleccionar imagen desde galería
  Future<void> _seleccionarImagen() async {
    final picker = ImagePicker();
    final XFile? imagen = await picker.pickImage(source: ImageSource.gallery);

    if (imagen != null) {
      setState(() {
        _imagenSeleccionada = File(imagen.path);
      });
    }
  }

  // 🚀 Método para publicar usando el servicio
  Future<void> _publicar() async {
    final mensaje = _mensajeController.text.trim();

    if (mensaje.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Escribe un mensaje antes de publicar.')),
      );
      return;
    }

    setState(() => _publicando = true);

    try {
      await PublicacionService().subirPublicacion(mensaje, _imagenSeleccionada);
      if (context.mounted) Navigator.pop(context); // 👈 Volver al Home después de publicar
    } catch (e) {
      setState(() => _publicando = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al publicar: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nueva Publicación'),
        backgroundColor: Colors.blue,
        actions: [
          TextButton(
            onPressed: _publicando ? null : _publicar,
            child: const Text(
              'Publicar',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.purple[50],
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 📝 Campo de texto
            TextField(
              controller: _mensajeController,
              maxLines: 4,
              decoration: const InputDecoration(
                hintText: '¿Qué estás pensando?',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),

            // 📷 Botón para imagen
            ElevatedButton.icon(
              onPressed: _seleccionarImagen,
              icon: const Icon(Icons.image),
              label: const Text('Agregar imagen desde galería'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple[100],
                foregroundColor: Colors.black87,
              ),
            ),

            if (_imagenSeleccionada != null) ...[
              const SizedBox(height: 10),
              Image.file(_imagenSeleccionada!, height: 200),
            ],
          ],
        ),
      ),
    );
  }
}
