import 'dart:async';

import 'package:carros/domain/carro.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DB {
  static final DB _instance = new DB.getInstance();

  factory DB() => _instance;

  DB.getInstance();

  static Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDB();
    return _db;
  }

  initDB() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'carros.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE carro (id INTEGER PRIMARY KEY, tipo TEXT, nome TEXT,"
        "desc TEXT, urlFoto TEXT, urlVideo TEXT, lat TEXT, lng TEXT)");
  }

  Future<int> saveCarro(Carro carro) async {
    var dbClient = await db;

    final sql =
        'INSERT or REPLACE INTO carro (id, tipo, nome, desc, urlFoto, urlVideo, lat, lng)'
        'VALUES(?,?,?,?,?,?,?,?)';

    return await dbClient.rawInsert(sql, [
      carro.id,
      carro.tipo,
      carro.nome,
      carro.desc,
      carro.urlFoto,
      carro.urlVideo,
      carro.latitude,
      carro.longitude
    ]);
  }

  Future<List<Carro>> getAllCarros() async {
    final dbClient = await db;
    final mapCarros = await dbClient.rawQuery('SELECT * FROM carro');
    return mapCarros.map<Carro>((json) => Carro.fromJson(json)).toList();
  }

  Future<Carro> getCarro(int id) async {
    final dbClient = await db;
    final result =
        await dbClient.rawQuery('SELECT * FROM carro WHERE id = ?', [id]);

    if (result.length > 0) {
      return new Carro.fromJson(result.first);
    }
    return null;
  }

  Future<int> getCount() async {
    final dbClient = await db;
    final result = await dbClient.rawQuery('SELECT COUNT(*) FROM carro');
    return Sqflite.firstIntValue(result);
  }

  Future<bool> exists(Carro carro) async {
    Carro c = await getCarro(carro.id);
    return c != null;
  }

  Future<int> deleteCarro(int id) async {
    final dbClient = await db;
    return await dbClient.rawDelete('DELETE FROM carro WHERE id = ?', [id]);
  }

  Future close() async {
    final dbClient = await db;
    return dbClient.close();
  }
}
