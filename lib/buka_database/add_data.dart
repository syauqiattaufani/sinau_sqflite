import 'dart:convert';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sinau_sqflite/pos/db_helper3.dart';
import 'package:sinau_sqflite/buka_database/product3.dart';
import 'package:sinau_sqflite/pos/tampilan3.dart';


class AddData extends StatefulWidget {
  const AddData({Key? key}) : super(key: key);

  @override
  State<AddData> createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  DBHelper3 databaseInstance = DBHelper3();
  late TextEditingController passController = TextEditingController();
  late TextEditingController codeController = TextEditingController();

  result() async {
    var map2 = {
      128: 'Ç', 129: 'ü', 130: 'é', 131: 'â', 132: 'ä', 133: 'à', 134: 'å', 135: 'ç', 136: 'ê', 137: 'ë', 138: 'è', 139: 'ï', 140: 'î', 141: 'ì', 142: 'Ä', 143: 'Å', 144: 'É', 145: 'æ', 146: 'Æ', 147: 'ô', 148: 'ö', 149: 'ò', 150: 'û', 151: 'ù', 152: 'ÿ', 153: 'Ö', 154: 'Ü', 155: '¢', 156: '£', 157: '¥', 158: 'P', 159: 'ƒ', 160: 'á', 161: 'í', 162: 'ó', 163: 'ú', 164: 'ñ', 165: 'Ñ', 166: 'ª', 167: 'º', 168: '¿', 169: '¬', 170: '¬', 171: 'œ', 172: 'Œ', 173: '¡', 174: '«', 175: '»', 176: 'Š', 177: 'Š', 178: 'Š', 179: 'Š', 180: 'Š', 181: 'Š', 182: 'Š', 183: '+', 184: '+',
      185: 'Š', 186: 'Š', 187: '+', 188: '+', 189: '+', 190: '+', 191: '+', 192: '+', 193: '-', 194: '-', 195: '+', 196: '-', 197: '+', 198: 'Š', 199: 'Š', 200: '+', 201: '+', 202: '-', 203: '-', 204: 'Š', 205: '-', 206: '+', 207: '-', 208: '-', 209: '-', 210: '-', 211: '+', 212: '+', 213: '+', 214: '+', 215: '+', 216: '+', 217: '+', 218: '+', 219: 'Š',
      220: '_', 221: 'Š', 222: 'Š', 223: '¯', 224: 'a', 225: 'ß', 226: 'G', 227: 'p', 228: 'S', 229: 's', 230: 'µ', 231: 't', 232: 'F', 233: 'T', 234: 'O', 235: 'd', 236: '8', 237: 'f', 238: 'e', 239: 'n', 240: '=', 241: '±', 242: '=', 243: '=', 244: '(', 245: ')', 246: '÷', 247: '˜', 248: '°', 249: '·', 250: '·', 251: 'v', 252: 'n', 253: '²', 254: 'Š', 255: ' ',
    };
    var kresno = "KrEsNo";
    var ascKresno = AsciiEncoder().convert(kresno);
    List<int> listAscKresno = ascKresno;
    var pass = passController.text;
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
    var concatenate = StringBuffer();
    resultAkhirBgt.forEach((item) {
      concatenate.write(item);
    });
    // print(resultAkhirBgt);
    print(stringList);
    // print(concatenate);

    // return databaseInstance.insert({
    //   'code':codeController.text,
    //   'pass':concatenate,
    //   // 'pass':passController.text,
    // });

    // return stringList as String;
    // return stringList;
    return await databaseInstance.insert({
      'code':codeController.text,
      'pass':stringList,
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('create'),),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Code'),
          TextField(
            controller: codeController,
          ),
          SizedBox(height: 15),

          Text('Password'),
          TextField(
            controller: passController,
          ),
          SizedBox(height: 15),

          ElevatedButton(onPressed: () async {
            // setState(() {
            //   result();
            // });

            // await databaseInstance.insert({
            //   'code':codeController.text,
            //   // 'pass':result().toString(),
            //   'pass':passController.text,
            // });

            // await databaseInstance.insert({
            //   'code':codeController.text,
            //   'pass':passController.text,
            // });
            setState(() {
              result();
            });
            Navigator.of(context)
            .push(MaterialPageRoute(builder: (context){
              return Tampilan3();
            }))
            .then((value) => setState(() => {

            }));
          },
            child: Text('Submit'),)
        ],
      ),
    );
  }
}
