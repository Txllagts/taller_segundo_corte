import 'package:flutter/material.dart'; // Importa el paquete Flutter para widgets de Material Design
import 'package:dio/dio.dart'; // Importa el paquete para realizar solicitudes HTTP
import 'package:httpconsqlite/database_helper.dart';
import 'package:httpconsqlite/bitcoins.dart';
import 'dart:async'; // Importa el paquete para utilizar objetos relacionados con el tiempo (Timer)

void main() {
  runApp(MyApp()); // Inicializa la aplicación con el widget MyApp
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(), // Establece el tema oscuro de la aplicación
      home: MyHomePage(), // Establece MyHomePage como la pantalla principal
      debugShowCheckedModeBanner: false, // Oculta el banner de depuración
    );
  }
}

class CryptoPrice {
  final String name; // Nombre de la criptomoneda
  final String imagePath; // Ruta de la imagen de la criptomoneda
  final String price; // Precio de la criptomoneda

  CryptoPrice({required this.name, required this.imagePath, required this.price}); // Constructor de CryptoPrice
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState(); // Crea el estado de la pantalla principal
}

class _MyHomePageState extends State<MyHomePage> {
  Dio dio = Dio(); // Instancia de la clase Dio para realizar solicitudes HTTP
  List<CryptoPrice> cryptoPrices = []; // Lista para almacenar la información de las criptomonedas
  int refreshIntervalInSeconds = 60; // Intervalo de actualización en segundos


  @override
  void initState() {
    super.initState();
    fetchData(); // Llama a fetchData al inicio

    // Establece un Timer para actualizar los datos periódicamente
    Timer.periodic(Duration(seconds: refreshIntervalInSeconds), (Timer t) {
      fetchData(); // Llama a fetchData en intervalos regulares definidos por refreshIntervalInSeconds
    });
  }

  void fetchData() async {
    try {
      Response response = await dio.get(
          'https://api.coingecko.com/api/v3/simple/price?ids=bitcoin,ethereum,ripple,litecoin&vs_currencies=usd');
      Map<String, dynamic> cryptoData = response.data;
      setState(() {
        cryptoPrices = [
          // Crea objetos CryptoPrice con información obtenida y los agrega a la lista cryptoPrices
          CryptoPrice(name: 'Bitcoin', imagePath: 'assets/images/bitcoin.png', price: cryptoData['bitcoin']['usd'].toString()),

        ];
      });
    } catch (error) {
      setState(() {
        // En caso de error al cargar los datos, muestra un objeto CryptoPrice con información de error
        cryptoPrices = [
          CryptoPrice(name: 'Error', imagePath: 'assets/images/error.png', price: 'Error al cargar datos')
        ];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Precios de Criptomonedas')), // Barra de aplicación con un título
      body: ListView.builder(
        itemCount: cryptoPrices.length, // Número de elementos en la lista
        itemBuilder: (BuildContext context, int index) {
          return Card(
            elevation: 4, // Elevación de la tarjeta
            margin: EdgeInsets.all(8), // Márgenes alrededor de la tarjeta
            child: ListTile(
              leading: Image.asset(
                cryptoPrices[index].imagePath, // Ruta de la imagen de la criptomoneda
                width: 40,
                height: 40,
              ),
              title: Text('${cryptoPrices[index].name}'), // Nombre de la criptomoneda
              trailing: Text('\$${cryptoPrices[index].price}'), // Precio de la criptomoneda
            ),


          );
        },
      ),
    );
  }
}
