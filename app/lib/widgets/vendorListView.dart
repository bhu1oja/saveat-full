import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:saveat/data/appData.dart';
import 'package:saveat/routes/route.dart';
import 'package:saveat/scopedModel/myScopedModel.dart';
import 'package:saveat/utils/theme.dart' as AppTheme;

class VendorListView {
  Widget vendorListView(width, context, MyScopedModel model) {
    return ListView.builder(
      itemCount: model.products.length,
      itemBuilder: (BuildContext context, int i) {
        return GestureDetector(
          onTap: () {
            _showDialog(context, model, model.products[i].id);
          },
          child: Container(
            //height: 116.0,
            margin: EdgeInsets.only(top: 16.0),
            decoration: BoxDecoration(
                border: Border(
              left: BorderSide(
                width: 1,
                color: Color.fromRGBO(0, 0, 0, 0.16),
              ),
              right: BorderSide(
                width: 1,
                color: Color.fromRGBO(0, 0, 0, 0.16),
              ),
              bottom: BorderSide(
                width: 1,
                color: Color.fromRGBO(0, 0, 0, 0.16),
              ),
            )),
            child: Row(
              children: <Widget>[
                Container(
                  width: 104.0,
                  height: 116.0,
                  decoration: BoxDecoration(
                      border: Border(
                          right: BorderSide(
                              width: 1,
                              color: Color.fromARGB(0xff, 151, 151, 151)))),
                  child: CachedNetworkImage(
                    imageUrl: AppData.URl + model.products[i].productImage,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Center(
                          child: Container(
                            alignment: Alignment.center,
                            color: AppTheme.Colors.grayTwo,
                            child: CircularProgressIndicator(
                              backgroundColor: AppTheme.Colors.primaryColor,
                            ),
                          ),
                        ),
                    errorWidget: (context, url, error) =>
                        Center(child: Icon(Icons.error)),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width - 149,
                  margin: EdgeInsets.only(right: 5.0, left: 10),
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 18.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Icon(
                                  Icons.local_activity,
                                  size: 15.0,
                                ),
                                Text(
                                  '0.5 Mile away',
                                  style: TextStyle(
                                    fontSize: 10.0,
                                    letterSpacing: 0.42,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              child: Icon(Icons.edit,
                                  size: 25.0,
                                  color: AppTheme.Colors.primaryColor),
                              padding: const EdgeInsets.all(4.0),
                            )
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            model.products[i].name,
                            style: TextStyle(
                                color: Color.fromARGB(0xff, 32, 168, 74),
                                fontWeight: FontWeight.bold),
                          ),
                          InkWell(
                            onTap: () {
                              model.deleteProduct(
                                  model.products[i].id, context);
                            },
                            child: Padding(
                              child: Icon(Icons.delete,
                                  size: 25.0,
                                  color: AppTheme.Colors.primaryColor),
                              padding: const EdgeInsets.all(4.0),
                            ),
                          )
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 30.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Text(
                                  "Rs ${model.products[i].price}",
                                  style: TextStyle(
                                      fontSize: 10.0,
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.lineThrough),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text(
                                    "  Rs ${model.products[i].discount} ",
                                    style: TextStyle(
                                        fontSize: 10.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  _showDialog(context, MyScopedModel model, pID) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Choose an action..."),
          actions: <Widget>[
            FlatButton(
              child: Text("Edit"),
              onPressed: null,
            ),
            FlatButton(
              child: Text("Delete"),
              onPressed: () {
                model.deleteProduct(pID, context);
                Navigator.pop(context);
                model.fetchProductByVendorID("bhuwan");
              },
            ),
          ],
        );
      },
    );
  }
}
