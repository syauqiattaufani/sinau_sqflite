import 'dart:async';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sinau_sqflite/sqfliteff/model.dart';
import 'package:sqflite_common/sqlite_api.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'dart:io' as io;

class DBHelper {
  Database?_db;
  //
  Future<Database?> get db async {
    if (_db != null) return _db;
    _db = await initDb();
    return _db;
  }

  initDb() async {
    sqfliteFfiInit();
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "users.db");
    bool dbExists = await io.File(path).exists();

    if (!dbExists) {
      // Copy from asset
      ByteData data = await rootBundle.load(join("assets", "users.db"));
      List<int> bytes =
      data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      // Write and flush the bytes written
      await io.File(path).writeAsBytes(bytes, flush: true);
    }
    var theDb = await openDatabase(path,version: 1);

    return theDb;
  }


  Future<List<Employee>> getEmployees() async {
      var dbClient = await db;
      List<Map> list = await dbClient!.rawQuery('SELECT code, pass FROM cashier_dbf');
      List<Employee> employees = [];
      for (int i = 0; i < list.length; i++) {
        employees.add(new Employee(list[i]["code"], list[i]["pass"]));
      }
      return employees;
    }

}