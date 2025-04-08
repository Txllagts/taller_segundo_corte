class Bitcoins {
  final int? id; // Id de la persona, puede ser nulo.
  final String nombre; // Nombre del bitcoin.
  final String precio; // Precio del bitcoin.

  // Constructor de la clase Bitcoins
  Bitcoins({
    this.id, // El id puede ser nulo.
    required this.nombre, // El nombre es obligatorio.
    required this.precio, // El precio es obligatorio.
  });


  factory Bitcoins.fromMap(Map<String, dynamic> json) {
    return Bitcoins(
      id: json["id"], // Asigna el id desde el mapa.
      nombre: json["nombre"], // Asigna el nombre desde el mapa.
      precio: json["precio"], // Asigna el precio desde el mapa.
    );
  }

  // Método para convertir una Persona a un Map.
  Map<String, dynamic> toMap() {
    return {
      if (id != null) "id": id, // Si el id no es nulo, añade el id al mapa.
      "nombre": nombre, // Añade el nombre al mapa.
      "apellidos": precio, // Añade el precio al mapa.
    };
  }
