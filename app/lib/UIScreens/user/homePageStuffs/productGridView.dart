import 'package:flutter/material.dart';
import 'package:saveat/scopedModel/myScopedModel.dart';
import 'package:saveat/widgets/myListView.dart';
import 'package:scoped_model/scoped_model.dart';

class ProductGridView extends StatelessWidget {
  final String userID;
  ProductGridView(this.userID, {Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final MyScopedModel proModel = MyScopedModel();
    proModel.fetchProducts();
    proModel.fetchFavourite(userID);
    return Center(
        child: ScopedModel<MyScopedModel>(
      model: proModel,
      child: ProductGridViewScoped(userID),
    ));
  }
}

class ProductGridViewScoped extends StatelessWidget {
  final String userID;
  ProductGridViewScoped(this.userID, {Key key}) : super(key: key);
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
