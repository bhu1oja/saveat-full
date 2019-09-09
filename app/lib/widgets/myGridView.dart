import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:saveat/data/appData.dart';
import 'package:saveat/routes/route.dart';
import 'package:saveat/scopedModel/myScopedModel.dart';

class MyGridView {
  Widget myGridView(context, MyScopedModel model) {
    return GridView.builder(
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemCount: model.favourites.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            MyRoute.goToProductDetail(
                context, model.favourites[index].productID);
          },
          child: Container(
            padding: EdgeInsets.fromLTRB(4.0, 4.0, 4.0, 8.0),
            margin: EdgeInsets.all(4.0),
            height: MediaQuery.of(context).size.height / 3,
            width: MediaQuery.of(context).size.width / 2.5,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6.0),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(82, 80, 80, 0.5),
                    blurRadius: 5.0,
                  )
                ]),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(Icons.local_activity),
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

                Flexible(
                  flex: 3,
                  child: CachedNetworkImage(
                      imageUrl:
                          AppData.URl + model.favourites[index].productImage),
                ),
                Expanded(
                  child: Text(
                    model.favourites[index].productName,
                    style: TextStyle(
                      fontSize: 15.0,
                      letterSpacing: 0.12,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Nrs' + model.favourites[index].productPrice,
                      style: TextStyle(
                          fontSize: 9.0,
                          fontWeight: FontWeight.w500,
                          color: Color.fromARGB(0xff, 38, 168, 74)),
                    ),
                    Text(
                      '    ' +
                          'Nrs' +
                          model.favourites[index].productDiscountPrice,
                      style: TextStyle(
                        fontSize: 9.0,
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(0xff, 142, 142, 147),
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                    Text(
                      '  (' + "40" + '% off)',
                      style: TextStyle(
                          fontSize: 10.0,
                          fontWeight: FontWeight.w500,
                          color: Color.fromARGB(0xff, 224, 68, 62)),
                    ),
                  ],
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: <Widget>[
                //     Padding(
                //       padding: const EdgeInsets.all(8.0),
                //       child: Container(
                //         decoration: BoxDecoration(
                //             border: Border.all(
                //                 width: 0.5,
                //                 color: Color.fromARGB(0xff, 151, 151, 151)),
                //             borderRadius: BorderRadius.circular(50.0)),
                //         child: Padding(
                //             padding: const EdgeInsets.all(4.0),
                //             child: Icon(
                //               Icons.favorite,
                //               color: Color.fromARGB(0xff, 32, 168, 74),
                //             )),
                //       ),
                //     ),
                //     InkWell(
                //       child: Padding(
                //         padding: const EdgeInsets.all(8.0),
                //         child: Container(
                //           decoration: BoxDecoration(
                //               color: Color.fromARGB(0xff, 65, 117, 5),
                //               borderRadius: BorderRadius.circular(50.0)),
                //           child: Padding(
                //             padding: const EdgeInsets.all(4.0),
                //             child: Icon(
                //               Icons.shopping_cart,
                //               size: 25.0,
                //               color: Colors.white,
                //             ),
                //           ),
                //         ),
                //       ),
                //     ),
                //   ],
                // )
              ],
            ),
          ),
        );
      },
    );
  }
}
