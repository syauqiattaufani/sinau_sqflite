import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sinau_sqflite/database_instance.dart';
import 'package:sinau_sqflite/product_model.dart';

class UpdateScreen extends StatefulWidget {
  final ProductModel? productModel;
  const UpdateScreen({Key? key, this.productModel}) : super(key: key);

  @override
  State<UpdateScreen> createState() => _UpdateScreen();
}

class _UpdateScreen extends State<UpdateScreen> {
  DatabaseInstance databaseInstance = DatabaseInstance();
  TextEditingController nameController = TextEditingController();
  TextEditingController categoryController = TextEditingController();

  @override
  void initState() {
    print(widget.productModel!.id!);
    databaseInstance.database();
    nameController.text = widget.productModel!.name ?? '';
    categoryController.text = widget.productModel!.category ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit'),),
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
            await databaseInstance.update(widget.productModel!.id!, {
              'name' : nameController.text,
              'category' : categoryController.text,
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
