// Archivo: main.dart

import 'package:flutter/material.dart';
import 'package:sqlite/formulario_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mi App con Formulario y SQLite', // Título de la aplicación
      theme: ThemeData(
        primarySwatch: Colors.blue, // Define el color principal de la aplicación
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: FormularioPage(), // Define la página inicial de la aplicación como FormularioPage
    );
  }
}