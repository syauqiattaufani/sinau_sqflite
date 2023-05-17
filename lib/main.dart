import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:sinau_sqflite/buka_database/add_data.dart';
import 'package:sinau_sqflite/pos/form_login.dart';
import 'package:sinau_sqflite/pos/tampilan3.dart';
import 'package:sinau_sqflite/buka_database/tampilan4.dart';
import 'package:sinau_sqflite/home.dart';
import 'package:sinau_sqflite/pos/transaksi.dart';
import 'package:sinau_sqflite/sqfliteff/employee_list.dart';
import 'package:sinau_sqflite/test.dart';
import 'package:sqflite_common/sqlite_api.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) => ResponsiveWrapper.builder(
        child,
        maxWidth: 1024,
        minWidth: 480,
        defaultScale: true,
        breakpoints: [
          ResponsiveBreakpoint.autoScale(600, name: PHONE),
          ResponsiveBreakpoint.autoScale(800, name: TABLET),
          ResponsiveBreakpoint.autoScale(1024, name: DESKTOP),
        ],
      ),
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FormLogin(),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:virtual_keyboard_multi_language/virtual_keyboard_multi_language.dart';
//
// void main() => runApp(MyApp());
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Virtual Keyboard Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: MyHomePage(title: 'Virtual Keyboard Demo', key: Key("nice"),),
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   MyHomePage({required Key key, required this.title}) : super(key: key);
//   final String title;
//
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   // Holds the text that user typed.
//   String text = '';
//   // CustomLayoutKeys _customLayoutKeys;
//   // True if shift enabled.
//   bool shiftEnabled = false;
//
//   // is true will show the numeric keyboard.
//   bool isNumericMode = false;
//
//   TextEditingController? _controllerText;
//
//   @override
//   void initState() {
//     // _customLayoutKeys = CustomLayoutKeys();
//     _controllerText = TextEditingController();
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: Center(
//         child: Column(
//           children: <Widget>[
//             Text(
//               text,
//               style: Theme.of(context).textTheme.bodyText1,
//             ),
//             Text(
//               _controllerText!.text,
//               style: TextStyle(color: Colors.red),
//             ),
//             SwitchListTile(
//               title: Text(
//                 'Keyboard Type = ' +
//                     (isNumericMode
//                         ? 'VirtualKeyboardType.Numeric'
//                         : 'VirtualKeyboardType.Alphanumeric'),
//               ),
//               value: isNumericMode,
//               onChanged: (val) {
//                 setState(() {
//                   isNumericMode = val;
//                 });
//               },
//             ),
//             Expanded(
//               child: Container(),
//             ),
//             Container(
//               color: Colors.deepPurple,
//               child: VirtualKeyboard(
//                   height: 300,
//                   //width: 500,
//                   textColor: Colors.white,
//                   textController: _controllerText,
//                   //customLayoutKeys: _customLayoutKeys,
//                   defaultLayouts: [
//                     VirtualKeyboardDefaultLayouts.Arabic,
//                     VirtualKeyboardDefaultLayouts.English
//                   ],
//                   //reverseLayout :true,
//                   type: isNumericMode
//                       ? VirtualKeyboardType.Numeric
//                       : VirtualKeyboardType.Alphanumeric,
//                   onKeyPress: _onKeyPress),
//             )
//           ],
//         ),
//       ),
//     );
//   }
//
//   /// Fired when the virtual keyboard key is pressed.
//   _onKeyPress(VirtualKeyboardKey key) {
//     if (key.keyType == VirtualKeyboardKeyType.String) {
//       text = text + (shiftEnabled ? key.capsText! : key.text!);
//     } else if (key.keyType == VirtualKeyboardKeyType.Action) {
//       switch (key.action) {
//         case VirtualKeyboardKeyAction.Backspace:
//           if (text.length == 0) return;
//           text = text.substring(0, text.length - 1);
//           break;
//         case VirtualKeyboardKeyAction.Return:
//           text = text + '\n';
//           break;
//         case VirtualKeyboardKeyAction.Space:
//           text = text + key.text!;
//           break;
//         case VirtualKeyboardKeyAction.Shift:
//           shiftEnabled = !shiftEnabled;
//           break;
//         default:
//       }
//     }
//     // Update the screen
//     setState(() {});
//   }
// }


