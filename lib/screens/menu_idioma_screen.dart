// 📦 Importaciones necesarias
import 'package:flutter/material.dart';
import 'package:app_comunitaria/l10n/app_localizations.dart'; // 🌐 Traducciones
import '../main.dart'; // 💡 Importa MyApp para usar su método setLocale

class MenuIdiomaScreen extends StatefulWidget {
  const MenuIdiomaScreen({super.key});

  @override
  State<MenuIdiomaScreen> createState() => _MenuIdiomaScreenState();
}

class _MenuIdiomaScreenState extends State<MenuIdiomaScreen> {
  // 🌐 Idioma actualmente seleccionado. Inicialmente "es"
  String _idiomaSeleccionado = 'es';

  // 🌐 Función para cambiar el idioma real desde cualquier lugar de la app
  void _cambiarIdioma(String codigoIdioma) {
    // 🔍 Busca el estado de MyApp, donde está definido setLocale
    final myAppState = MyApp.of(context);
    if (myAppState != null) {
      myAppState.setLocale(Locale(codigoIdioma)); // 🌍 Aplica el idioma
    }
  }

  @override
  Widget build(BuildContext context) {
    final tr = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(tr.tituloApp), // Puedes cambiar esto si quieres un título localizable
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          // 🌐 Opción Español
          RadioListTile<String>(
            title: const Text('Español'),
            value: 'es',
            groupValue: _idiomaSeleccionado,
            onChanged: (value) {
              if (value != null) {
                setState(() => _idiomaSeleccionado = value);
                _cambiarIdioma(value);
              }
            },
          ),

          // 🌐 Opción Inglés
          RadioListTile<String>(
            title: const Text('English'),
            value: 'en',
            groupValue: _idiomaSeleccionado,
            onChanged: (value) {
              if (value != null) {
                setState(() => _idiomaSeleccionado = value);
                _cambiarIdioma(value);
              }
            },
          ),

          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              '🌍 Este menú permite cambiar dinámicamente el idioma de la app.',
              style: TextStyle(color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
