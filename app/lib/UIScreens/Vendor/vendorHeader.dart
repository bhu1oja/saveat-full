import 'package:flutter/material.dart';

class VendorHeader {
  Widget vendorHeader(context, name, address) {
    return Stack(
      children: <Widget>[
        Container(
          height: 140.0,
          color: Color.fromARGB(0xff, 32, 168, 74),
        ),
        Container(
          margin: EdgeInsets.only(top: 80.0, left: 20, right: 20.0),
          height: 120,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
                width: 0.3, color: Color.fromARGB(0xff, 160, 160, 160)),
          ),
          child: Row(
            children: <Widget>[
              Container(
                width: 80.0,
                height: 80.0,
                margin: EdgeInsets.all(10.0),
                child: Image.asset(
                  'assets/logo.png',
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width - 161,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            name,
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(0xff, 32, 168, 74),
                            ),
                          ),
                          Text(
                            address,
                            style: TextStyle(
                              fontSize: 12.0,
                              color: Color.fromARGB(0xff, 160, 160, 160),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
