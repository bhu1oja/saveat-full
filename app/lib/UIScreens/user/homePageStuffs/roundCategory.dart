import 'package:flutter/material.dart';
import 'package:saveat/data/appData.dart';
import 'package:saveat/routes/route.dart';
import 'package:saveat/scopedModel/myScopedModel.dart';
import 'package:saveat/widgets/categoryHorizontalScrollItem.dart';
import 'package:scoped_model/scoped_model.dart';

class RoundCategory extends StatelessWidget {
  final String userID;
  RoundCategory(this.userID, {Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final MyScopedModel catModel = MyScopedModel();
    catModel.fetchCategory();
    return Container(
        height: 110.0,
        child: ScopedModel<MyScopedModel>(
          model: catModel,
          child: Center(child: RoundCategoryScoped(userID)),
        ));
  }
}

class RoundCategoryScoped extends StatelessWidget {
  final String userID;
  RoundCategoryScoped(this.userID, {Key key}) : super(key: key);
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
      height: 110,
      child: ListView.builder(
        itemCount: model.categories.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int i) {
          return GestureDetector(
              onTap: () {
                MyRoute.goToProductByCategory(
                    context, model.categories[i].name, userID);
              },
              child: CategoryHorizontalScrollItem(
                categoryImage: AppData.URl + model.categories[i].image,
                categoryName: model.categories[i].name,
              ));
        },
      ),
    );
    // return Container(
    //   height: 150.0,
    //   child: Column(
    //     children: <Widget>[
    //       Container(
    //         height: 100,
    //         child: ListView.builder(
    //           itemCount: model.categories.length,
    //           scrollDirection: Axis.horizontal,
    //           itemBuilder: (BuildContext context, int i) {
    //             return GestureDetector(
    //               onTap: () {
    //                 MyRoute.goToProductByCategory(
    //                     context, model.categories[i].name);
    //               },
    //               child: Card(
    //                 elevation: 4.0,
    //                 child: Container(
    //                   width: 120.0,
    //                   child: Column(
    //                     mainAxisAlignment: MainAxisAlignment.center,
    //                     crossAxisAlignment: CrossAxisAlignment.center,
    //                     children: <Widget>[
    //                       Container(
    //                         height: 70.0,
    //                         width: 120.0,
    //                         child: FadeInImage(
    //                           fit: BoxFit.fill,
    //                           image: NetworkImage(
    //                               AppData.URl + model.categories[i].image),
    //                           placeholder: AssetImage('assets/loading.gif'),
    //                         ),
    //                       ),
    //                       Container(
    //                         alignment: Alignment.center,
    //                         height: 20.0,
    //                         child: MyTextView().myTextViewStatic(
    //                             0.0,
    //                             model.categories[i].name,
    //                             Colors.black,
    //                             14.0,
    //                             FontWeight.normal),
    //                       )
    //                     ],
    //                   ),
    //                 ),
    //               ),
    //             );
    //           },
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }
}
