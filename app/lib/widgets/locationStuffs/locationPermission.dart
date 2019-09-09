import 'package:flutter/material.dart';
import 'package:saveat/routes/route.dart';

class LocationPermession extends StatefulWidget {
  @override
  _LocationPermessionState createState() => _LocationPermessionState();
}

class _LocationPermessionState extends State<LocationPermession> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 60),
          child: ListView(
            children: <Widget>[
              Container(
                child: Text(
                  "Hello, Welcome to\nFamily",
                  style: TextStyle(
                      color: Colors.green,
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 21),
                child:
                    Text("Set your location to start find stores\narround you"),
              ),
              InkWell(
                onTap: () {
                  MyRoute.goToUserHome(context);
                },
                child: Container(
                  margin: EdgeInsets.only(top: 30, left: 0.0, right: 0.0),
                  width: MediaQuery.of(context).size.width,
                  height: 50.0,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(0xff, 65, 117, 5),
                    borderRadius: BorderRadius.all(
                      Radius.circular(30.0),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "Use your Current Location",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 34),
                child: Text(
                    "We only access your location while you are using\this amazing app"),
              ),
              InkWell(
                splashColor: Colors.green,
                onTap: () {},
                child: Container(
                  margin: EdgeInsets.only(top: 44),
                  child: Text(
                    "or set your location manually",
                    style:
                        TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
