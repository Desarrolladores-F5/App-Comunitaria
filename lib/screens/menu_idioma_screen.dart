import 'package:flutter/material.dart';

class MenuIdiomaScreen extends StatefulWidget {
  const MenuIdiomaScreen({super.key});

  @override
  State<MenuIdiomaScreen> createState() => _MenuIdiomaScreenState();
}

class _MenuIdiomaScreenState extends State<MenuIdiomaScreen> {
  String _idiomaSeleccionado = 'es'; // 'es' para español, 'en' para inglés

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Seleccionar idioma'),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          RadioListTile<String>(
            title: const Text('Español'),
            value: 'es',
            groupValue: _idiomaSeleccionado,
            onChanged: (value) {
              setState(() => _idiomaSeleccionado = value!);
              // Aquí se aplicaría lógica para cambiar el idioma (en futuras versiones)
            },
          ),
          RadioListTile<String>(
            title: const Text('English'),
            value: 'en',
            groupValue: _idiomaSeleccionado,
            onChanged: (value) {
              setState(() => _idiomaSeleccionado = value!);
              // Lo mismo aquí
            },
          ),
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              '⚠️ Esta función es decorativa por ahora. El cambio de idioma se aplicará en futuras versiones.',
              style: TextStyle(color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}
