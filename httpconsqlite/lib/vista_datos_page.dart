// Archivo: vista_datos_page.dart

import 'package:flutter/material.dart';
import 'package:httpconsqlite/bitcoins.dart';
import 'package:httpconsqlite/database_helper.dart';

class VistaDatosPage extends StatelessWidget {
  // Lista de personas que se mostrarán en la vista
  final List<Bitcoins> listaBitcoins;
  // Instancia de DatabaseHelper para interactuar con la base de datos
  final DatabaseHelper dbHelper;

  // Constructor que recibe la lista de personas y la instancia de DatabaseHelper
  VistaDatosPage({required this.listaBitcoins, required this.dbHelper});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Datos de Bitcoins'), // Título de la barra de la aplicación
      ),
      body: ListView.builder(
        itemCount: listaBitcoins.length, // Número de elementos en la lista
        itemBuilder: (context, index) {
          final bitcoin = listaBitcoins[index]; // Obtiene la persona en la posición actual
          return ListTile(
            // Muestra el nombre y el precio del bitcoin
            title: Text('Nombre: ${bitcoin.nombre}'),
            subtitle: Text(
              'Precio: ${bitcoin.precio}',
            ),
            trailing: IconButton(
              icon: Icon(Icons.delete), // Icono de eliminación
              onPressed: () async {
                if (bitcoin.id != null) {
                  // Si el ID de la persona no es nulo, elimina la persona
                  await dbHelper.deleteBitcoin(bitcoin.id!); // Elimina la persona en la base de datos
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Cryptomoneda eliminada'), // Muestra mensaje de persona eliminada
                    ),
                  );
                  // Obtiene la lista actualizada de personas
                  List<Bitcoins> updatedList = await dbHelper.getBitcoins();
                  // Redirige a VistaDatosPage con la lista actualizada
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => VistaDatosPage(listaBitcoins: updatedList, dbHelper: dbHelper),
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