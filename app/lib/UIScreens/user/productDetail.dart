import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:saveat/data/appData.dart';
import 'package:saveat/routes/route.dart';
import 'package:saveat/scopedModel/myScopedModel.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:saveat/utils/theme.dart' as AppTheme;
import 'package:shared_preferences/shared_preferences.dart';

final MyScopedModel myScopedModel = MyScopedModel();
SharedPreferences sharedPreferences;
bool checkValue = false;
String name, email, type, userID;

class ProductDetail extends StatefulWidget {
  final String productID;

  ProductDetail(this.productID, {Key key}) : super(key: key);

  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getCredential();
    myScopedModel.fetchfavouriteSingleProduct(userID, widget.productID);
    myScopedModel.fetchProductDetail(widget.productID);
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
            userID = sharedPreferences.getString("id");
          });
        } else {
          sharedPreferences.clear();
        }
      } else {
        checkValue = false;
      }
    });
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

  @override
  Widget build(BuildContext context) {
    return ScopedModel(
      model: myScopedModel,
      child: Scaffold(
          body: ScopedModelDescendant<MyScopedModel>(
              builder: (BuildContext context, _, MyScopedModel myScopedModel) =>
                  NestedScrollView(
                    headerSliverBuilder:
                        (BuildContext context, bool innerBoxIsScrolled) {
                      return <Widget>[
                        new SliverAppBar(
                          floating: true,
                          elevation: 0,
                          snap: true,
                          backgroundColor: AppTheme.Colors.primaryColor,
                          brightness: Brightness.light,
                          leading: IconButton(
                            icon: Icon(Icons.close),
                            color: AppTheme.Colors.white,
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          actions: <Widget>[
                            IconButton(
                              icon: Icon(Icons.share),
                              color: AppTheme.Colors.white,
                              onPressed: () {},
                            ),
                            IconButton(
                              icon: Icon(Icons.favorite),
                              color: AppTheme.Colors.white,
                              onPressed: () {
                                myScopedModel.postFavourite(
                                    userID,
                                    widget.productID,
                                    myScopedModel.productDetail['name'],
                                    myScopedModel.productDetail['productImage'],
                                    myScopedModel.productDetail['price'],
                                    myScopedModel.productDetail['discount'],
                                    context);
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.shopping_cart),
                              color: AppTheme.Colors.white,
                              onPressed: () {
                                MyRoute.goToCart(context, userID);
                              },
                            ),
                          ],
                        ),
                      ];
                    },
                    body: Center(
                      child:
                          ProductDetailScoped(widget.productID, myScopedModel),
                    ),
                  ))),
    );
  }
}

class ProductDetailScoped extends StatelessWidget {
  final String productID;
  final MyScopedModel myScopedModel;
  ProductDetailScoped(this.productID, this.myScopedModel, {Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget content = Text('No Product Detail');
    if (myScopedModel.isLoading || myScopedModel.userDetail['name'] == "") {
      content = Center(
        child: CircularProgressIndicator(),
      );
    } else if (!myScopedModel.isLoading) {
      content = productDetailBody(
          context, MediaQuery.of(context).size.width, myScopedModel, productID);
    }
    return content;
  }
}

Widget productDetailBody(
    context, parentWidth, MyScopedModel model, String productId) {
  final _controller = PageController();
  return MediaQuery.removePadding(
    context: context,
    removeTop: true,
    child: ListView(
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height / 1.5,
          child: PageView(
            controller: _controller,
            children: <Widget>[
              CachedNetworkImage(
                imageUrl: AppData.URl + model.productDetail['productImage'],
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
              CachedNetworkImage(
                imageUrl:
                    "https://images.unsplash.com/photo-1550411294-875307bccdd5?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80",
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
              CachedNetworkImage(
                imageUrl:
                    "https://images.unsplash.com/photo-1556929361-bb46fb0b4e20?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1050&q=80",
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
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16, left: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                model.productDetail['name'],
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  children: <Widget>[
                    Text(
                      "Rs  ${model.productDetail['price']}  ",
                      style: TextStyle(
                          fontSize: 12,
                          color: AppTheme.Colors.primaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Rs  ${model.productDetail['discount']}  ",
                      style: TextStyle(
                          fontSize: 8,
                          decoration: TextDecoration.lineThrough,
                          color: AppTheme.Colors.mediumGray,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      " (${(1 - (int.parse(model.productDetail['price']) / int.parse(model.productDetail['price']))) * 100} %)",
                      style: TextStyle(
                          fontSize: 12,
                          color: AppTheme.Colors.statusRed,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Text(
                "Best buy Date : ${model.productDetail['bestBuyDate']}",
                style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 40,
              ),
              Text(
                "SELLER INFO",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      model.userDetail['name'],
                      style: TextStyle(
                          color: AppTheme.Colors.primaryColor,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: <Widget>[
                        Container(
                          height: 20,
                          width: 40,
                          decoration: BoxDecoration(
                              color: AppTheme.Colors.primaryColor,
                              borderRadius: BorderRadius.circular(3)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Text(
                                "3.8",
                                style:
                                    TextStyle(color: Colors.white, fontSize: 8),
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.white,
                                size: 14,
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            "(11203 ratings)",
                            style: TextStyle(fontSize: 8),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Text(
                "PRODUCT INFO",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  "Description",
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                ),
              ),
              Text(
                model.productDetail['description'],
                style: TextStyle(fontSize: 8),
              )
            ],
          ),
        ),
        Divider(),
        SizedBox(
          height: 50,
        ),
        InkWell(
          onTap: () {
            model.postCartData(
                userID,
                productId,
                model.productDetail['name'],
                model.productDetail['category'],
                model.productDetail['productImage'],
                model.productDetail['discount'],
                model.productDetail['vendorID'],
                model.userDetail['name'],
                context);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              padding: EdgeInsets.all(14),
              decoration: BoxDecoration(
                  color: AppTheme.Colors.primaryColor,
                  borderRadius: BorderRadius.circular(25)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.shopping_cart,
                    color: Colors.white,
                  ),
                  Text(
                    "Add to Cart",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w600),
                  )
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: 100,
        )
      ],
    ),
  );
}
