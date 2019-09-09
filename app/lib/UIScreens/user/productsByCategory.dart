import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:saveat/scopedModel/myScopedModel.dart';
import 'package:saveat/widgets/myListView.dart';
import 'package:scoped_model/scoped_model.dart';

class ProductByCategory extends StatelessWidget {
  final String category, userID;
  ProductByCategory(this.category, this.userID, {Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final MyScopedModel proModel = MyScopedModel();
    proModel.fetchProductByCategory(category);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Color.fromARGB(0xff, 32, 168, 74),
    ));
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Color.fromARGB(0xff, 32, 168, 74),
          leading: InkWell(
            onTap: Navigator.of(context).pop,
            child: Icon(Icons.chevron_left, size: 40),
          ),
          title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                category,
                style: TextStyle(
                  letterSpacing: -0.41,
                  fontSize: 17.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Text(
                  '(${proModel.products.length.toString()}   items)',
                  style: TextStyle(
                    fontSize: 8.0,
                    letterSpacing: -0.35,
                  ),
                ),
              ),
            ],
          ),
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(50.0),
            child: Container(
                color: Colors.white,
                child: Column(children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          InkWell(
                            onTap: () {
                              //_filterBottomSheet(context);
                            },
                            child: Row(
                              children: <Widget>[
                                Icon(Icons.sort,
                                    color: Color.fromARGB(0xff, 142, 142, 147)),
                                Text(
                                  'Sort',
                                  style: TextStyle(
                                      color:
                                          Color.fromARGB(0xff, 142, 142, 147)),
                                )
                              ],
                            ),
                          ),
                          Container(
                            height: 15,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 0.5,
                                    color:
                                        Color.fromARGB(0xff, 142, 142, 147))),
                          ),
                          InkWell(
                            onTap: () {
                              // _filterBottomSheet(context);
                            },
                            child: Row(
                              children: <Widget>[
                                Icon(Icons.filter_list,
                                    color: Color.fromARGB(0xff, 142, 142, 147)),
                                Text(
                                  'Filter',
                                  style: TextStyle(
                                      color:
                                          Color.fromARGB(0xff, 142, 142, 147)),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ])),
          ),
        ),
        body: ScopedModel<MyScopedModel>(
          model: proModel,
          child: ProductByCategoryScoped(userID),
        ));
  }
}

class ProductByCategoryScoped extends StatelessWidget {
  final String userID;
  ProductByCategoryScoped(this.userID, {Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MyScopedModel>(
      builder: (BuildContext context, Widget child, MyScopedModel model) {
        Widget content = Text('No Products');
        if (model.isLoading) {
          content = Center(
            child: CircularProgressIndicator(),
          );
        } else if (!model.isLoading && model.products.length > 0) {
          content = MyListView()
              .myListView(MediaQuery.of(context).size.width, model, userID);
        }
        return content;
      },
    );
  }
}
