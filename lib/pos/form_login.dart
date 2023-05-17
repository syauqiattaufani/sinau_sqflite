import 'dart:convert';
import 'package:flutter/material.dart';
// import 'package:path/path.dart';
import 'package:charcode/charcode.dart';
import "package:charcode/ascii.dart";
import 'package:sinau_sqflite/pos/db_helper3.dart';
import 'package:sinau_sqflite/buka_database/home_screen.dart';
import 'package:sinau_sqflite/buka_database/product3.dart';
import 'package:sinau_sqflite/buka_database/product4.dart';
import 'package:sinau_sqflite/buka_database/login_ctr.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sinau_sqflite/buka_database/login_response.dart';

class FormLogin extends StatefulWidget {
  const FormLogin({Key? key}) : super(key: key);

  @override
  State<FormLogin> createState() => _FormLoginState();
}

enum LoginStatus { notSignIn, signIn }

class _FormLoginState extends State<FormLogin> {
  TextEditingController code = TextEditingController();
  TextEditingController password = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  DBHelper3 dbHelper3 = DBHelper3();
  LoginCtr loginCtr = LoginCtr();
  TextEditingController kresno = new TextEditingController();
  TextEditingController sadmoko = new TextEditingController();
  LoginStatus _loginStatus = LoginStatus.notSignIn;
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  bool _isLoading = false;

  result() async {
    var map2 = {
      128: 'Ç', 129: 'ü', 130: 'é', 131: 'â', 132: 'ä', 133: 'à', 134: 'å', 135: 'ç', 136: 'ê', 137: 'ë', 138: 'è', 139: 'ï', 140: 'î', 141: 'ì', 142: 'Ä', 143: 'Å', 144: 'É', 145: 'æ', 146: 'Æ', 147: 'ô', 148: 'ö', 149: 'ò', 150: 'û', 151: 'ù', 152: 'ÿ', 153: 'Ö', 154: 'Ü', 155: '¢', 156: '£', 157: '¥', 158: 'P', 159: 'ƒ', 160: 'á', 161: 'í', 162: 'ó', 163: 'ú', 164: 'ñ', 165: 'Ñ', 166: 'ª', 167: 'º', 168: '¿', 169: '¬', 170: '¬', 171: 'œ', 172: 'Œ', 173: '¡', 174: '«', 175: '»', 176: 'Š', 177: 'Š', 178: 'Š', 179: 'Š', 180: 'Š', 181: 'Š', 182: 'Š', 183: '+', 184: '+',
      185: 'Š', 186: 'Š', 187: '+', 188: '+', 189: '+', 190: '+', 191: '+', 192: '+', 193: '-', 194: '-', 195: '+', 196: '-', 197: '+', 198: 'Š', 199: 'Š', 200: '+', 201: '+', 202: '-', 203: '-', 204: 'Š', 205: '-', 206: '+', 207: '-', 208: '-', 209: '-', 210: '-', 211: '+', 212: '+', 213: '+', 214: '+', 215: '+', 216: '+', 217: '+', 218: '+', 219: 'Š',
      220: '_', 221: 'Š', 222: 'Š', 223: '¯', 224: 'a', 225: 'ß', 226: 'G', 227: 'p', 228: 'S', 229: 's', 230: 'µ', 231: 't', 232: 'F', 233: 'T', 234: 'O', 235: 'd', 236: '8', 237: 'f', 238: 'e', 239: 'n', 240: '=', 241: '±', 242: '=', 243: '=', 244: '(', 245: ')', 246: '÷', 247: '˜', 248: '°', 249: '·', 250: '·', 251: 'v', 252: 'n', 253: '²', 254: 'Š', 255: ' ',
    };
    var kresno = "KrEsNo";
    var ascKresno = AsciiEncoder().convert(kresno);
    List<int> listAscKresno = ascKresno;
    var pass = password.text;
    var ascPass = AsciiEncoder().convert(pass);
    List<int> listAscPass = ascPass;
    List<int> addIndex = [];

    int current = 1;
    for (int i = 0; i < pass.length; i++) {
      if (pass[i] == '0') {
        current = current * i + 1;
        addIndex.add(current);
        // print('Coba if $addIndex');
      } else {
        current = i + 1;
        addIndex.add(current);
        // print('Coba else $addIndex');
      }
    }

    var passSplit = pass.split("");
    List<int> listPassSplit = [];
    for (var i in passSplit) {
      int? value = int.tryParse(i);
      listPassSplit.add(value!);
    }

    List<int> resultAkhir = [];
    for (int x = 0; x < pass.length; x++) {
      resultAkhir.add(
          listAscKresno[x] + (listAscPass[x]) + addIndex[x] + listPassSplit[x]);
    }

    List resultAkhirBgt = [];
    for (int z = 0; z < resultAkhir.length; z++) {
      if (resultAkhir[z] <= 127) {
        // resultAkhir[z].toString();
        resultAkhirBgt.add(String.fromCharCode(resultAkhir[z]));
        // resultAkhirBgt.add(AsciiDecoder().convert(resultAkhir));
      } else {
        resultAkhirBgt.add(map2[resultAkhir[z]]);
      }
    }

    var stringList = resultAkhirBgt.join("");
    print(resultAkhirBgt);
    print(stringList);
    // print(resultAkhirBanget);
    return stringList;
  }

  String? _username, _password;
  var value;
  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      value = preferences.getInt("value");

      _loginStatus = value == 1 ? LoginStatus.signIn : LoginStatus.notSignIn;
    });
  }

  getData() {
    var username = code.text;
    return username;
  }

  getDataDb() {
  var dbClient = dbHelper3.sqfliteFfiInit();
  // var res = dbClient!.rawQuery("SELECT code FROM cashier_dbf WHERE code = $code");
  String abc = "SELECT code FROM cashier_dbf WHERE code = ${code.text}";
  return abc;
}

  late String _usernameLogin, _passwordLogin;

  late LoginResponse _response;

  // _LoginPageState() {
  //   _response = new LoginResponse(this);
  // }

  void _submit() {
    final form = _formKey.currentState;

    if (form!.validate()) {
      setState(() {
        _isLoading = true;
        form.save();
        _response.doLogin(_username!, _password!);
        Navigator.push(context,
        MaterialPageRoute(builder: (context) =>
          HomeScreen()
        ));
      });

    }
  }

  // void _showSnackBar(String text) {
  //   scaffoldKey.currentState!.(new SnackBar(
  //     content: new Text(text),
  //   ));
  // }

  @override
  void initState() {
    super.initState();
    getPref();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
          height: 600,
          child: Image.asset(
            "assets/bg.png",
            fit: BoxFit.fitHeight,
          ),
        ),
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(35),
                height: 400,
                width: 400,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      topLeft: Radius.circular(10)),
                  color: Colors.white54,
                ),
                child: Image.asset("assets/ramay.png"),
              ),
              Container(
                padding: EdgeInsets.all(35),
                height: 400,
                width: 400,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(10),
                      topRight: Radius.circular(10)),
                  color: Colors.white54,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Text("LOG IN KASIR",
                          style: TextStyle(
                              fontFamily: 'Hello-Christmas-trial',
                              fontSize: 30,
                              color: Colors.white)),
                      SizedBox(height: 15),
                      TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Wajib Diisi!";
                            }
                          },
                          onSaved: (val) => _username = val!,
                          controller: code,
                          decoration: InputDecoration(
                              hintText: "Ketikkan ID",
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black38),
                                  borderRadius: BorderRadius.circular(10)))),
                      SizedBox(height: 15),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Wajib Diisi!";
                          }
                        },
                        controller: password,
                        // obscureText: true,
                        decoration: InputDecoration(
                            hintText: "Ketikkan Password",
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black38),
                                borderRadius: BorderRadius.circular(10))),
                        onSaved: (val) => _password = val!,
                      ),
                      SizedBox(height: 15),
                      MaterialButton(
                        onPressed: () async {
                          //result();
                          // kresno.text = 'Kresno';
                          // sadmoko.text = 'Sadmoko';
                          // setState(() {
                          //   // password.text = loginCtr.getLogin(code.text).toString();
                          //   password.text = getData();
                          // });
                          _submit();

                        },
                        color: Colors.red,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        child: Text(
                          "Log In",
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ]),
    );


  }
}
