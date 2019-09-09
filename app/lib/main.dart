import 'package:flutter/material.dart';
import 'package:saveat/UIScreens/Vendor/qrScan.dart';
import 'package:saveat/UIScreens/Vendor/vendorHome.dart';
import 'package:saveat/UIScreens/user/userHome.dart';
import 'package:saveat/boardingScreen/OnBoarding.dart';
import 'package:saveat/loginStuffs/login.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: QRScan());
  }
}

// class MYCounter extends StatelessWidget {
//   final CounterModel appModelOne = CounterModel();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text('Basic Counter'),
//         ),
//         body: Center(
//           child: ScopedModel<CounterModel>(
//             model: appModelOne,
//             child: Counter(
//               counterName: 'App Model One',
//             ),
//           ),
//         ));
//   }
// }

// class Counter extends StatelessWidget {
//   final String counterName;
//   Counter({Key key, this.counterName});

//   @override
//   Widget build(BuildContext context) {
//     return ScopedModelDescendant<CounterModel>(
//       builder: (context, child, model) => Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               Text("$counterName:"),
//               Text(
//                 model.count.toString(),
//                 style: Theme.of(context).textTheme.display1,
//               ),
//               ButtonBar(
//                 children: <Widget>[
//                   IconButton(
//                     icon: Icon(Icons.add),
//                     onPressed: model.increment,
//                   ),
//                   IconButton(
//                     icon: Icon(Icons.minimize),
//                     onPressed: model.decrement,
//                   )
//                 ],
//               )
//             ],
//           ),
//     );
//   }
// }
