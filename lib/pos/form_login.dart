import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:path/path.dart';
import 'package:charcode/charcode.dart';
import "package:charcode/ascii.dart";
import 'package:flutter/services.dart';
import 'package:sinau_sqflite/buka_database/add_data.dart';
import 'package:sinau_sqflite/pos/db_helper3.dart';
import 'package:sinau_sqflite/buka_database/home_screen.dart';
import 'package:sinau_sqflite/buka_database/product3.dart';
import 'package:sinau_sqflite/buka_database/product4.dart';
import 'package:sinau_sqflite/buka_database/login_ctr.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sinau_sqflite/buka_database/login_response.dart';
import 'package:sinau_sqflite/pos/tampilan3.dart';
import 'package:sinau_sqflite/pos/transaksi.dart';

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
  List tambah2 = [];
  TextEditingController kresno = new TextEditingController();
  TextEditingController sadmoko = new TextEditingController();
  bool? cek;
  bool _isObscure = true;

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('AlertDialog Title'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('This is a demo alert dialog.'),
                Text('Would you like to approve of this message?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Approve'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  result() async {
    var map2 = {
      128: 'Ç', 129: 'ü', 130: 'é', 131: 'â', 132: 'ä', 133: 'à', 134: 'å', 135: 'ç', 136: 'ê', 137: 'ë', 138: 'è', 139: 'ï', 140: 'î', 141: 'ì', 142: 'Ä', 143: 'Å', 144: 'É', 145: 'æ', 146: 'Æ', 147: 'ô', 148: 'ö', 149: 'ò', 150: 'û', 151: 'ù', 152: 'ÿ', 153: 'Ö', 154: 'Ü', 155: '¢', 156: '£', 157: '¥', 158: 'P', 159: 'ƒ', 160: 'á', 161: 'í', 162: 'ó', 163: 'ú', 164: 'ñ', 165: 'Ñ', 166: 'ª', 167: 'º', 168: '¿',
      169: '¬', 170: '¬', 171: 'œ', 172: 'Œ', 173: '¡', 174: '«', 175: '»', 176: 'Š', 177: 'Š', 178: 'Š', 179: 'Š', 180: 'Š', 181: 'Š', 182: 'Š', 183: '+', 184: '+', 185: 'Š', 186: 'Š', 187: '+', 188: '+', 189: '+', 190: '+', 191: '+', 192: '+', 193: '-', 194: '-', 195: '+', 196: '-', 197: '+', 198: 'Š', 199: 'Š', 200: '+', 201: '+', 202: '-', 203: '-', 204: 'Š', 205: '-', 206: '+', 207: '-', 208: '-',
      209: '-', 210: '-', 211: '+', 212: '+', 213: '+', 214: '+', 215: '+', 216: '+', 217: '+', 218: '+', 219: 'Š', 220: '_', 221: 'Š', 222: 'Š', 223: '¯', 224: 'a', 225: 'ß', 226: 'G', 227: 'p', 228: 'S', 229: 's', 230: 'µ', 231: 't', 232: 'F', 233: 'T', 234: 'O', 235: 'd', 236: '8', 237: 'f', 238: 'e', 239: 'n', 240: '=', 241: '±', 242: '=', 243: '=', 244: '(', 245: ')', 246: '÷', 247: '˜', 248: '°',
      249: '·', 250: '·', 251: 'v', 252: 'n', 253: '²', 254: 'Š', 255: ' ',
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
        // resultAkhirBgt.add(String.fromCharCode(resultAkhir[z]));
        resultAkhirBgt.add(String.fromCharCode(resultAkhir[z]));
        // resultAkhirBgt.add(AsciiDecoder().convert(resultAkhir));
      } else {
        resultAkhirBgt.add(map2[resultAkhir[z]]);
      }
    }

    var stringList = resultAkhirBgt.join("");
    print(resultAkhirBgt);
    print(stringList);

    String codeLogin = code.text;

    return await dbHelper3.getLoginUser(codeLogin, stringList).then((
          userData) {
        if (userData != null) {
          tambah2.clear();
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => Transaksi()),
                  (Route<dynamic> route) => false);
        } else {
          tambah2.add("i");
          print(tambah2);
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Username atau Password Salah!')),
            );
          if (tambah2.length > 2) {
            tambah2.clear();
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text('Warning!'),
                content: Text('Kamu Sudah 3x mencoba tapi gagal.'),
                actions: [
                  MaterialButton(
                    color: Colors.red,
                      textColor: Colors.white,
                      onPressed: () {
                        SystemNavigator.pop();
                      },
                      child: Text('Tutup Aplikasi'))
                ],
              ),
            );

          }
        }
      }).catchError((error) {
        print(error);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Cek Lagi Username dan Password')),
        );
      });
    }

  @override
  void initState() {
    super.initState();
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
                              return "Code Tidak Boleh Kosong!";
                            }
                            if (value.length != 6) {
                              return "Username Hanya 6 digit";
                            }
                          },
                          maxLength: 6,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.number,
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          controller: code,
                          decoration: InputDecoration(
                            counterText: "",
                              hintText: "Ketikkan Code",
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black38),
                                  borderRadius: BorderRadius.circular(10)))),
                      SizedBox(height: 15),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Password Wajib Diisi!";
                          }
                          if (value.length != 6) {
                            return "Password Hanya 6 digit";
                          }
                        },
                        // mouseCursor: ,
                        maxLength: 6,
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.number,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        controller: password,
                        obscureText: _isObscure,
                        decoration: InputDecoration(
                            counterText: "",
                            hintText: "Ketikkan Password",
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black38),
                                borderRadius: BorderRadius.circular(10)),
                          suffixIcon: IconButton(
                            icon: Icon(
                                _isObscure ? Icons.visibility : Icons.visibility_off),
                            onPressed: () {
                              setState(() {
                                _isObscure = !_isObscure;
                              });
                            }),
                        ),
                        onFieldSubmitted: (value) {
                          if (_formKey.currentState!.validate()) {
                            result();
                          }
                        }
                      ),
                      SizedBox(height: 15),
                      MaterialButton(
                        onPressed: () async {
                          // _showMyDialog();
                          if (_formKey.currentState!.validate()) {
                            result();
                            // ScaffoldMessenger.of(context).showSnackBar(
                            //   const SnackBar(content: Text('Processing Data')),
                            // );
                          }

                          // kresno.text = 'Kresno';
                          // sadmoko.text = 'Sadmoko';
                          // setState(() {
                          //   // password.text = loginCtr.getLogin(code.text).toString();
                          //   password.text = getData();
                          // });
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
