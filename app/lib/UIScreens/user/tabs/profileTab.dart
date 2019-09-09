import 'package:flutter/material.dart';
import 'package:saveat/routes/route.dart';
import 'package:saveat/widgets/myToast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileTab extends StatefulWidget {
  @override
  _ProfileTabState createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  SharedPreferences sharedPreferences;
  bool checkValue = false;
  String name, email, type;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getCredential();
  }

  _getCredential() async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      checkValue = sharedPreferences.getBool("check");
      if (checkValue != null) {
        if (checkValue) {
          setState(() {
            email = sharedPreferences.getString("Email");
            name = sharedPreferences.getString("Name");
            type = sharedPreferences.getString("Type");
          });
        } else {
          sharedPreferences.clear();
        }
      } else {
        checkValue = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                height: 140.0,
                color: Color.fromARGB(0xff, 32, 168, 74),
              ),
              Container(
                margin: EdgeInsets.only(top: 40.0, left: 20, right: 20.0),
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
                      margin: EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              'https://scontent.fktm8-1.fna.fbcdn.net/v/t1.15752-9/69429050_2353534051391060_3495877802966646784_n.jpg?_nc_cat=111&_nc_oc=AQkzqjyEFvnDhE1mQxDZTP2zfTWL0RHDRR2o23uwACmS1bP3377vZPyQqrVHmU3dlBU&_nc_ht=scontent.fktm8-1.fna&oh=70448f5d5e65eba1963d73638a150a2d&oe=5DE1429D'),
                        ),
                        borderRadius: BorderRadius.circular(50.0),
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
                                  name == null ? 'Loading ..' : name,
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    color: Color.fromARGB(0xff, 32, 168, 74),
                                  ),
                                ),
                                Text(
                                  email == null ? '..' : email,
                                  style: TextStyle(
                                      fontSize: 12.0,
                                      color:
                                          Color.fromARGB(0xff, 160, 160, 160)),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 15.0),
                            child: Icon(
                              Icons.edit,
                              size: 20.0,
                              color: Color.fromARGB(0xff, 160, 160, 160),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
          InkWell(
            onTap: () {
              myToast("My Orders", context);
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 35.0),
              child: ListTile(
                leading: Icon(
                  Icons.shopping_cart,
                  color: Color.fromARGB(0xff, 32, 168, 74),
                ),
                title: Text(
                  "My Orders",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              sharedPreferences.clear();
              MyRoute.goToLogin(context);
              myToast("Logout Successful", context);
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 35.0),
              child: ListTile(
                leading: Icon(
                  Icons.exit_to_app,
                  color: Color.fromARGB(0xff, 32, 168, 74),
                ),
                title: Text("Logout"),
                //trailing: Icon(Icons.exit_to_app),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
