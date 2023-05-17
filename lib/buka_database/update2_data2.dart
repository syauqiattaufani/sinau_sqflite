import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sinau_sqflite/pos/db_helper3.dart';
import 'package:sinau_sqflite/buka_database/product3.dart';
import 'package:sinau_sqflite/pos/tampilan3.dart';
import 'package:sinau_sqflite/buka_database/tampilan4.dart';
import 'company_model.dart';

class UpdateData2 extends StatefulWidget {
  final Company company;
  const UpdateData2({Key? key, required this.company}) : super(key: key);

  @override
  State<UpdateData2> createState() => _UpdateData2State();
}

class _UpdateData2State extends State<UpdateData2> {
  DBHelper3 databaseInstance = DBHelper3();
  TextEditingController nameController = TextEditingController();
  TextEditingController valueController = TextEditingController();

  @override
  void initState() {
    print(widget.company!.value!);
    databaseInstance.db;
    nameController.text = widget.company!.name ?? '';
    valueController.text = widget.company!.value ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit'),),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Name'),
          TextField(
            controller: nameController,
          ),
          SizedBox(height: 15),
          Text('Value'),
          TextField(
            controller: valueController,
          ),
          SizedBox(height: 15),
          ElevatedButton(onPressed: () async {
            await databaseInstance.update2(widget.company!.value!, {
              'name' : nameController.text,
              'value' : valueController.text,
            });
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context){
              return Tampilan4();
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
