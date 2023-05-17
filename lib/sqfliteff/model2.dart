import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common/sqlite_api.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class BikinDataSq extends StatefulWidget {
  const BikinDataSq({Key? key}) : super(key: key);

  @override
  State<BikinDataSq> createState() => _BikinDataSqState();
}

class _BikinDataSqState extends State<BikinDataSq> {
  @override
  void initState() {
    // TODO: implement initState
    sqfliteFfiInit();
  }

  Future<Database> openWebDb() async {
    databaseFactory = databaseFactoryFfi;
    Database db = await openDatabase(inMemoryDatabasePath);

    await db.execute('''
    CREATE TABLE Karyawan (
    username VARCHAR PRIMARY KEY,
    password VARCHAR)''');
    await db.insert('Karyawan', <String, Object?>{'username': 'Uki', 'password' : 'uki'});

    var result = await db.query('Karyawan');
    print(result);

    // await db.close();
    return db;
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
