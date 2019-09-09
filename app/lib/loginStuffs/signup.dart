import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:saveat/data/appData.dart';
import 'package:saveat/requestHandler/myHandler.dart';
import 'package:saveat/routes/route.dart';
import 'package:saveat/widgets/myTextField.dart';
import 'package:saveat/widgets/myToast.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final TextEditingController _nameController = new TextEditingController();
  final TextEditingController _emailController = new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();
  final TextEditingController _typeController = new TextEditingController();

  Future<dynamic> _fetchResponse() async {
    var responseBody = await makePostRequest(AppData.URl + 'users/register', {
      'name': _nameController.text.toString().trim(),
      'email': _emailController.text.toString().trim(),
      'password': _passwordController.text.toString().trim(),
      'type': _typeController.text.toString().trim()
    });
    var respObj = jsonDecode(responseBody);
    var resStatus = respObj['status'];
    if (resStatus == 1) {
      myToast(respObj['msg'], context);
      MyRoute.goToLogin(context);
    } else if (resStatus == 0) {
      myToast(respObj['msg'], context);
    } else {
      myToast("Something went wrong", context);
    }
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
                    height: 150,
                    width: 150,
                    child: Image.asset('assets/logo.png')),
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
                MyTextField().myTextField(
                    "Name", false, _nameController, TextInputType.text, null),
                MyTextField().myTextField("Email", false, _emailController,
                    TextInputType.emailAddress, null),
                MyTextField().myTextField(
                    "Type", false, _typeController, TextInputType.text, null),
                MyTextField().myTextField("Password", true, _passwordController,
                    TextInputType.text, TextInputAction.done),
                SizedBox(
                  height: 25,
                ),
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
                Container(
                  margin: EdgeInsets.only(
                    top: 10,
                    bottom: 10,
                  ),
                  child: Text(
                    'Or',
                    style: TextStyle(
                      color: Colors.green,
                    ),
                  ),
                ),
                FlatButton(
                  child: Text(
                    'Already have an account ?  Login',
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 16,
                    ),
                  ),
                  onPressed: () {
                    MyRoute.goToLogin(context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
