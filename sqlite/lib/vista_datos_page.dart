// Archivo: vista_datos_page.dart

import 'package:flutter/material.dart';
import 'package:sqlite/persona.dart';
import 'package:sqlite/database_helper.dart';

class VistaDatosPage extends StatelessWidget {
  // Lista de personas que se mostrarán en la vista
  final List<Persona> listaPersonas;
  // Instancia de DatabaseHelper para interactuar con la base de datos
  final DatabaseHelper dbHelper;

  // Constructor que recibe la lista de personas y la instancia de DatabaseHelper
  VistaDatosPage({required this.listaPersonas, required this.dbHelper});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Datos de Personas'), // Título de la barra de la aplicación
      ),
      body: ListView.builder(
        itemCount: listaPersonas.length, // Número de elementos en la lista
        itemBuilder: (context, index) {
          final persona = listaPersonas[index]; // Obtiene la persona en la posición actual
          return ListTile(
            // Muestra el nombre, apellidos y cédula de la persona
            title: Text('Nombre: ${persona.nombre}'),
            subtitle: Text(
              'Apellidos: ${persona.apellidos}\nCédula: ${persona.cedula}',
            ),
            trailing: IconButton(
              icon: Icon(Icons.delete), // Icono de eliminación
              onPressed: () async {
                if (persona.id != null) {
                  // Si el ID de la persona no es nulo, elimina la persona
                  await dbHelper.deletePersona(persona.id!); // Elimina la persona en la base de datos
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Persona eliminada'), // Muestra mensaje de persona eliminada
                    ),
                  );
                  // Obtiene la lista actualizada de personas
                  List<Persona> updatedList = await dbHelper.getPersonas();
                  // Redirige a VistaDatosPage con la lista actualizada
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => VistaDatosPage(listaPersonas: updatedList, dbHelper: dbHelper),
                    ),
                  );
                } else {
                  // Maneja el caso en el que persona.id es nulo
                  // Puede agregar lógica aquí si es necesario
                }
              },
            ),
          );
        },
      ),
    );
  }
}
