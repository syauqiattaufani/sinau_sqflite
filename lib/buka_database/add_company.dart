import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sinau_sqflite/pos/db_helper3.dart';
import 'package:sinau_sqflite/buka_database/product3.dart';
import 'package:sinau_sqflite/pos/tampilan3.dart';
import 'package:sinau_sqflite/buka_database/tampilan4.dart';

class AddCompany extends StatefulWidget {
  const AddCompany({Key? key}) : super(key: key);

  @override
  State<AddCompany> createState() => _AddCompanyState();
}

class _AddCompanyState extends State<AddCompany> {
  DBHelper3 databaseInstance = DBHelper3();
  TextEditingController nameController = TextEditingController();
  TextEditingController valueController = TextEditingController();

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
          Text('Nama'),
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
            await databaseInstance.insert2({
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
