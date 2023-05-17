import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter/rendering.dart';
import 'package:math_expressions/math_expressions.dart';

class Person {
  Person(this.name, this.age);

  final String name;
  final int age;
}

class Transaksi extends StatefulWidget {
  Transaksi({super.key});

  @override
  State<Transaksi> createState() => _TransaksiState();
  final String aAhaWow = 'aAhaWow';

}

class _TransaksiState extends State<Transaksi> {
  bool _visible = true;
  String equation = "0";
  String result = "0";
  String expression = "";
  double equationFontSize = 20.0;
  double resultFontSize = 25.0;

  buttonPressed(String buttonText){
    setState(() {
      if (buttonText == "C"){
        equation = "0";
        result = "0";
        double equationFontSize = 20.0;
        double resultFontSize = 25.0;

      }else if (buttonText == "BckSp"){
        double equationFontSize = 20.0;
        double resultFontSize = 25.0;
        equation = equation.substring(0,equation.length - 1);
        if (equation == ""){
          equation = "0";
        }
        // else {
        //   equation = equation.substring(0,equation.length - 1);
        // }

      }else if (buttonText == "Enter"){
        double equationFontSize = 20.0;
        double resultFontSize = 25.0;

        expression = equation;
        expression = expression.replaceAll('BckSp','*');
        expression = expression.replaceAll('/', '/');

        try{
          Parser p = new Parser();
          Expression exp = p.parse(expression);

          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL,cm)}';
        }catch(e){
          result = "Error";
        }

      } else {
        equationFontSize = 20.0;
        resultFontSize = 25.0;
        if (equation == "0"){
          equation = buttonText;
          equation = equation.substring(0,equation.length - 1);
          // int.parse(equation.substring(0, 1) * 0);
        }

        // if (equation.substring(0) == buttonText){
        //   int.parse(equation.substring(0) * 0);
        //   // equation += buttonText;
        // }
        equation += buttonText;
      }
    });
  }

  Widget buildButton(String buttonText, double buttonHeight, Color buttonColor) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.09 * buttonHeight,
      color: buttonColor,
      child: MaterialButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0.0),
            side: BorderSide(
              color: Colors.white38,
              width: 1,
              style: BorderStyle.solid,
            )
        ),
        padding: EdgeInsets.all(15.0),
        onPressed: () => buttonPressed(buttonText),
        child: Text(
          buttonText,
          style: TextStyle(
            fontSize:15.0,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Stack(
          children: <Widget>[
            Container(
              color: Color.fromARGB(255, 110, 145, 118),
            ),

            Container(
                margin: EdgeInsets.fromLTRB(10, 8, 8, 8),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)
                )
            ),

            Container(
                margin: EdgeInsets.fromLTRB(740, 8, 8, 8),
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 145, 110, 137),
                    // color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    )
                )
            ),

            Container(
                padding: EdgeInsets.only(left: 5),
                margin: EdgeInsets.only(top: 35, left:10),
                // color: Colors.green,
                child:
                ListTile(
                  leading:
                  Container(
                    margin: EdgeInsets.only(right: 110, bottom: 5),
                    child: Image.asset('assets/ram.png',
                      height: 75,),
                  ),
                  title: Container(
                    margin: EdgeInsets.only(left: 20),
                    child: Text('Welcome to Cashier Machine',
                      style: TextStyle(
                          fontFamily: 'Hello-Christmas-trial',
                          fontSize: 30,
                          color: Color.fromARGB(255, 203, 2, 48)
                          // color: Color.fromARGB(255, 201, 54, 86)
                      ),
                    ),
                  ),
                  trailing:
                  Container(
                    margin: EdgeInsets.only(right: 270, top: 10),
                    child: IconButton(
                      icon: Icon(IconlyBold.play),
                      onPressed: () {
                        setState(() {
                          _visible = !_visible;
                        });
                      },
                      padding: EdgeInsets.only(bottom: 15
                      ),
                    ),
                  ),
                )
            ),
            Container(
                margin:  EdgeInsets.fromLTRB(740, 200, 8, 10),
                child: AnimatedCrossFade(
                  firstChild: Container(
                    margin: EdgeInsets.only(left: 10),
                    height: 100,
                    width: 100,
                    color: Colors.blue,
                ),
                  duration: const Duration(seconds: 1),
                  // secondChild: Container(
                  //   height: 250,
                  //   width: 230,
                  //   color: Colors.green,
                  // ),
                  secondChild: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                          child: Text(equation,style: TextStyle(fontSize: equationFontSize)),
                        ),
                        Container(
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                          child: Text(result,style: TextStyle(fontSize: resultFontSize)),
                        ),
                        Expanded(
                          child: Divider(),
                        ),
                        Container(
                          alignment: Alignment.topCenter,
                          padding: EdgeInsets.only(top: 1),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width * .150,
                                child: Table(
                                  children: [
                                    TableRow(
                                        children: [
                                          buildButton("7", 1,  Colors.white),
                                          buildButton("8", 1,  Colors.white),
                                          buildButton("9", 1, Colors.white),
                                        ]
                                    ),
                                    TableRow(
                                        children: [
                                          buildButton("4", 1, Color.fromRGBO(
                                              154, 151, 151, 1.0)),
                                          buildButton("5", 1,  Colors.white),
                                          buildButton("6", 1,  Colors.white),
                                        ]
                                    ),
                                    TableRow(
                                        children: [
                                          buildButton("1", 1,  Colors.white),
                                          buildButton("2", 1,  Colors.white),
                                          buildButton("3", 1,  Colors.white),
                                        ]
                                    ),
                                    TableRow(
                                        children: [
                                          buildButton(".", 1, Color.fromRGBO(63, 178, 192, 1.0),),
                                          buildButton("0", 1, Color.fromRGBO(63, 178, 192, 1.0),),
                                          buildButton("00", 1, Color.fromRGBO(63, 178, 192, 1.0),)
                                        ]
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                width: 60,
                                //  height: MediaQuery.of(context).size.width * .290,
                                child: Table(
                                  children: [
                                    TableRow(
                                        children: [
                                          buildButton("*",1,Color.fromRGBO(141, 63, 192, 1.0),),
                                        ]
                                    ),
                                    TableRow(
                                        children: [
                                          buildButton("-",1,Color.fromRGBO(141, 63, 192, 1.0),),
                                        ]
                                    ),
                                    TableRow(
                                        children: [
                                          buildButton("C",1,Color.fromRGBO(141, 63, 192, 1.0),),
                                        ]
                                    ),
                                    TableRow(
                                        children: [
                                          buildButton("BckSp",1,Color.fromRGBO(141, 63, 192, 1.0),),
                                        ]
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 60,
                                //  height: MediaQuery.of(context).size.width * .290,
                                child: Table(
                                  children: [
                                    TableRow(
                                        children: [
                                          buildButton("+",1,Color.fromRGBO(141, 63, 192, 1.0),),
                                        ]
                                    ),
                                    TableRow(
                                        children: [
                                          buildButton("%",1,Color.fromRGBO(141, 63, 192, 1.0),),
                                        ]
                                    ),
                                    TableRow(
                                        children: [
                                          buildButton("Void",1,Color.fromRGBO(141, 63, 192, 1.0),),
                                        ]
                                    ),
                                    TableRow(
                                        children: [
                                          buildButton("Qty",1,Color.fromRGBO(141, 63, 192, 1.0),),
                                        ]
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        Container(
                            margin: EdgeInsets.only(top: 1, bottom: 15),
                            padding: EdgeInsets.fromLTRB(15, 10, 5, 0),
                            width: MediaQuery.of(context).size.width * .260,
                            child: Table(
                                children: [
                                  TableRow(
                                      children: [
                                        buildButton("Enter", 1, Colors.blueAccent ),
                                        buildButton("C", 1, Colors.blueAccent ),
                                      ]
                                  ),
                                ]
                            )
                        ),
                      ],
                    ),
                  ),

                  crossFadeState:
                  _visible ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                )
            ),

            Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.only(top: 90, left:20,bottom: 20),
              width: 710,
              height: 570,
              decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(10)
              ),
              child:
              Scrollbar(
                // controller: _horizontal,
                thumbVisibility: true,
                scrollbarOrientation: ScrollbarOrientation.bottom,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child:
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      columnSpacing: 35,
                      columns: <DataColumn>[
                        DataColumn(label: Text("SKU"),),
                        DataColumn(label: Text("Barang")),
                        DataColumn(label: Text("Qty")),
                        DataColumn(label: Text("Hrg/Pcs")),
                        DataColumn(label: Text("Diskon")),
                        DataColumn(label: Text("Total")),
                        // DataColumn(label: Text("Total")),
                      ],
                      rows: <DataRow>[
                        DataRow(
                            cells: <DataCell>[
                              DataCell(Text("08123456")),
                              DataCell(Text("Polo Ralph")),
                              DataCell(Text("2")),
                              DataCell(Text("120000")),
                              DataCell(Text("10%")),
                              DataCell(Text("216000")),
                              // DataCell(Text("216000")),
                            ]),
                        DataRow(
                            cells: <DataCell>[
                              DataCell(Text("2117895")),
                              DataCell(Text("Emba Jeans Hitam Pria Slim Fit")),
                              DataCell(Text("1")),
                              DataCell(Text("250000")),
                              DataCell(Text("")),
                              DataCell(Text("250000")),
                              // DataCell(Text("216000")),
                            ]),
                        DataRow(
                            cells: <DataCell>[
                              DataCell(Text("547AB43")),
                              DataCell(Text("Ransel Track")),
                              DataCell(Text("1")),
                              DataCell(Text("200000")),
                              DataCell(Text("")),
                              DataCell(Text("200000")),
                              // DataCell(Text("216000")),
                            ]),
                        DataRow(
                            cells: <DataCell>[
                              DataCell(Text("345AB67")),
                              DataCell(Text("dr.Kevin Shoes Pria")),
                              DataCell(Text("1")),
                              DataCell(Text("99000")),
                              DataCell(Text("")),
                              DataCell(Text("99000")),
                              // DataCell(Text("216000")),
                            ]),
                        DataRow(
                            cells: <DataCell>[
                              DataCell(Text("345AB67")),
                              DataCell(Text("dr.Kevin Shoes Pria")),
                              DataCell(Text("1")),
                              DataCell(Text("99000")),
                              DataCell(Text("")),
                              DataCell(Text("99000")),
                              // DataCell(Text("216000")),
                            ]),
                        DataRow(
                            cells: <DataCell>[
                              DataCell(Text("345AB67")),
                              DataCell(Text("dr.Kevin Shoes Pria")),
                              DataCell(Text("1")),
                              DataCell(Text("99000")),
                              DataCell(Text("")),
                              DataCell(Text("99000")),
                              // DataCell(Text("216000")),
                            ]),
                        DataRow(
                            cells: <DataCell>[
                              DataCell(Text("345AB67")),
                              DataCell(Text("dr.Kevin Shoes Pria")),
                              DataCell(Text("1")),
                              DataCell(Text("99000")),
                              DataCell(Text("")),
                              DataCell(Text("99000")),
                              // DataCell(Text("216000")),
                            ]),
                        DataRow(
                            cells: <DataCell>[
                              DataCell(Text("345AB67")),
                              DataCell(Text("dr.Kevin Shoes Pria")),
                              DataCell(Text("1")),
                              DataCell(Text("99000")),
                              DataCell(Text("")),
                              DataCell(Text("99000")),
                              // DataCell(Text("216000")),
                            ]),
                        DataRow(
                            cells: <DataCell>[
                              DataCell(Text("345AB67")),
                              DataCell(Text("dr.Kevin Shoes Pria")),
                              DataCell(Text("1")),
                              DataCell(Text("99000")),
                              DataCell(Text("")),
                              DataCell(Text("99000")),
                              // DataCell(Text("216000")),
                            ]),
                        DataRow(
                            cells: <DataCell>[
                              DataCell(Text("345AB67")),
                              DataCell(Text("dr.Kevin Shoes Pria")),
                              DataCell(Text("1")),
                              DataCell(Text("99000")),
                              DataCell(Text("")),
                              DataCell(Text("99000")),
                              // DataCell(Text("216000")),
                            ]),
                        DataRow(
                            cells: <DataCell>[
                              DataCell(Text("345AB67")),
                              DataCell(Text("dr.Kevin Shoes Pria")),
                              DataCell(Text("1")),
                              DataCell(Text("99000")),
                              DataCell(Text("")),
                              DataCell(Text("99000")),
                              // DataCell(Text("216000")),
                            ]),
                        DataRow(
                            cells: <DataCell>[
                              DataCell(Text("345AB67")),
                              DataCell(Text("dr.Kevin Shoes Pria")),
                              DataCell(Text("1")),
                              DataCell(Text("99000")),
                              DataCell(Text("")),
                              DataCell(Text("99000")),
                              // DataCell(Text("216000")),
                            ]),
                        DataRow(
                            cells: <DataCell>[
                              DataCell(Text("345AB67")),
                              DataCell(Text("dr.Kevin Shoes Pria")),
                              DataCell(Text("1")),
                              DataCell(Text("99000")),
                              DataCell(Text("")),
                              DataCell(Text("99000")),
                              // DataCell(Text("216000")),
                            ]),
                        DataRow(
                            cells: <DataCell>[
                              DataCell(Text("345AB67")),
                              DataCell(Text("dr.Kevin Shoes Pria")),
                              DataCell(Text("1")),
                              DataCell(Text("99000")),
                              DataCell(Text("")),
                              DataCell(Text("99000")),
                              // DataCell(Text("216000")),
                            ]),
                        DataRow(
                            cells: <DataCell>[
                              DataCell(Text("345AB67")),
                              DataCell(Text("dr.Kevin Shoes Pria")),
                              DataCell(Text("1")),
                              DataCell(Text("99000")),
                              DataCell(Text("")),
                              DataCell(Text("99000")),
                              // DataCell(Text("216000")),
                            ]),
                        DataRow(
                            cells: <DataCell>[
                              DataCell(Text("345AB67")),
                              DataCell(Text("dr.Kevin Shoes Pria")),
                              DataCell(Text("1")),
                              DataCell(Text("99000")),
                              DataCell(Text("")),
                              DataCell(Text("99000")),
                              // DataCell(Text("216000")),
                            ]),
                      ],
                    ),
                    // scrollDirection: Axis.vertical,
                  ),
                ),
              ),
            ),
          ]
      ),
    );
  }
}