import 'package:sqflite/sqflite.dart'; // Importa el paquete sqflite para utilizar SQLite.
import 'package:path/path.dart'; // Importa el paquete path para manejar rutas de archivos.
import 'package:sqlite/persona.dart'; // Importa el modelo Persona.


//Declaración de la clase DatabaseHelper:
class DatabaseHelper {
  static Database? _database; // Variable estática que contendrá la referencia a la base de datos.
  static const String dbName = 'personas.db'; // Nombre de la base de datos.
  static const String tableName = 'personas'; // Nombre de la tabla en la base de datos.

  // Método para obtener la instancia de la base de datos.
  Future<Database> get database async {
    // Verifica si la base de datos ya está inicializada.
    if (_database != null) return _database!;

    // Si no está inicializada, la inicializa.
    _database = await initDatabase();
    return _database!;
  }

  // Método para inicializar la base de datos.
  Future<Database> initDatabase() async {
    // Obtiene la ruta de la base de datos en el dispositivo.
    String path = join(await getDatabasesPath(), dbName);

    // Abre la base de datos (crea si no existe).
    return await openDatabase(path, version: 1, onCreate: _createDatabase);
  }

  // Método para crear la tabla en la base de datos si no existe.
  void _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $tableName(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nombre TEXT,
        apellidos TEXT,
        cedula TEXT
      )
    ''');
  }

  // Método para insertar datos de Persona en la base de datos.
  Future<int> insertPersona(Persona persona) async {
    final db = await database;
    return await db.insert(tableName, persona.toMap());
  }

  // Método para obtener todos los datos de Persona desde la base de datos.
  Future<List<Persona>> getPersonas() async {
    final db = await database;
    final List<Map<String, dynamic>> personasMap = await db.query(tableName);

    // Convierte la lista de Mapas en una lista de objetos Persona.
    return List.generate(personasMap.length, (index) {
      return Persona.fromMap(personasMap[index]);
    });
  }

  // Método para eliminar una persona por su ID.
  Future<int> deletePersona(int id) async {
    final db = await database;
    return await db.delete(tableName, where: 'id = ?', whereArgs: [id]);
  }
}
