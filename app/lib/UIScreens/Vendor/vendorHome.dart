import 'package:flutter/material.dart';
import 'package:saveat/UIScreens/Vendor/vendorHeader.dart';
import 'package:saveat/routes/route.dart';
import 'package:saveat/scopedModel/myScopedModel.dart';
import 'package:saveat/widgets/myToast.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences sharedPreferences;
bool checkValue = false;
String name, email, vendorId;
final MyScopedModel proModel = MyScopedModel();

class VendorHome extends StatefulWidget {
  @override
  _VendorHomeState createState() => _VendorHomeState();
}

class _VendorHomeState extends State<VendorHome> {
  String _reader = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getCredential();
    proModel.fetchProductByVendorID(vendorId);
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
            vendorId = sharedPreferences.getString("id");
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
    return ScopedModel(
        model: proModel,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: ScopedModelDescendant<MyScopedModel>(
            builder: (BuildContext context, _, MyScopedModel proModel) =>
                (ListView(
                  children: <Widget>[
                    VendorHeader().vendorHeader(context, name, email),
                    Container(
                      margin: EdgeInsets.only(top: 41.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          SizedBox(
                            width: 20.0,
                          ),
                          Container(
                            //height: 30,
                            width: 95.0,
                            decoration: BoxDecoration(
                                color: Color.fromARGB(0xff, 32, 168, 74),
                                borderRadius: BorderRadius.circular(20)),
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Text(
                                    (proModel.productLength()).toString(),
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Text(
                                    'Added Products',
                                    style: TextStyle(
                                        fontSize: 8,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            //height: 30,
                            width: 95.0,
                            decoration: BoxDecoration(
                                color: Color.fromARGB(0xff, 32, 168, 74),
                                borderRadius: BorderRadius.circular(20)),
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Text(
                                    vendorId,
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Text(
                                    'Sold Products',
                                    style: TextStyle(
                                        fontSize: 8,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 20.0,
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        MyRoute.goToProductByVendorID(context, vendorId);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 35.0),
                        child: ListTile(
                          leading: Icon(
                            Icons.shopping_cart,
                            color: Color.fromARGB(0xff, 32, 168, 74),
                          ),
                          title: Text(
                            "My Products",
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        //MyRoute.goToQRScanner(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 35.0),
                        child: ListTile(
                          leading: Icon(
                            Icons.shopping_cart,
                            color: Color.fromARGB(0xff, 32, 168, 74),
                          ),
                          title: Text(
                            "Scan client's QR ",
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        myToast("Order History", context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 35.0),
                        child: ListTile(
                          leading: Icon(
                            Icons.history,
                            color: Color.fromARGB(0xff, 32, 168, 74),
                          ),
                          title: Text(
                            "Order History",
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
                )),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              MyRoute.goToAddNewProduct(context);
            },
            tooltip: 'Pick Image',
            child: Icon(Icons.add),
          ),
        ));
  }
}
