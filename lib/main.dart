import 'package:flutter/material.dart';
import 'data/app_database.dart';
import 'screens/tareas_page.dart';

void main() {
  runApp(GestorTareasApp(database: AppDatabase()));
}

/// Punto de entrada de la aplicación.
class GestorTareasApp extends StatelessWidget {
  const GestorTareasApp({super.key, required this.database});

  final AppDatabase database;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gestor de tareas',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 233, 80, 20)),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 113, 13, 131),
          foregroundColor: Colors.white,
        ),
        useMaterial3: true,
      ),
      home: TareasPage(database: database),
    );
  }
}