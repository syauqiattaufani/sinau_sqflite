import 'dart:async';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sinau_sqflite/buka_database/product3.dart';
import 'package:sinau_sqflite/buka_database/company_model.dart';
import 'package:sinau_sqflite/buka_database/product4.dart';
import 'package:sinau_sqflite/sqfliteff/model.dart';
import 'package:sqflite_common/sqlite_api.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'dart:io' as io;

class DBHelper3 {
  final String _databaseName = 'users.db';
  final String table = 'cashier_dbf';
  final int _databaseVersion = 1;

  static Database? _db;

  Future<Database?> get db async {
    if (_db != null) return _db;
    _db = await sqfliteFfiInit();
    return _db;
  }

  Future<Database?> sqfliteFfiInit() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();

    String path = join(documentsDirectory.path, 'users.db');
    DatabaseFactory databaseFactory = databaseFactoryFfi;
    bool dbExists = await io.File(path).exists();

    if (!dbExists) {
      // Copy from asset
      ByteData data = await rootBundle.load(join("assets", "users.db"));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      // Write and flush the bytes written
      await io.File(path).writeAsBytes(bytes, flush: true);
    }
    if (_db == null) {
      _db = await databaseFactory.openDatabase(path,
          options: OpenDatabaseOptions(
            version: 1,
            onCreate: (db, version) => _createDb(db),
          ));
    }
    return _db!;
  }

  static void _createDb(Database db) async {
    await db.execute(
        'CREATE TABLE mytable(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, value TEXT)');
  }

  //read database
  Future<List<Product3>> getEmployees3() async {
    var dbClient = await db;
    List<Map> list =
        await dbClient!.rawQuery('SELECT code, hex(pass) FROM cashier_dbf');
    List<Product3> employees = [];
    for (int i = 0; i < list.length; i++) {
      employees.add(new Product3(list[i]["code"], list[i]["pass"]));
    }

    // Product3.productList3.map((e) {
    //   e.code;
    // });
    // return Product3.productList3;
    return employees;
  }

  Future<List<Company>> getEmployees4() async {
    var dbClient = await db;
    List<Map> list =
        await dbClient!.rawQuery('SELECT name, value FROM mytable');
    List<Company> employees = [];
    for (int i = 0; i < list.length; i++) {
      employees
          .add(new Company(list[i]["id"], list[i]["name"], list[i]["value"]));
    }
    return employees;
  }

  Future<Product3?> getLoginUser(String code, String password) async {
    var dbClient = await db;
    var res = await dbClient!.rawQuery("SELECT code FROM cashier_dbf WHERE code = '$code' and pass = '$password'");
    // var abcd = await dbClient!.query("cashier_dbf");
    // var res = await dbClient?.query("cashier_dbf", where: "code = ", whereArgs: [code]);
    // String abc = "SELECT code FROM cashier_dbf WHERE code = $code";
    // var res = await dbClient!.query("cashier_dbf");
    if(res.length > 0) {
      return Product3.fromMap(res.first);
    }

    return null;
  }

  Future<Product3?> valCode(String code) async {
    var dbClient = await db;
    var res = await dbClient!.rawQuery("SELECT * FROM cashier_dbf WHERE code = '$code'");
    // var abcd = await dbClient!.query("cashier_dbf");
    // var res = await dbClient?.query("cashier_dbf", where: "code = ", whereArgs: [code]);
    // String abc = "SELECT code FROM cashier_dbf WHERE code = $code";
    // var res = await dbClient!.query("cashier_dbf");
    if(res.length > 0) {
      return Product3.fromMap(res.first);
    }
    // return res!.isNotEmpty ? Product4.fromMap(res.first) : Null;
    return null;
  }

  Future<Product3?> valPass(String pass) async {
    var dbClient = await db;
    var res = await dbClient!.rawQuery("SELECT code FROM cashier_dbf WHERE pass = '$pass'");
    // var abcd = await dbClient!.query("cashier_dbf");
    // var res = await dbClient?.query("cashier_dbf", where: "code = ", whereArgs: [code]);
    // String abc = "SELECT code FROM cashier_dbf WHERE code = $code";
    // var res = await dbClient!.query("cashier_dbf");
    if(res.length > 0) {
      return Product3.fromMap(res.first);
    }
    // return res!.isNotEmpty ? Product4.fromMap(res.first) : Null;
    return null;
  }

  //create data
  Future<int> insert(Map<String, dynamic> row) async {
    Database? _db = await sqfliteFfiInit();
    final query = await _db!.insert(table, row);
    return query;
  }

  Future<int> insert2(Map<String, dynamic> row) async {
    Database? _db = await sqfliteFfiInit();
    final query = await _db!.insert('mytable', row);
    return query;
  }

  //delete
  Future<int> delete(String id) async {
    Database? _db = await sqfliteFfiInit();
    final query = await _db!.delete(table, where: 'code = ?', whereArgs: [id]);
    return query;
  }

  Future<int> delete2(String idparams) async {
    Database? _db = await sqfliteFfiInit();
    final query =
        await _db!.delete('mytable', where: 'value = ?', whereArgs: [idparams]);
    return query;
  }

  //update
  Future<int> update(String idparams, Map<String, dynamic> row) async {
    final query =
        await _db!.update(table, row, where: 'code = ?', whereArgs: [idparams]);
    return query;
  }

  Future<int> update2(String idparams, Map<String, dynamic> row) async {
    final query = await _db!
        .update('mytable', row, where: 'value = ?', whereArgs: [idparams]);
    return query;
  }
}
