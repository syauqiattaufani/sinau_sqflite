import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sinau_sqflite/create.dart';
import 'package:sinau_sqflite/database_instance.dart';
import 'package:sinau_sqflite/product_model.dart';
import 'package:sinau_sqflite/update.dart';

class HomeFlite extends StatefulWidget {
  const HomeFlite({Key? key}) : super(key: key);

  @override
  State<HomeFlite> createState() => _HomeFliteState();
}

class _HomeFliteState extends State<HomeFlite> {
  DatabaseInstance? databaseInstance;
  Future _refresh() async {
    setState(() {});
  }

  Future initDatabase() async {
    await databaseInstance!.database();
    setState(() {});
  }

  Future delete(int id) async {
    await databaseInstance!.delete(id);
    setState(() {});
  }

  @override
  void initState() {
    databaseInstance = DatabaseInstance();
    initDatabase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [IconButton(
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (builder) {
                return CreateScreen();
              })).then((value) {
                setState(() {});
              });
            },
            icon: Icon(Icons.add_circle_outline_outlined))],
        title: Text('Belajar SQFlite'),
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: databaseInstance != null ? FutureBuilder<List<ProductModel>>(
              future: databaseInstance!.all(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data!.length == 0) {
                    return Center(
                      child: Text('Data kosong'),
                    );
                  }
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(snapshot.data![index].name ?? ''),
                        subtitle: Text(snapshot.data![index].category ?? ''),
                        leading: IconButton(
                          onPressed: ()=> delete(snapshot.data![index].id!),
                          icon: Icon(Icons.delete),
                        ),
                        trailing: IconButton(onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (builder) {
                            return UpdateScreen(productModel: snapshot.data![index],);
                          })).then((value) {
                            setState(() {});
                          });
                        },
                          icon: Icon(Icons.edit),),
                      );
                    },
                  );
                } else {
                  print(snapshot.error);
                  return Center(
                    child: CircularProgressIndicator(
                      color: Colors.green,
                    ),
                  );
                }
              }):
        Center(
          child: CircularProgressIndicator(
            color: Colors.green,
          ),

        ),
      ),
    );
  }
}
