import 'dart:async';

import 'package:flutter/material.dart';
import 'package:saveat/routes/route.dart';
import 'package:saveat/widgets/myToast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SharedPreferences sharedPreferences;
  bool checkValue = false;

  getCredential() async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      checkValue = sharedPreferences.getBool("check");
      if (checkValue != null) {
        if (checkValue) {
          String email, type;
          email = sharedPreferences.getString("Email");
          type = sharedPreferences.getString("Type");
          myToast("LoggedIn as:" + email + "( " + type + " )", context);
          if (type == "user") {
            MyRoute.goToUserHome(context);
          } else if (type == "vendor") {
            MyRoute.goToVendorHome(context);
          }
        } else {
          sharedPreferences.clear();
        }
      } else {
        MyRoute.goToLogin(context);
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState

    Timer(Duration(seconds: 3), () => {getCredential()});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(top: 232, right: 20),
            height: 200,
            child: Image.asset('assets/logo.png'),
          ),
          Container(
            margin: EdgeInsets.only(left: 20.0),
            alignment: Alignment.center,
            child: Text(
              "Save Money. Save Food. Save Environment.",
              style: TextStyle(
                  color: Color.fromARGB(0xff, 65, 117, 5),
                  fontSize: 14,
                  fontWeight: FontWeight.w500),
            ),
          ),
          CircularProgressIndicator()
        ],
      ),
    );
  }
}
