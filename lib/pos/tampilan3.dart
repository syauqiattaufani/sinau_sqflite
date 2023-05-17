import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sinau_sqflite/buka_database/add_data.dart';
import 'package:sinau_sqflite/pos/db_helper3.dart';
import 'package:sinau_sqflite/buka_database/product3.dart';
import 'package:sinau_sqflite/buka_database/tampilan4.dart';
import 'package:sinau_sqflite/pos/update_data.dart';
import 'package:sinau_sqflite/database_instance.dart';
import 'package:sinau_sqflite/product_model.dart';
import 'package:sinau_sqflite/sqfliteff/employee_list.dart';
import 'package:sinau_sqflite/sqfliteff/model.dart';
import 'package:sinau_sqflite/update.dart';

List<Product3> daftar_list = [];

class Tampilan3 extends StatefulWidget {
  // const Tampilan3({Key? key}) : super(key: key);

  @override
  State<Tampilan3> createState() => _Tampilan3State();
}

class _Tampilan3State extends State<Tampilan3> {
  DBHelper3 databaseInstance = DBHelper3();
  Future _refresh() async {
    setState(() {});
  }
  Future delete(String code) async {
    await databaseInstance!.delete(code);
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  void getData() async {
    var dbHelper3 = DBHelper3();
    List<Product3> _daftar_list = await dbHelper3.getEmployees3();
    setState(() {
      daftar_list = _daftar_list;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Employee Names'),
        actions: [
          IconButton(
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (builder) {
                return AddData();
              })).then((value) {
                setState(() {});
              });
            },
            icon: Icon(Icons.add),
          ),
          TextButton(onPressed: (){
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context){
              return Tampilan4();
            }))
                .then((value) => setState(() => {

            }));
          },
              child: Text("mytable",
              style: TextStyle(color: Colors.white),),
              ),
        ],
      ),
      body:
      RefreshIndicator(
        onRefresh: _refresh,
        child: databaseInstance != null ? FutureBuilder<List<Product3>>(
            future: databaseInstance!.getEmployees3(),
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
                      title: Row(
                        children: [
                          // Text(snapshot.data![index].code ?? ''),
                          Text(snapshot.data![index].pass ?? ''),
                        ],
                      ),
                      subtitle: Text(snapshot.data![index].code ?? ''),
                      leading: IconButton(
                        onPressed: ()=> delete(snapshot.data![index].code!),
                        icon: Icon(Icons.delete),
                      ),
                      trailing: IconButton(onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (builder) {
                          return UpdateData(product3: snapshot.data![index],);
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
