import 'package:cached_network_image/cached_network_image.dart';
import 'package:saveat/data/appData.dart';
import 'package:saveat/widgets/myClipper.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/material.dart';
import 'package:saveat/scopedModel/myScopedModel.dart';
import 'package:saveat/routes/route.dart';

class MyCart extends StatelessWidget {
  final String userID;
  MyCart(this.userID,  {Key key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final MyScopedModel myScopedModel = MyScopedModel();
    myScopedModel.fetchCart(userID);
  
    return Scaffold(
      body: ScopedModel<MyScopedModel>(
        model: myScopedModel,
        child: ListView(
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                        ),
                      IconButton(icon: Icon(Icons.scanner),
                      onPressed: (){MyRoute.goToQRGenerator(context, userID);},)
                      ],
                    ),
                    Container(
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
                          hintStyle: TextStyle(
                              color: Color.fromRGBO(142, 142, 147, 1)),
                          hintText: "What you are looking for?",
                          fillColor: Colors.white,
                        )),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 37.0),
                      child: Text('Shopping Cart',
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
        
              MycartScoped(userID)
               ],
            ),
          
        ),
    );
  }
}

class MycartScoped extends StatelessWidget {
   final String userID;
  MycartScoped(this.userID,  {Key key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MyScopedModel>(
      builder: (BuildContext context, Widget child, MyScopedModel myScopedModel) {
        Widget content = Text('No Cart data');
        if (myScopedModel.isLoading) {
          content = Center(
            child: CircularProgressIndicator(),
          );
        } else if (!myScopedModel.isLoading && myScopedModel.cart.length > 0) {
          content = _buildListView(myScopedModel, userID,context);
         
        }
         return content;
      },
      
    );
  }

  Widget _buildListView(MyScopedModel model,userID, context) {
    return     Container(
            margin: EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              children: <Widget>[
                Divider(
                  color: Color.fromARGB(0xff, 151, 151, 151),
                ), ListView.builder(
                 itemCount: model.cart.length,
                 shrinkWrap: true,
                 physics: NeverScrollableScrollPhysics(),
                 itemBuilder: (BuildContext context, int index) {
                 return GestureDetector(
                   onTap: (){
                     MyRoute.goToProductDetail(context, model.cart[index].productID);
                   },
                   child: Column(
      children: <Widget>[
        SizedBox(
          height: 13.5,
        ),
        Container(
          child: Row(
            children: <Widget>[
              Container(
                width: 87.0,
                height: 87.0,
                margin: EdgeInsets.only(right: 13.0),
                child: CachedNetworkImage(
                  imageUrl: AppData.URl + model.cart[index].productImage,
                  fit: BoxFit.cover,
                )
                
              ),
              Container(
                width: MediaQuery.of(context).size.width - 148,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                 model.cart[index].productCategory,
                                  style: TextStyle(
                                    fontSize: 10.0,
                                    letterSpacing: 0.13,
                                    color: Color.fromARGB(0xff, 11, 34, 66),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Text(
                                '\$' + (model.cart[index].total * model.cart[index].quantity).toString(),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12.0,
                                  letterSpacing: 0.12,
                                  color: Color.fromARGB(0xff, 208, 2, 27),
                                ),
                              )
                            ],
                          ),
                          Text(
                           model.cart[index].productName,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12.0,
                              letterSpacing: 0.12,
                              color: Color.fromARGB(0xff, 32, 168, 74),
                            ),
                          ),
                          SizedBox(
                            height: 27.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                'QTY: ${model.cart[index].quantity}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12.0,
                                  letterSpacing: 0.12,
                                  color: Color.fromARGB(0xff, 32, 168, 74),
                                ),
                              ),
                              Row(
                                children: <Widget>[
                                  InkWell(
                                    onTap: () {
                                     model.postCartDataDecrease(model.cart[index].productID, userID, context);
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 0.5,
                                              color: Color.fromARGB(
                                                  0xff, 151, 151, 151)),
                                          borderRadius:
                                              BorderRadius.circular(50.0)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(0.0),
                                        child: Icon(
                                          Icons.remove,
                                          size: 15.0,
                                          color:
                                              Color.fromARGB(0xff, 32, 168, 74),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5.0),
                                    child: Text('${model.cart[index].quantity}'),
                                  ),
                                  InkWell(
                                    onTap: () {
                                   model.postCartDataIncrease(model.cart[index].productID, userID, context);
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color:
                                              Color.fromARGB(0xff, 32, 168, 74),
                                          borderRadius:
                                              BorderRadius.circular(50.0)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(0.0),
                                        child: Icon(
                                          Icons.add,
                                          size: 15.0,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 13,
        ),
        Divider(
          color: Color.fromARGB(0xff, 151, 151, 151),
        ),
      ],
    ),
                 );
               },),
                InkWell(
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => PaymentOption(),
                    //   ),
                    // );
                    model.postCartCheckout(userID, context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Container(
                      height: 40.0,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(0xff, 65, 117, 5),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Checkout',
                          style: TextStyle(
                              fontSize: 17.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              letterSpacing: -0.41),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                )
        ],)
      );
  }
}
