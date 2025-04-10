import 'package:flutter/material.dart';
import 'package:httpconsqlite/bitcoins.dart';
import 'package:httpconsqlite/database_helper.dart';

class VistaDatosPage extends StatefulWidget {
  final DatabaseHelper dbHelper;

  VistaDatosPage({required this.dbHelper});

  @override
  _VistaDatosPageState createState() => _VistaDatosPageState();
}

class _VistaDatosPageState extends State<VistaDatosPage> {
  List<Bitcoins> listaBitcoins = [];

  @override
  void initState() {
    super.initState();
    cargarBitcoins();
  }

  Future<void> cargarBitcoins() async {
    final datos = await widget.dbHelper.getBitcoins();
    setState(() {
      listaBitcoins = datos;
    });
  }

  Future<void> eliminarBitcoin(int id) async {
    await widget.dbHelper.deleteBitcoin(id);
    await cargarBitcoins();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Cryptomoneda eliminada')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Datos de Criptomonedas'),
      ),
      body: ListView.builder(
        itemCount: listaBitcoins.length,
        itemBuilder: (context, index) {
          final bitcoin = listaBitcoins[index];
          return ListTile(
            title: Text('Nombre: ${bitcoin.nombre}'),
            subtitle: Text('Precio: ${bitcoin.precio}'),
            trailing: IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: () async {
                if (bitcoin.id != null) {
                  await eliminarBitcoin(bitcoin.id!);
                }
              },
            ),
          );
        },
      ),
    );
  }
}