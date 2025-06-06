// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get tituloApp => 'App Comunitaria';

  @override
  String bienvenida(Object nombre) {
    return 'Hola, $nombre 👋';
  }

  @override
  String direccion(Object direccion) {
    return 'Dirección: $direccion';
  }
}
