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
        email_motorista TEXT,
        empresa TEXT,
        nome_func1 TEXT,
        matricula_func1 TEXT,
        nome_func2 TEXT,
        matricula_func2 TEXT,
        nome_func3 TEXT,
        matricula_func3 TEXT,
        nome_func4 TEXT,
        matricula_func4 TEXT,
        data TEXT,
        hora_inicial TEXT,
        hora_final TEXT,
        km_inicial TEXT,
        km_final TEXT,
        km_percorrido TEXT,
        origem TEXT,
        destino TEXT,
        pedagio INTEGER,
        observacao TEXT,
        url_imagem TEXT
        )''');

    await database.execute('''
        CREATE TABLE empresas(
        empresa TEXT,
        email TEXT
        )''');

    await database.execute('''
        CREATE TABLE funcionarios(
        matricula TEXT,
        nome TEXT
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

  Future<List<Map<String, dynamic>>> getAllDataReversed(String id) async {
    Database db = await setDatabase();
    var lista = await db.rawQuery("SELECT * FROM registros WHERE email_motorista = ?", [id]);
    return lista.reversed.toList();
  }

  Future<List<Map<String, dynamic>>> getFuncionarios() async {
    Database db = await setDatabase();
    var lista = await db.rawQuery("SELECT * FROM funcionarios");
    return lista.toList();
  }
}
