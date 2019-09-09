import 'dart:io';
import 'package:flutter/material.dart';
import 'package:saveat/UIScreens/Vendor/vendorHeader.dart';
import 'package:saveat/model/Category.dart';
import 'package:saveat/scopedModel/myScopedModel.dart';
import 'package:saveat/widgets/myToast.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';

SharedPreferences sharedPreferences;
bool checkValue = false;
String name, email, type, vendorId;
String _mySelection;

final MyScopedModel model = MyScopedModel();

class AddNewProduct extends StatefulWidget {
  @override
  _AddNewProductState createState() => _AddNewProductState();
}
 
File image;
class _AddNewProductState extends State<AddNewProduct> {
  final TextEditingController pNameController = new TextEditingController();
  final TextEditingController pDescController = new TextEditingController();
  final TextEditingController pPriceController = new TextEditingController();
  final TextEditingController pDiscPriceController =
      new TextEditingController();
  final TextEditingController pBestBDController = new TextEditingController();
  final TextEditingController pCatController = new TextEditingController();


 

 takePicture() async {
    print('Picker is called');
    File img = await ImagePicker.pickImage(source: ImageSource.camera);
//    File img = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (img != null) {
      image = img;
      setState(() {});
    }
    Navigator.pop(context);
  }

  choosePicture() async {
    print('Picker is called');
    File img = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (img != null) {
      image = img;
      setState(() {});
    }
    Navigator.pop(context);
  }
   void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Take Picture From"),
          actions: <Widget>[
            FlatButton(
              child: Text("Camera"),
              onPressed: takePicture,
            ),
            FlatButton(
              child: Text("Gallery"),
              onPressed: choosePicture,
            ),
          ],
        );
      },
    );
  }

 
  void initState() {
    // TODO: implement initState
    super.initState();
    _getCredential();
    model.fetchCategory();
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
      model: model, 
      child: Scaffold(
      backgroundColor: Colors.white,
      body: ScopedModelDescendant<MyScopedModel>(
        builder: (BuildContext context,_, MyScopedModel model) => (ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              VendorHeader().vendorHeader(context,name,email),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 14.0),
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 33.0),
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Added New Product',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 21, top: 65),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 0.1,
                              color: Color.fromARGB(0xff, 119, 134, 158),
                            ),
                          ),
                          height: 120,
                          width: 120,
                         
                          child:image == null
                          ? Icon(
                              Icons.add_a_photo,
                              size: 50.0,
                            )
                          : Image.file(image),
                        ),
                        InkWell(
                          onTap: _showDialog
                          ,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: Container(
                              margin: EdgeInsets.only(top: 15),
                              decoration: BoxDecoration(
                                border:
                                    Border.all(width: 0.5, color: Colors.green),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15.0),
                                ),
                              ),
                              height: 30.0,
                              width: 95.0,
                              child: Center(
                                child: Text(
                                  "Add Image",
                                  style: TextStyle(
                                      fontSize: 8, color: Colors.green),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 12.0),
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 32.0),
                      child: TextField(
                        controller: pNameController,
                        decoration: InputDecoration(
                          labelText: " Item Name",
                          labelStyle: TextStyle(
                              color: Color.fromARGB(0xff, 32, 168, 74),
                              fontSize: 12),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(width: 1.0),
                            borderRadius: BorderRadius.all(
                              Radius.circular(20.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20.0),
                      child: TextField(
                        maxLines: 5,
                        controller: pDescController,
                        decoration: InputDecoration(
                          labelText: "Item Description",
                          labelStyle: TextStyle(
                              color: Color.fromARGB(0xff, 32, 168, 74),
                              fontSize: 12),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(width: 1.0),
                            borderRadius: BorderRadius.all(
                              Radius.circular(20.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20.0),
                      child: TextField(
                        controller: pBestBDController,
                        decoration: InputDecoration(
                          suffixIcon: Icon(
                            Icons.event_available,
                            color: Color.fromARGB(0xff, 32, 168, 74),
                          ),
                          labelText: "  Best Buy Date",
                          labelStyle: TextStyle(
                              color: Color.fromARGB(0xff, 32, 168, 74),
                              fontSize: 12),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(width: 1.0),
                            borderRadius: BorderRadius.all(
                              Radius.circular(20.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20.0),
                      child: TextField(
                        controller: pPriceController,
                        decoration: InputDecoration(
                          labelText: "  Original Price",
                          labelStyle: TextStyle(
                              color: Color.fromARGB(0xff, 32, 168, 74),
                              fontSize: 12),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(width: 1.0),
                            borderRadius: BorderRadius.all(
                              Radius.circular(20.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20.0),
                      child: TextField(
                        controller: pDiscPriceController,
                        decoration: InputDecoration(
                          labelText: "  Discounted Price",
                          labelStyle: TextStyle(
                              color: Color.fromARGB(0xff, 32, 168, 74),
                              fontSize: 12),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(width: 1.0),
                            borderRadius: BorderRadius.all(
                              Radius.circular(20.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50.0,
                      margin: EdgeInsets.only(top: 20.0),
                       decoration: new BoxDecoration(
                  color: Colors.white,
               borderRadius: BorderRadius.all(Radius.circular(20)
               ),
                border: Border.all(
                    color: Colors.green,
                    width: 2.0
                )
                    ),
              
                      child: Center(child: DropdownButton<String>(
                          isExpanded: true,
                          isDense: false,
                           hint: new Text("Select Category", style: TextStyle(
                              color: Color.fromARGB(0xff, 32, 168, 74),
                              fontSize: 12),),
                         value: _mySelection,
                         onChanged: (String newValue) {

              setState(() {
                _mySelection = newValue;
              });
            },
            items: model.categories.map((Category cat) {
              return new DropdownMenuItem<String>(
                value: cat.name,
                child: new Text(
                  cat.name,
                ),
              );
            }).toList(),
          ),)
                    ),
                    InkWell(
                      onTap: () {
                        if(pNameController.text.toString() == "" || pDescController.text.toString() == ""  || pPriceController.text.toString() == "" || pDiscPriceController == ""
                        || pBestBDController.text.toString() == "" || _mySelection == ""  || image == null){
                          myToast('Enter all fields..', context);
                        }else{
                           model.postProduct(
                            pNameController.text.toString(),
                            pDescController.text.toString(),
                            pPriceController.text.toString(),
                            pDiscPriceController.text.toString(),
                            pBestBDController.text.toString(),
                            _mySelection.toString(),
                            vendorId,
                             image,
                            context);
                        }
                       

                            
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 30, left: 0.0, right: 0.0),
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
                            "Add Product",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20.0),
                width: MediaQuery.of(context).size.width / 2.5,
                height: 10.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.0),
                  ),
                  color: Color.fromARGB(0xff, 238, 238, 238),
                ),
              )
            ],
          ),
        ],
      ))
      )
    ),
    );
  }
}
