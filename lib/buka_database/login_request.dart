import 'package:sinau_sqflite/buka_database/product3.dart';
import 'package:sinau_sqflite/buka_database/product4.dart';
import 'login_ctr.dart';

class LoginRequest {
  LoginCtr con = new LoginCtr();
  Future<Product4?> getLogin(String username, String password) {
    var result = con.getLogin(username, password);
    return result;
  }
}