import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sinau_sqflite/pos/db_helper3.dart';
import 'package:sinau_sqflite/buka_database/product3.dart';
import 'package:sinau_sqflite/pos/tampilan3.dart';

class UpdateData extends StatefulWidget {
  final Product3? product3;
  const UpdateData({Key? key, this.product3}) : super(key: key);

  @override
  State<UpdateData> createState() => _UpdateDataState();
}

class _UpdateDataState extends State<UpdateData> {
  DBHelper3 databaseInstance = DBHelper3();
  TextEditingController codeController = TextEditingController();
  TextEditingController descController = TextEditingController();

  @override
  void initState() {
    print(widget.product3!.code!);
    databaseInstance.db;
    codeController.text = widget.product3!.code ?? '';
    // descController.text = widget.product3!.desc ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit'),),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Code'),
          TextField(
            controller: codeController,
          ),
          SizedBox(height: 15),
          Text('Desc'),
          TextField(
            controller: descController,
          ),
          SizedBox(height: 15),
          ElevatedButton(onPressed: () async {
            await databaseInstance.update(widget.product3!.code!, {
              'code' : codeController.text,
              'desc' : descController.text,
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
