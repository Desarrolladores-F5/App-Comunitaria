// 📦 Importaciones necesarias
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart'; // 📡 Para detectar conexión
import 'package:package_info_plus/package_info_plus.dart'; // ℹ️ Info de la app

class MenuEstadoAppScreen extends StatefulWidget {
  const MenuEstadoAppScreen({super.key});

  @override
  State<MenuEstadoAppScreen> createState() => _MenuEstadoAppScreenState();
}

class _MenuEstadoAppScreenState extends State<MenuEstadoAppScreen> {
  String _conexion = 'Desconocida';
  String _version = '';
  String _nombreApp = '';
  String _idPaquete = '';

  @override
  void initState() {
    super.initState();
    obtenerEstado();
  }

  // 🚀 Función para obtener conectividad + versión de la app
  Future<void> obtenerEstado() async {
    // Verifica conexión
    final connectivityResult = await Connectivity().checkConnectivity();
    setState(() {
      _conexion = connectivityResult == ConnectivityResult.mobile
          ? 'Móvil 📶'
          : connectivityResult == ConnectivityResult.wifi
              ? 'WiFi 📡'
              : 'Sin conexión ❌';
    });

    // Obtiene info de la app
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _nombreApp = info.appName;
      _version = '${info.version} (build ${info.buildNumber})';
      _idPaquete = info.packageName;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Estado de la App'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('📱 Información general', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text('Nombre de la App: $_nombreApp'),
            Text('Versión: $_version'),
            Text('ID del paquete: $_idPaquete'),
            const SizedBox(height: 30),
            const Text('🌐 Conectividad actual', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text('Estado de conexión: $_conexion'),
            const Spacer(),
            const Text(
              'Este módulo muestra información útil sobre la app y su conexión actual.',
              style: TextStyle(color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
