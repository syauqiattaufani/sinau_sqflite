import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

Future<Database> openWebDb() async {
  databaseFactory = databaseFactoryFfi;
  Database db = await openDatabase('/assets/users.db');
  return db;
}