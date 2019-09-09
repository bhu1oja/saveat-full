import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/services.dart';
import 'package:saveat/data/appData.dart';
import 'package:saveat/routes/route.dart';
import 'package:saveat/scopedModel/myScopedModel.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/material.dart';
import 'package:saveat/utils/theme.dart' as AppTheme;

class MyCategoryTab extends StatelessWidget {
    final String userID;
  MyCategoryTab(this.userID, {Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final MyScopedModel catModel = MyScopedModel();
    catModel.fetchCategory();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Color.fromARGB(0xff, 32, 168, 74),
    ));
    return Scaffold(
        body: NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          new SliverAppBar(
            automaticallyImplyLeading: false,
            floating: true,
            elevation: 0,
            snap: true,
            backgroundColor: AppTheme.Colors.primaryColor,
            brightness: Brightness.light,
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(48.0),
              child: Container(
                padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
                alignment: Alignment.center,
                child: TextField(
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide(color: Colors.white, width: 1),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide(
                              color: AppTheme.Colors.grayTwo, width: 1),
                        ),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 2, horizontal: 20),
                        suffixIcon: Icon(
                          Icons.search,
                          color: AppTheme.Colors.white,
                        ),
                        filled: true,
                        hintText: "Search",
                        hintStyle: TextStyle(color: Colors.white))),
              ),
            ),
          ),
        ];
      },
      body: Center(
          child: ScopedModel<MyScopedModel>(
        model: catModel,
        child: CategoryTab(userID),
      )),
    ));
  }
}

class CategoryTab extends StatelessWidget {
  final String userID;
  CategoryTab(this.userID, {Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MyScopedModel>(
      builder: (BuildContext context, Widget child, MyScopedModel model) {
        Widget content = Text('No Categories');
        if (model.isLoading) {
          content = Center(
            child: CircularProgressIndicator(),
          );
        } else if (!model.isLoading && model.categories.length > 0) {
          content = _buildListView(model, userID);
        }
        return content;
      },
    );
  }

  Widget _buildListView(MyScopedModel model, userID) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(top: 16, left: 16, right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "SHOP BY CATEGORY",
            style: TextStyle(fontSize: 12),
          ),
          Divider(),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: model.categories.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  MyRoute.goToProductByCategory(
                      context, model.categories[index].name, userID);
                },
                child: Card(
                  elevation: 4.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.all(16.0),
                        height: 120.0,
                        width: 120.0,
                        child: CachedNetworkImage(
                          imageUrl: AppData.URl + model.categories[index].image,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              padding: const EdgeInsets.all(4.0),
                              child: Text(
                                model.categories[index].name,
                                style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Divider()
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
    // return ListView.builder(
    //   itemBuilder: (BuildContext context, int index) {
    //     return GestureDetector(
    //       onTap: () {
    //         MyRoute.goToProductByCategory(
    //             context, model.categories[index].name);
    //       },
    //       child: Stack(
    //         alignment: FractionalOffset.topRight,
    //         children: <Widget>[
    //           Container(
    //             padding: const EdgeInsets.fromLTRB(4.0, 4.0, 4.0, 0),
    //             child: Card(
    //               elevation: 4.0,
    //               child: Row(
    //                 mainAxisAlignment: MainAxisAlignment.start,
    //                 crossAxisAlignment: CrossAxisAlignment.start,
    //                 children: <Widget>[
    //                   Card(
    //                     child: Container(
    //                       padding: const EdgeInsets.all(16.0),
    //                       height: 100.0,
    //                       width: 100.0,
    //                       decoration: BoxDecoration(
    //                         image: DecorationImage(
    //                           image: NetworkImage(
    //                             AppData.URl + model.categories[index].image,
    //                           ),
    //                           fit: BoxFit.cover,
    //                         ),
    //                       ),
    //                     ),
    //                   ),
    //                   Container(
    //                     alignment: Alignment.center,
    //                     padding: const EdgeInsets.all(16.0),
    //                     child: Column(
    //                       crossAxisAlignment: CrossAxisAlignment.start,
    //                       mainAxisAlignment: MainAxisAlignment.start,
    //                       children: <Widget>[
    //                         Container(
    //                           padding: const EdgeInsets.all(4.0),
    //                           child: Text(
    //                             model.categories[index].name,
    //                             style: TextStyle(
    //                                 fontSize: 15.0,
    //                                 fontWeight: FontWeight.bold),
    //                           ),
    //                         ),
    //                       ],
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //             ),
    //           ),
    //         ],
    //       ),
    //     );
    //   },
    //   itemCount: model.categories.length,
    // );
  }
}
