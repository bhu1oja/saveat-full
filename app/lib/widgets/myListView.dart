import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:saveat/data/appData.dart';
import 'package:saveat/routes/route.dart';
import 'package:saveat/scopedModel/myScopedModel.dart';
import 'package:saveat/utils/theme.dart' as AppTheme;

class MyListView {
  Widget myListView(width, MyScopedModel model, uID) {
    return Container(
        width: width,
        child: ListView.builder(
          itemCount: model.products.length,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int i) {
            return GestureDetector(
                onTap: () {
                  MyRoute.goToProductDetail(context, model.products[i].id);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Card(
                    child: Container(
                      height: 120,
                      child: Row(
                        children: <Widget>[
                          Flexible(
                              flex: 2,
                              child: Stack(
                                children: <Widget>[
                                  Container(
                                    decoration: BoxDecoration(
                                        border: Border(
                                            right: BorderSide(
                                                color: Colors.black,
                                                width: 1))),
                                    child: CachedNetworkImage(
                                      imageUrl: AppData.URl +
                                          model.products[i].productImage,
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) => Center(
                                            child: Container(
                                              alignment: Alignment.center,
                                              color: AppTheme.Colors.grayTwo,
                                              child: CircularProgressIndicator(
                                                backgroundColor: AppTheme
                                                    .Colors.primaryColor,
                                              ),
                                            ),
                                          ),
                                      errorWidget: (context, url, error) =>
                                          Center(child: Icon(Icons.error)),
                                    ),
                                  ),
                                  // Positioned(
                                  //   top: 2,
                                  //   left: 2,
                                  //  child: setFavIcon(model.favourites[i].liked),
                                  // )
                                ],
                              )),
                          Flexible(
                            flex: 4,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Icon(
                                            Icons.location_on,
                                            size: 14,
                                          ),
                                          Text(
                                            "0.5 Miles away",
                                            style: TextStyle(fontSize: 7),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        model.products[i].name,
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Text(
                                            "Rs ${model.products[i].price}",
                                            style: TextStyle(
                                                fontSize: 8,
                                                color: AppTheme
                                                    .Colors.primaryColor,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            "  Rs ${model.products[i].discount} ",
                                            style: TextStyle(
                                                fontSize: 8,
                                                decoration:
                                                    TextDecoration.lineThrough,
                                                color:
                                                    AppTheme.Colors.mediumGray,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            " (${(1 - (int.parse(model.products[i].discount)) / int.parse(model.products[i].price))} %)",
                                            style: TextStyle(
                                                fontSize: 8,
                                                color:
                                                    AppTheme.Colors.statusRed,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            "Best buy Date : ${model.products[i].bestBuyDate}",
                                            style: TextStyle(
                                                fontSize: 8,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          // InkWell(
                                          //   onTap: () {
                                          //     model.postCartData(
                                          //         uID,
                                          //         model.products[i].id,
                                          //         model.products[i].name,
                                          //         model.products[i].category,
                                          //         model
                                          //             .products[i].productImage,
                                          //         context);
                                          //   },
                                          //   child: Container(
                                          //     padding: EdgeInsets.symmetric(
                                          //         horizontal: 16, vertical: 4),
                                          //     decoration: BoxDecoration(
                                          //         color: Color.fromARGB(
                                          //             0xff, 65, 117, 5),
                                          //         borderRadius:
                                          //             BorderRadius.circular(
                                          //                 20.0)),
                                          //     child: Icon(
                                          //       Icons.shopping_cart,
                                          //       size: 15.0,
                                          //       color: Colors.white,
                                          //     ),
                                          //   ),
                                          // )
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ));
          },
        ));
  }

  setFavIcon(liked) {
    Icon favicon;
    if (liked) {
      favicon = Icon(Icons.favorite, color: AppTheme.Colors.primaryColor);
    } else {
      favicon =
          Icon(Icons.favorite_border, color: AppTheme.Colors.primaryColor);
    }
    return favicon;
  }
}
