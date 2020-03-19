import 'dart:io';
import 'package:path/path.dart';

import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

import 'package:qrapp/src/models/scan_model.dart';
export 'package:qrapp/src/models/scan_model.dart';


class DBProvider {
  //aplicando el patron singleton

  static Database _database;
  // igualando un constructor privado
  static final DBProvider db = DBProvider._();

  //constructor vacio
  DBProvider._();

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await initDB();
    return _database;
  }

  initDB() async {
    // el path de donde se encuentra nuestar base de datos
    Directory documentsDirectory = await getApplicationDocumentsDirectory();

    String path = join(documentsDirectory.path, 'ScansDb.db');

    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute('CREATE TABLE scans ('
          'id INTEGER PRIMARY KEY,'
          'tipo TEXT,'
          'valor TEXT'
          ')');
    });
  }

//metodos para crear resigstros de la base de datoos
  nuevoScanRaw(ScanModel nuevoScan) async {
    final db = await database;

    final res = await db.rawInsert("INSERT INTO scans (id,tipo,valor) "
        " VALUES (${nuevoScan.id},${nuevoScan.tipo},${nuevoScan.valor})");
    return res;
  }

  nuevaScanc(ScanModel nuevoScan) async {
    final db = await database;

    final res = db.insert('scans', nuevoScan.toJson());

    return res;
  }

// select obtener informacion
  Future<ScanModel> getScanId(int id) async {
    final db = await database;

    final res = await db.query('scans', where: 'id = ?', whereArgs: [id]);

    return res.isNotEmpty ? ScanModel.fromJson(res.first) : null;
  }

  //get todos los scans
  Future<List<ScanModel>> getTodosScans() async {
    final db = await database;

    final res = await db.query('scans');

    List<ScanModel> list =
        res.isNotEmpty ? res.map((s) => ScanModel.fromJson(s)).toList() : [];

    return list;
  }

  Future<List<ScanModel>> getScansPorTipo(String tipo) async {
    final db = await database;

    final res = await db.rawQuery("SELECT * FROM Scans WHERE tipo = '$tipo'");

    List<ScanModel> list =
        res.isNotEmpty ? res.map((s) => ScanModel.fromJson(s)).toList() : [];

    return list;
  }

  //actualizar los resigstros

  updateScanN(ScanModel nuevoScan) async {

    final db = await database;

    final res = await db.update('scans', nuevoScan.toJson(), where: 'id= ? ',whereArgs:[nuevoScan.id] );

    return res;
  }

  // Eliminar los registros

  deleteScan(int id) async{
    final db= await database;
    final res = await db.delete('scans',where: 'id=?',whereArgs: [id]);

    return res;
  }

  // Eliminar los registros

  deleteAll() async{
    final db= await database;
    final res = await db.rawDelete('DELETE FROM scans');

    return res;
  }
}
