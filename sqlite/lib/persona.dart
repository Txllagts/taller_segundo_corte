
/*Este código define la clase Persona, que representa una entidad 
con información de una persona. Tiene un constructor para crear objetos Persona,
 un constructor de fábrica para crear una persona a partir de un Map y un método 
 para convertir un objeto Persona a un Map.*/


class Persona {
  final int? id; // Id de la persona, puede ser nulo.
  final String nombre; // Nombre de la persona.
  final String apellidos; // Apellidos de la persona.
  final String cedula; // Cédula de la persona.

  // Constructor de la clase Persona.
  Persona({
    this.id, // El id puede ser nulo.
    required this.nombre, // El nombre es obligatorio.
    required this.apellidos, // Los apellidos son obligatorios.
    required this.cedula, // La cédula es obligatoria.
  });

  // Constructor de fábrica para crear una Persona desde un Map.
  factory Persona.fromMap(Map<String, dynamic> json) {
    return Persona(
      id: json["id"], // Asigna el id desde el mapa.
      nombre: json["nombre"], // Asigna el nombre desde el mapa.
      apellidos: json["apellidos"], // Asigna los apellidos desde el mapa.
      cedula: json["cedula"], // Asigna la cédula desde el mapa.
    );
  }

  // Método para convertir una Persona a un Map.
  Map<String, dynamic> toMap() {
    return {
      if (id != null) "id": id, // Si el id no es nulo, añade el id al mapa.
      "nombre": nombre, // Añade el nombre al mapa.
      "apellidos": apellidos, // Añade los apellidos al mapa.
      "cedula": cedula, // Añade la cédula al mapa.
    };
  }
}
