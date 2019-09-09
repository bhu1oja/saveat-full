import 'package:flutter/material.dart';

class StaticSearchUI {
  Widget staticSearchUI() {
    return Container(
      height: 45.0,
      margin: EdgeInsets.only(top: 14.0),
      child: Padding(
        padding: const EdgeInsets.only(),
        child: TextField(
            decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 2),
          prefixIcon: Icon(
            Icons.search,
            color: Color.fromRGBO(142, 142, 147, 1),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(2),
            borderSide: BorderSide(
              width: 0,
              style: BorderStyle.none,
            ),
          ),
          filled: true,
          hintStyle: TextStyle(color: Color.fromRGBO(142, 142, 147, 1)),
          hintText: "What you are looking for?",
          fillColor: Colors.white,
        )),
      ),
    );
  }
}
