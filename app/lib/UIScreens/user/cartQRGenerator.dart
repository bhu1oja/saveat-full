import 'package:flutter/material.dart';
import 'package:saveat/scopedModel/myScopedModel.dart';
import 'package:saveat/widgets/myClipper.dart';
import 'package:saveat/widgets/myGridViewQR.dart';
import 'package:scoped_model/scoped_model.dart';

final MyScopedModel myScopedModel = MyScopedModel();

class CartQRGenerator extends StatefulWidget {
  final String userID;
  CartQRGenerator(this.userID, {Key key}) : super(key: key);
  @override
  _CartQRGeneratorState createState() => _CartQRGeneratorState();
}

class _CartQRGeneratorState extends State<CartQRGenerator> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myScopedModel.fetchQRCodes(widget.userID);
  }

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   body: QrImage(
    //     data: "1234567890",
    //     size: 200.0,
    //   ),
    // );

    return ScopedModel(
      model: myScopedModel,
      child: Scaffold(
          body: ScopedModelDescendant<MyScopedModel>(
              builder: (BuildContext context, _, MyScopedModel myScopedModel) =>
                  ListView(
                    children: <Widget>[
                      ClipPath(
                        clipper: MyClipper(),
                        child: Container(
                          height: 250.0,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(0xff, 32, 168, 74),
                          ),
                          child: Container(
                            margin: EdgeInsets.only(left: 14.0, right: 14.0),
                            child: Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      height: 50.0,
                                      width: 50.0,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                              'https://scontent.fktm8-1.fna.fbcdn.net/v/t1.15752-9/69429050_2353534051391060_3495877802966646784_n.jpg?_nc_cat=111&_nc_oc=AQkzqjyEFvnDhE1mQxDZTP2zfTWL0RHDRR2o23uwACmS1bP3377vZPyQqrVHmU3dlBU&_nc_ht=scontent.fktm8-1.fna&oh=70448f5d5e65eba1963d73638a150a2d&oe=5DE1429D'),
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(50.0),
                                      ),
                                    ),
                                    Icon(
                                      Icons.scanner,
                                      size: 40.0,
                                    )
                                  ],
                                ),
                                Container(
                                  height: 45.0,
                                  margin: EdgeInsets.only(top: 14.0),
                                  child: Padding(
                                    padding: const EdgeInsets.only(),
                                    child: TextField(
                                        decoration: InputDecoration(
                                      contentPadding:
                                          EdgeInsets.symmetric(vertical: 2),
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
                                      hintStyle: TextStyle(
                                          color:
                                              Color.fromRGBO(142, 142, 147, 1)),
                                      hintText: "What you are looking for?",
                                      fillColor: Colors.white,
                                    )),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 37.0),
                                  child: Text('QR Codes',
                                      style: TextStyle(
                                          fontSize: 20.0,
                                          letterSpacing: 0.16,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold)),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Center(
                          child: CartQRGeneratorScoped(
                              myScopedModel, widget.userID))
                    ],
                  ))),
    );
  }
}

class CartQRGeneratorScoped extends StatelessWidget {
  final String userID;
  final MyScopedModel myScopedModel;
  CartQRGeneratorScoped(this.myScopedModel, this.userID, {Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget content = Text('No QR Code data');
    if (myScopedModel.isLoading) {
      content = Center(
        child: CircularProgressIndicator(),
      );
    } else if (!myScopedModel.isLoading && myScopedModel.cart.length > 0) {
      content = _buildListView(context, myScopedModel, userID);
    }
    return content;
  }

  Widget _buildListView(context, MyScopedModel model, userID) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: MyGridViewQR().myGridViewQR(context, model, userID));
  }
}
