import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';

class PublicacionService {
  // 🔥 Instancias necesarias
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // 🧠 Método para subir una publicación
  Future<void> subirPublicacion(String mensaje, File? imagen) async {
    final uid = _auth.currentUser?.uid;

    if (uid == null) {
      throw Exception('Usuario no autenticado');
    }

    // 📄 Obtener datos del usuario (nombre)
    final userDoc = await _db.collection('usuarios').doc(uid).get();
    final nombre = userDoc.data()?['nombre'] ?? 'Anónimo';

    // 🕒 Fecha en formato legible
    final fecha = DateFormat('d MMMM yyyy', 'es_CL').format(DateTime.now());

    // 📤 Subir imagen si existe
    String? urlImagen;
    if (imagen != null) {
      final nombreArchivo = 'imagenes_publicaciones/${DateTime.now().millisecondsSinceEpoch}.jpg';
      final ref = _storage.ref().child(nombreArchivo);
      await ref.putFile(imagen);
      urlImagen = await ref.getDownloadURL();
    }

    // 🧾 Guardar en Firestore
    await _db.collection('publicaciones').add({
      'nombre': nombre,
      'mensaje': mensaje,
      'fecha': fecha,
      'urlImagen': urlImagen,
      'timestamp': FieldValue.serverTimestamp(), // Para ordenar
    });
  }
}
