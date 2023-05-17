import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sinau_sqflite/buka_database/add_data.dart';
import 'package:sinau_sqflite/buka_database/add_company.dart';
import 'package:sinau_sqflite/pos/db_helper3.dart';
import 'package:sinau_sqflite/buka_database/company_model.dart';
import 'package:sinau_sqflite/pos/tampilan3.dart';
import 'package:sinau_sqflite/buka_database/update2_data2.dart';
import 'package:sinau_sqflite/pos/update_data.dart';

List<Company> daftar_list = [];
class Tampilan4 extends StatefulWidget {
  // const Tampilan4({Key? key}) : super(key: key);

  @override
  State<Tampilan4> createState() => _Tampilan4State();
}

class _Tampilan4State extends State<Tampilan4> {
  DBHelper3 databaseInstance = DBHelper3();
  Future _refresh() async {
    setState(() {});
  }

  Future delete2(String idparams) async {
    await databaseInstance!.delete2(idparams);
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
    List<Company> _daftar_list = await dbHelper3.getEmployees4();
    setState(() {
      daftar_list = _daftar_list;
    });
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.redAccent,
        title: new Text('Employee Names'),
        actions: [
          IconButton(
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (builder) {
                return AddCompany();
              })).then((value) {
                setState(() {});
              });
            },
            icon: Icon(Icons.add),
          ),
          TextButton(onPressed: (){
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context){
              return Tampilan3();
            }))
                .then((value) => setState(() => {

            }));
            print(databaseInstance);
          },
            child: Text("cashier_dbf",
              style: TextStyle(color: Colors.white),),
          ),
        ],
      ),
      body:
      RefreshIndicator(
        onRefresh: _refresh,
        child: databaseInstance != null ? FutureBuilder<List<Company>>(
            future: databaseInstance!.getEmployees4(),
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
                      subtitle: Text(snapshot.data![index].value ?? ''),
                      leading: IconButton(
                        onPressed: ()=> delete2(snapshot.data![index].value!),
                        icon: Icon(Icons.delete),
                      ),
                      trailing: IconButton(onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (builder) {
                          return UpdateData2(company: snapshot.data![index],);
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
