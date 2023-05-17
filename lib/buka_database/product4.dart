class Product4 {
  String? _code;
  String? _pass;

  Product4(
    this._code,
    this._pass
  );

  Product4.fromMap(dynamic obj) {
    this._code = obj['code'];
    this._pass = obj['pass'];
  }

  String? get code => _code;
  String? get pass => _pass;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["code"] = this.code;
    map["pass"] = this.pass;
    return map;
  }
}