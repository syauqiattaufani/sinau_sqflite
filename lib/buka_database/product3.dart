// class Product3 {
//   String? code;
//   String? pass;
//
//   Product3(this.code, this.pass);
//
//   Map<String, dynamic> toMap() {
//     var map = <String, dynamic>{
//       'code': code,
//       'pass':pass
//     };
//     return map;
//   }
//
//   Product3.fromMap(Map<String, dynamic> map){
//     code = map['code'];
//     pass = map['pass'];
//   }
// }

class Product3 {
  String? code;
  String? pass;

  Product3(this.code, this.pass);

  Product3.fromMap(Map<String, dynamic> map){
    code = map['code'];
    pass = map['pass'];
  }

  String? get _code => code;
  String? get _password => pass;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
      map["code"] = _code;
      map["pass"] = _password;
      return map;
  }
  static List<Product3> productList3 = [];
}
