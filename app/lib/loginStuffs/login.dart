import 'package:flutter/material.dart';
import 'package:saveat/data/appData.dart';
import 'dart:convert';
import 'package:saveat/requestHandler/myHandler.dart';
import 'package:saveat/routes/route.dart';
import 'package:saveat/widgets/myTextField.dart';
import 'package:saveat/widgets/myToast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_svg/flutter_svg.dart';

var b;
var d = [].asMap();
var e;

SharedPreferences sharedPreferences;
bool checkValue = false;

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();

  Future<dynamic> _fetchResponse() async {
    var responseBody = await makePostRequest(AppData.URl + 'users/login', {
      'email': _emailController.text.toString().trim(),
      'password': _passwordController.text.toString().trim(),
    });
    var respObj = jsonDecode(responseBody);
    var resStatus = respObj['status'];
    if (resStatus == 1) {
      myToast(resStatus.toString(), context);
      switch (respObj['data']['type']) {
        case 'user':
          myToast("user", context);
          _onChanged(true, respObj['data']['name'], respObj['data']['email'],
              respObj['data']['type'], respObj['data']['id']);
          MyRoute.goToUserHome(context);
          break;
        case 'vendor':
          myToast("vendor", context);
          _onChanged(true, respObj['data']['name'], respObj['data']['email'],
              respObj['data']['type'], respObj['data']['id']);
          MyRoute.goToVendorHome(context);
          break;
        case 'admin':
          myToast("Please open via website.....", context);
          break;
        default:
          myToast("No role found for this user", context);
      }
    } else if (resStatus == 0) {
      myToast(respObj['msg'], context);
    } else {
      myToast("Something went wrong", context);
    }
  }

  _onChanged(
      bool value, String name, String email, String type, String id) async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      checkValue = value;
      sharedPreferences.setBool("check", checkValue);
      sharedPreferences.setString("Email", email);
      sharedPreferences.setString("id", id);
      sharedPreferences.setString("Name", name);
      sharedPreferences.setString("Type", type);
      sharedPreferences.commit();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: SingleChildScrollView(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
                height: 150, width: 150, child: Image.asset('assets/logo.png')),
            Container(
              child: Text(
                "Save Money. Save Food. Save Environment.",
                style: TextStyle(
                    color: Color.fromARGB(0xff, 65, 117, 5),
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            MyTextField().myTextField("Email", false, _emailController,
                TextInputType.emailAddress, null),
            MyTextField().myTextField("Password", true, _passwordController,
                TextInputType.text, TextInputAction.done),
            SizedBox(
              height: 25,
            ),
            // GestureDetector(
            //   onTap: () {},
            //   child: Container(
            //     alignment: Alignment.centerRight,
            //     margin: EdgeInsets.only(top: 25, right: 5),
            //     child: Text(
            //       'Forgot Password ?',
            //       style: TextStyle(color: Colors.green),
            //     ),
            //   ),
            // ),

            InkWell(
              onTap: () {
                _fetchResponse();
              },
              child: Container(
                margin: EdgeInsets.fromLTRB(20.0, 20.0, 30.0, 0.0),
                width: MediaQuery.of(context).size.width,
                height: 50.0,
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Color.fromARGB(0xff, 119, 134, 158),
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                    color: Colors.green),
                child: Center(
                  child: Text(
                    "Login",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ),
            ),
            // InkWell(
            //   onTap: () {
            //     _fetchResponse();
            //   },
            //   child: Container(
            //     margin: EdgeInsets.only(top: 65),
            //     width: MediaQuery.of(context).size.width,
            //     height: 40.0,
            //     decoration: BoxDecoration(
            //       color: Color.fromARGB(0xff, 65, 117, 5),
            //       borderRadius: BorderRadius.all(
            //         Radius.circular(20.0),
            //       ),
            //     ),
            //     child: Center(
            //       child: Text(
            //         "Login",
            //         style: TextStyle(
            //             color: Colors.white,
            //             fontSize: 16.0,
            //             fontWeight: FontWeight.w400),
            //       ),
            //     ),
            //   ),
            // ),

            // Container(
            //   margin: EdgeInsets.only(top: 30.0, bottom: 30.0),
            //   child: Row(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: <Widget>[
            //       Padding(
            //         padding: EdgeInsets.only(top: 10.0),
            //         child: Container(
            //           decoration: BoxDecoration(
            //             border: Border.all(
            //               width: 1.0,
            //               color: Color.fromARGB(0xff, 119, 134, 158),
            //             ),
            //             borderRadius: BorderRadius.all(
            //               Radius.circular(20.0),
            //             ),
            //           ),
            //           height: 40.0,
            //           width: MediaQuery.of(context).size.width / 2.4,
            //           child: Center(
            //               child: Image.asset('lib/assets/facebook.png')),
            //         ),
            //       ),
            //       Padding(
            //         padding: EdgeInsets.only(top: 10),
            //         child: Container(
            //           decoration: BoxDecoration(
            //             border: Border.all(
            //               width: 1.0,
            //               color: Color.fromARGB(0xff, 119, 134, 158),
            //             ),
            //             borderRadius: BorderRadius.all(
            //               Radius.circular(20.0),
            //             ),
            //           ),
            //           height: 40.0,
            //           width: MediaQuery.of(context).size.width / 2.4,
            //           child: Center(
            //             child: SvgPicture.asset(
            //               'lib/assets/google.svg',
            //               height: 18,
            //               width: 10,
            //             ),
            //           ),
            //         ),
            //       ),
            //       Container(
            //         margin: EdgeInsets.only(
            //           top: 10,
            //           bottom: 10,
            //         ),
            //         child: Text(
            //           'Or',
            //           style: TextStyle(
            //             color: Colors.green,
            //           ),
            //         ),
            //       ),
            FlatButton(
              child: Text(
                'Create an account, Sign Up',
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 16,
                ),
              ),
              onPressed: () {
                MyRoute.goToSignup(context);
              },
            ),
          ],
        ),
      ),
    )));
  }
}
