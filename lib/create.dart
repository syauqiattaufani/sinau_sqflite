import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sinau_sqflite/database_instance.dart';
import 'package:sinau_sqflite/product_model.dart';

class CreateScreen extends StatefulWidget {
  const CreateScreen({Key? key}) : super(key: key);

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  DatabaseInstance databaseInstance = DatabaseInstance();
  TextEditingController nameController = TextEditingController();
  TextEditingController categoryController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    databaseInstance.database();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('create'),),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Nama Produk'),
          TextField(
            controller: nameController,
          ),
          SizedBox(height: 15),
          Text('Kategori'),
          TextField(
            controller: categoryController,
          ),
          SizedBox(height: 15),
          ElevatedButton(onPressed: () async {
            await databaseInstance.insert({
              'name' : nameController.text,
              'category' : categoryController.text,
              'created_at' : DateTime.now().toString(),
              'updated_at' : DateTime.now().toString()
            });
            Navigator.pop(context);
            // setState(() {
            // });
          },
          child: Text('Submit'),)
        ],
      ),
    );
  }
}
