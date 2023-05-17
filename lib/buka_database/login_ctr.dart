import 'dart:async';
import 'dart:math';
import 'package:sinau_sqflite/pos/db_helper3.dart';
import 'package:sinau_sqflite/buka_database/product3.dart';
import 'package:sinau_sqflite/buka_database/product4.dart';

class LoginCtr {
  DBHelper3 con = new DBHelper3();
//insertion
  Future<int> saveUser(Product4 code) async {
    var dbClient = await con.sqfliteFfiInit();
    int res = await dbClient!.insert("code", code.toMap());
    return res;
  }
  //deletion
  Future<int> deleteUser(Product4 code) async {
    var dbClient = await con.sqfliteFfiInit();
    int res = await dbClient!.delete("Code");
    return res;
  }

  Future<Product4?> getLogin(String code, String password) async {
    var dbClient = await con.db;
    var res = await dbClient!.rawQuery("SELECT * FROM cashier_dbf WHERE code = '$code' and pass = '$password");
    // var abcd = await dbClient!.query("cashier_dbf");
    // var res = await dbClient?.query("cashier_dbf", where: "code = ", whereArgs: [code]);
    if(res.length > 0) {
      return new Product4.fromMap(res.first);
    }
    // return res!.isNotEmpty ? Product4.fromMap(res.first) : Null;
    // final List<Map<String, Object?>> queryResult = await dbClient!.query('cashier_dbf', where: "code = $code");
    // return queryResult.map((e) => Product4.fromMap(e)).toList();
    return null;
  }

  // Future<List<Product4?>> getAllUser() async {
  //   var dbClient = await con.sqfliteFfiInit();
  //   var res = await dbClient!.query("cashier_dbf");
  //
  //   List<Product4> list =
  //   res.isNotEmpty ? res.map((c) => Product4.fromMap(c)).toList() : null;
  //   return list;
  // }
}
