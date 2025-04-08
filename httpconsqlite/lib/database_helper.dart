import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:httpconsqlite/bitcoins.dart';

class DatabaseHelper{
  static Database? _database;
  static const String dbName = 'bitcoins.db';
  static const String tableName = 'bitcoins';

  Future<Database> get database async {
    if(_database != null) return _database!;

    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), dbName);

    return await openDatabase(path, version: 1, onCreate: _createDatabase);
  }

  void _createDatabase(Database db, int version) async {
    await db.execute('''
    CREATE TABLE $tableName(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre TEXT,
    precio TEXT
    )
    ''');
  }

  // Método para insertar datos de Persona en la base de datos.
  Future<int> insertBitcoin(Bitcoins bitcoin) async {
    final db = await database;
    return await db.insert(tableName, bitcoin.toMap());
  }

  // Método para obtener todos los datos de Persona desde la base de datos.
  Future<List<Bitcoins>> getBitcoins() async {
    final db = await database;
    final List<Map<String, dynamic>> bitcoinsMap = await db.query(tableName);

    // Convierte la lista de Mapas en una lista de objetos Persona.
    return List.generate(bitcoinsMap.length, (index) {
      return Bitcoins.fromMap(bitcoinsMap[index]);
    });
  }

  // Método para eliminar una persona por su ID.
  Future<int> deleteBitcoin(int id) async {
    final db = await database;
    return await db.delete(tableName, where: 'id = ?', whereArgs: [id]);
  }
}