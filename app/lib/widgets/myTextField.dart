import 'package:flutter/material.dart';

class MyTextField {
  Widget myTextField(String hint, bool isPassword, TextEditingController _tec,
      TextInputType keyboardType, TextInputAction textInputAction) {
    return Container(
      margin: EdgeInsets.fromLTRB(10.0, 20.0, 20.0, 0.0),
      height: 50.0,
      child: TextField(
        controller: _tec,
        obscureText: isPassword,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        decoration: InputDecoration(
          labelText: hint,
          labelStyle:
              TextStyle(color: Color.fromARGB(0xff, 32, 168, 74), fontSize: 12),
          border: OutlineInputBorder(
            borderSide: BorderSide(width: 1.0),
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
        ),
      ),
    );
  }
}
