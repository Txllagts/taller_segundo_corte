
/*Esta página muestra un formulario para agregar personas. 
Contiene TextFormField para ingresar el nombre, apellidos y cédula de una persona.
 Al presionar el botón "Agregar Persona", se agregará una nueva persona a la lista 
 y se almacenará en la base de datos.*/

import 'package:flutter/material.dart';
import 'package:sqlite/persona.dart';
import 'package:sqlite/vista_datos_page.dart';
import 'package:sqlite/database_helper.dart';

class FormularioPage extends StatefulWidget {
  @override
  _FormularioPageState createState() => _FormularioPageState();
}

class _FormularioPageState extends State<FormularioPage> {
  // Controladores de texto para los campos del formulario
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController apellidosController = TextEditingController();
  final TextEditingController cedulaController = TextEditingController();
  
  // Instancia de DatabaseHelper para interactuar con la base de datos
  final DatabaseHelper dbHelper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold( // Crea una estructura base de la pantalla
      appBar: AppBar(
        title: Text('Formulario de Persona'), // Define el título de la barra superior
      ),
      body: SingleChildScrollView( // Envuelve el formulario para permitir desplazamiento
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField( // Campo para ingresar el nombre
                controller: nombreController,
                decoration: InputDecoration(labelText: 'Nombre'),
              ),
              TextFormField( // Campo para ingresar los apellidos
                controller: apellidosController,
                decoration: InputDecoration(labelText: 'Apellidos'),
              ),
              TextFormField( // Campo para ingresar la cédula
                controller: cedulaController,
                decoration: InputDecoration(labelText: 'Cédula'),
              ),
              SizedBox(height: 20), // Espacio vertical entre los campos y los botones
              ElevatedButton(
                onPressed: () async {
                  // Lógica para agregar una persona a la base de datos
                  if (nombreController.text.isNotEmpty &&
                      apellidosController.text.isNotEmpty &&
                      cedulaController.text.isNotEmpty) {
                    await dbHelper.insertPersona(Persona(
                      nombre: nombreController.text,
                      apellidos: apellidosController.text,
                      cedula: cedulaController.text,
                    ));
                    nombreController.clear(); // Limpia el campo de nombre
                    apellidosController.clear(); // Limpia el campo de apellidos
                    cedulaController.clear(); // Limpia el campo de cédula
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Persona agregada correctamente'), // Mensaje de éxito al agregar la persona
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Por favor, completa todos los campos'), // Mensaje si los campos están vacíos
                      ),
                    );
                  }
                },
                child: Text('Agregar Persona'), // Texto en el botón para agregar una persona
              ),
              ElevatedButton(
                onPressed: () async {
                  // Lógica para ver los datos de las personas en una nueva vista
                  List<Persona> personas = await dbHelper.getPersonas();
                  Navigator.push( // Navega a la página VistaDatosPage para ver los datos
                    context,
                    MaterialPageRoute(
                      builder: (context) => VistaDatosPage(listaPersonas: personas, dbHelper: dbHelper),
                    ),
                  );
                },
                child: Text('Ver Datos'), // Texto en el botón para ver datos existentes
              ),
            ],
          ),
        ),
      ),
    );
  }
}
