import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseConnection {
  setDatabase() async {
    var directory = await getDatabasesPath();
    var path = join(directory, 'db');
    var database = await openDatabase(
      path,
      version: 2,
      onCreate: _onCreatingDatabase,
      onUpgrade: _onUpgradingDatabase,
    );
    return database;
  }

  _onCreatingDatabase(Database database, int version) async {
    await database.execute('''
        CREATE TABLE registros(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        id_recibo TEXT,
        id_user INTEGER,
        nome_motorista TEXT,
        empresa TEXT,
        nome_func1 TEXT,
        nome_func2 TEXT,
        matricula_func1 TEXT,
        matricula_func2 TEXT,
        setor_func1 TEXT,
        setor_func2 TEXT,
        data TEXT,
        hora_inicial TEXT,
        hora_final TEXT,
        km_inicial TEXT,
        km_final TEXT,
        km_percorrido TEXT,
        origem TEXT,
        destino TEXT,
        pedagio INTEGER,
        valor_total TEXT,
        url_imagem TEXT
        )''');

    await database.execute('''
        CREATE TABLE empresas(
        empresa TEXT,
        email TEXT
        )''');

    await database.execute('''
        CREATE TABLE funcionarios(
        uc TEXT,
        matricula TEXT,
        nome TEXT,
        chefe TEXT
        )''');
  }

  _onUpgradingDatabase(Database database, int oldVersion, int version) async {
    if (oldVersion == 1) {
      await database.execute('''
        CREATE TABLE funcionarios(
        uc TEXT,
        matricula TEXT,
        nome TEXT,
        chefe TEXT
        )''');
    }
  }

  Future<List<Map<String, dynamic>>> getAllDataReversed(int id) async {
    Database db = await setDatabase();
    var lista = await db.rawQuery("SELECT * FROM registros WHERE id_user = ?", [id]);
    return lista.reversed.toList();
  }

  Future<List<Map<String, dynamic>>> getFuncionarios() async {
    Database db = await setDatabase();
    var lista = await db.rawQuery("SELECT * FROM funcionarios");
    return lista.toList();
  }
}
